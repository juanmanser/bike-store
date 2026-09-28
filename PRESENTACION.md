# Guía interna de presentación: Bike Store

Documento de apoyo para explicar y demostrar el caso. No es necesario leerlo literalmente ni presentar el proyecto como un sistema de producción: es un ejemplo ELT con datos de demostración pequeños y controlados.

## 1. Resumen del caso

Una cadena ficticia de tres tiendas vende bicicletas y accesorios. El equipo necesita responder preguntas comerciales que las tablas operacionales no contestan directamente:

- ¿Cómo evolucionan las ventas y el margen por mes, tienda y categoría?
- ¿Qué productos están por debajo de su punto de reposición?
- ¿Cuánto conviene pedir para recuperar un nivel de stock objetivo?
- ¿Podemos confiar en las claves, cantidades y descuentos usados en esos indicadores?

El proyecto usa BigQuery como warehouse y Dataform para definir dependencias, transformar datos y validar calidad.

## 2. Alcance de la demostración

El setup genera un conjunto pequeño y reproducible:

- 3 tiendas en Madrid, Bilbao y Valencia.
- 5 productos entre bicicletas de montaña, ruta, urbanas y accesorios.
- 12 líneas de venta, distribuidas entre enero y junio de 2026.
- 8 registros de inventario para una fecha de corte.

Las filas están escritas de forma determinista para que la demostración sea repetible. No representan una operación real ni permiten inferir tendencias de mercado.

## 3. Recorrido de los datos

1. **Preparación de fuentes**: `setup.sql` crea el dataset `bike_store_raw` y carga `stores`, `products`, `sales` e `inventory`.
2. **Declaraciones**: `definitions/sources/raw_*.sqlx` registran esas tablas existentes en el grafo de Dataform. Las declaraciones no crean las tablas raw.
3. **Staging**: `definitions/staging/stg_*.sqlx` normalizan identificadores y textos, filtran cantidades/precios inválidos y estandarizan descuentos.
4. **Procesamiento de ventas**: `definitions/processing/sales_enriched.sqlx` une ventas con tienda y catálogo, y calcula venta bruta, descuento, venta neta, costo y margen bruto.
5. **Marts de negocio**:
   - `mart_monthly_sales`: pedidos, unidades, venta neta y margen por mes, tienda y categoría.
   - `mart_inventory_replenishment`: existencias, punto de reposición, indicador de reposición y cantidad sugerida.
6. **Calidad**: `stg_sales_test.sqlx` verifica que la vista de staging conserve una venta válida y excluya una con cantidad cero. `assert_valid_sales.sqlx` busca claves o métricas procesadas inválidas.
7. **Compilación y ejecución**: Dataform compila acciones y dependencias antes de ejecutar SQL. En esta demo, GitHub Actions solo compila; no ejecuta consultas en BigQuery.

## 4. Arquitectura

```text
BigQuery bike_store_raw
  ├── stores ───────> stg_stores ──────────────┐
  ├── products ─────> stg_products ────────────┼──> sales_enriched
  ├── sales ────────> stg_sales ───────────────┘       ├──> mart_monthly_sales
  └── inventory ────> stg_inventory + stg_stores/products
                                                    └──> mart_inventory_replenishment
                                                        assert_valid_sales
```

La carpeta `definitions/` organiza el trabajo por responsabilidad. Los `ref()` hacen explícitas las dependencias para que Dataform construya el orden de ejecución.

## 5. Guion de demo sugerido

1. Abrir `workflow_settings.yaml` y explicar el proyecto, ubicación y datasets separados para raw, staging, processing, marts y assertions.
2. Mostrar `setup.sql`: es deliberadamente pequeño; señalar que debe ejecutarse manualmente en BigQuery antes de las acciones dependientes.
3. Abrir `stg_sales.sqlx` y explicar la normalización y el filtro `quantity > 0`.
4. Abrir `sales_enriched.sqlx` y recorrer el join y las fórmulas de venta neta y margen.
5. Mostrar el grafo compilado de Dataform y seguir una línea desde `sales` hasta `mart_monthly_sales`.
6. Mostrar `mart_inventory_replenishment.sqlx` para explicar el punto de reposición y la cantidad sugerida.
7. Ejecutar la prueba unitaria de `stg_sales` en modo Unit tests y observar cómo se descarta la cantidad cero.
8. Si el entorno y permisos están preparados, ejecutar solo las acciones seleccionadas de bike_store y consultar los dos marts. No seleccionar proyectos o acciones ecommerce por error.

## 6. Mensaje para la audiencia

> Este caso transforma transacciones y existencias de tiendas de bicicletas en métricas de margen e inventario. Dataform mantiene las dependencias visibles, hace compilable el flujo y permite probar reglas de calidad antes de programar ejecuciones.

## 7. Decisiones y límites

- `unit_cost` y `list_price` son atributos actuales del catálogo; el ejemplo no modela cambios históricos de precio o costo.
- El inventario es una foto puntual, no un ledger de movimientos ni una serie histórica.
- La cantidad sugerida usa una regla ilustrativa: `max(2 × reorder_point − units_on_hand, 0)`. El objetivo no reemplaza pronósticos ni considera tiempos de entrega.
- `gross_margin` se calcula como venta neta menos costo de producto; no incluye impuestos, logística, salarios ni gastos de tienda.
- Los datos cubren seis meses y no son adecuados para conclusiones estadísticas.
- El `setup.sql` apunta explícitamente al proyecto `project-242e6158-c375-436e-aba` y ubicación `US`. Antes de usarlo en otro entorno, revisar ambos valores.
- No subir credenciales, tokens, archivos `.df-credentials.json` ni datos personales al repositorio público.
- Las pruebas de compilación no prueban permisos o disponibilidad de datasets en GCP. La ejecución de BigQuery requiere acceso y aprobación explícitos.