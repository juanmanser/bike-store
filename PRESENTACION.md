# Bike Store | Guía de presentación y extensión

Este proyecto demuestra cómo usar Dataform para construir un flujo de analítica retail con foco en ventas, margen y gestión de inventario. La idea es mostrar un caso claro de negocio, con una estructura reproducible y un modelo que puede ampliarse sin romper dependencias.

## 1. Objetivo del caso

Bike Store responde una necesidad típica de retail:

- entender cómo se comportan las ventas por tienda, categoría y mes
- medir margen bruto real sobre cada transacción
- detectar productos con riesgo de stock bajo
- validar la calidad de los datos antes de publicar métricas

## 2. Qué muestra el proyecto

El caso incluye:

- 5 tiendas con ubicaciones locales: CABA, Córdoba, Mendoza, Rosario y San Miguel de Tucumán
- catálogo de bicicletas y accesorios
- transacciones de ventas con descuento y fecha
- registros de inventario para evaluar reposición

Las tablas de ejemplo son pequeñas y deterministas, pero están diseñadas para reflejar un flujo real de analítica comercial.

## 3. Flujo de datos

1. `raw_data` contiene las tablas base.
2. `dataform_staging` limpia y normaliza nombres, claves y métricas.
3. `dataform_processing` enriquece ventas con tienda, categoría y margen bruto.
4. `dataform_marts` publica métricas de negocio y alertas operativas.
5. `dataform_assertions` valida reglas clave.

### Calidad de datos y reporting

La capa staging normaliza claves y textos y filtra registros inválidos. Dos assertions controlan la integridad de ventas, descuentos y montos; además, `stg_sales_test` valida la limpieza con escenarios de prueba.

Los marts publicados permiten analizar ventas, costos y rentabilidad por tienda y categoría, seguir su evolución mensual y detectar necesidades de reposición. Sus métricas y metadatos de negocio facilitan el consumo en herramientas de BI.

### Muestra: resumen por local

La siguiente muestra resume las métricas del dataset de ejemplo. Ventas netas y margen bruto se calculan con las mismas reglas de `mart_sales_by_store`.
Los importes están expresados en unidades monetarias del ejemplo; el setup no define una moneda.

| Local | Ciudad | Región | Órdenes | Unidades | Ventas netas | Margen bruto |
|---|---|---|---:|---:|---:|---:|
| Centro | CABA | Centro | 5 | 8 | 4.948,23 | 1.842,23 |
| Norte | Córdoba | Norte | 5 | 7 | 4.088,10 | 1.347,10 |
| Sur | Mendoza | Sur | 4 | 5 | 3.206,18 | 1.110,18 |
| Este | Rosario | Este | 4 | 6 | 4.049,08 | 1.342,08 |
| Oeste | San Miguel de Tucumán | Noroeste | 4 | 6 | 4.908,19 | 1.854,19 |
| **Total** |  |  | **22** | **32** | **21.199,78** | **7.495,78** |

### Cómo se incorporan los controles

| Capa / modelo | Control implementado | Resultado esperado |
|---|---|---|
| Staging: `stg_sales` | Normaliza IDs, reemplaza descuentos nulos por cero y filtra claves de línea nulas, cantidades no positivas, precios negativos y descuentos fuera de 0–1. | Ventas limpias y consistentes para el procesamiento. |
| Staging: productos e inventario | Filtra costos negativos o precios menores al costo, y existencias o puntos de reposición negativos. | Catálogo e inventario dentro de rangos válidos. |
| Assertions: `assert_valid_sales` y `assert_sales_discount_and_margin` | Comprueba claves requeridas, cantidades, descuentos y montos de venta dentro de reglas válidas. | Si encuentra filas que incumplen las reglas, la assertion reporta el problema en la ejecución. |
| Test: `stg_sales_test` | Prueba una venta con IDs en minúsculas y una línea con cantidad cero. | Verifica normalización a mayúsculas y descarte de la línea inválida. |

## 4. Cómo usar el proyecto con Dataform

1. Abrir el repositorio en el workspace de Dataform y revisar `workflow_settings.yaml` y las definiciones del proyecto.
2. Ejecutar `setup.sql` en BigQuery para crear y cargar las tablas de ejemplo en `raw_data`.
3. Compilar el workspace en Dataform y revisar que no haya errores ni dependencias pendientes.
4. Ejecutar el workflow. Dataform procesará las capas staging, processing y marts, además de las assertions configuradas.
5. Confirmar que las acciones finalizaron correctamente y consultar los resultados en `dataform_marts`, especialmente `mart_sales_by_store` y `mart_inventory_replenishment`.
6. Conectar los marts a una herramienta de BI o consultarlos directamente en BigQuery. Al cambiar los datos de entrada, volver a ejecutar el workflow.

## 5. Cómo extender el caso sin romper la cadena

El modelo es fácil de escalar si se mantienen tres principios:

- conservar los IDs de negocio estables
- mantener los nombres de columnas y tablas en la estructura actual
- modificar solo valores descriptivos como ciudad, región o nombre de tienda cuando haga falta

Ejemplos de extensión válidos:

- agregar más tiendas
- ampliar el catálogo de productos
- incorporar nuevas regiones
- crear un mart adicional por región o por canal

Ejemplos que sí conviene evitar sin planificar:

- cambiar IDs de tienda o producto
- renombrar columnas de la capa de staging sin ajustar downstream
- modificar la estructura de `ref()` entre modelos sin revisar dependencias

## 6. Decisiones de diseño

- `unit_cost` y `list_price` se mantienen como atributos del catálogo para generar margen.
- El inventario es una foto puntual del stock y no un ledger histórico.
- La regla de reposición es ilustrativa y útil para demostrar lógica operativa.
- Los datos son de demostración y no están pensados como una base estadística completa.

## 7. Mensaje para la audiencia

> Bike Store es un caso de analítica retail con Dataform: transforma transacciones de ventas y stock en métricas accionables para negocio, manteniendo trazabilidad, calidad y dependencias visibles en el pipeline.

