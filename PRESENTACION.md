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

- 3 tiendas con ubicaciones locales: CABA, Córdoba y Mendoza
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

## 4. Cómo explicar el proyecto en una demo

1. Mostrar `workflow_settings.yaml` para explicar la convención de datasets compartidos.
2. Mostrar `setup.sql` y señalar que carga una base de prueba bajo `raw_data`.
3. Abrir `stg_sales.sqlx` y describir la limpieza y el filtro de registros inválidos.
4. Abrir `sales_enriched.sqlx` para explicar joins con tiendas y catálogo y la lógica de net_sales y gross_margin.
5. Mostrar `mart_monthly_sales` y `mart_inventory_replenishment` para conectar la capa técnica con decisiones de negocio.
6. Referenciar la prueba de calidad y las assertions como una capa de gobernanza del dato.

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

## 8. Recomendación final

Este proyecto funciona bien como caso de portfolio porque combina tres elementos: negocio claro, arquitectura reproducible y una narrativa fácil de comunicar. La clave es presentarlo como una solución práctica de analítica comercial, no como un conjunto de tablas aisladas.