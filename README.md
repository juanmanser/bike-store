# Bike Store | Retail Analytics with Dataform

Bike Store es un caso de analítica retail orientado a medir ventas, margen y stock en una cadena de bicicletas y accesorios. El flujo transforma datos de tiendas, catálogo y ventas para responder preguntas de negocio clave y dejar una base reproducible para análisis y reporting.

## Business case

La cadena ficticia opera en cinco ubicaciones argentinas: CABA, Córdoba, Mendoza, Rosario y San Miguel de Tucumán. El objetivo es convertir datos transaccionales en métricas operativas útiles para:

- medir ventas por mes, tienda y categoría
- analizar margen bruto por línea de producto
- detectar productos que requieren reposición
- validar la calidad de las fuentes antes de publicar el dato

## Data model

La estructura está organizada por capas de Dataform:

- `raw_data`: tablas base de tiendas, productos, ventas e inventario
- `dataform_staging`: normalización, limpieza y validación inicial
- `dataform_processing`: ventas enriquecidas con margen y descuento
- `dataform_marts`: modelos de negocio para reporting y alertas
- `dataform_assertions`: validaciones de calidad y reglas de negocio

## Project structure

```text
bike_store/
├── workflow_settings.yaml
├── setup.sql
├── README.md
├── PRESENTACION.md
└── definitions/
    ├── sources/
    ├── staging/
    ├── processing/
    ├── marts/
    └── assertions/
```

## Data flow

```text
raw_data.stores
raw_data.products
raw_data.sales
raw_data.inventory
        ↓
  staging layer
        ↓
  processing layer
        ↓
  marts
```

Los modelos principales son:

- `stg_sales`, `stg_products`, `stg_stores` y `stg_inventory`: normalizan datos y filtran registros inválidos
- `sales_enriched`: une ventas, tienda y catálogo
- `mart_sales_by_store` y `mart_sales_by_store_category`: resumen de ventas, costos y rentabilidad
- `mart_monthly_sales`: evolución mensual de ventas y margen
- `mart_inventory_replenishment`: alertas de stock y cantidad sugerida de reposición

### Calidad de datos y reporting

La calidad se controla en varias capas: staging normaliza claves y textos y filtra valores inválidos; dos assertions verifican la integridad de ventas, descuentos y montos; y `stg_sales_test` comprueba la limpieza con datos de prueba. Los marts de ventas incluyen métricas y metadatos de negocio para facilitar su interpretación y uso en herramientas de BI.

## Usage

Desde la raíz del repositorio:

```powershell
npx.cmd --yes @dataform/cli@3.0.56 compile
```

También puede conectarse este repositorio a un workspace de Google Dataform y ejecutar las acciones desde la UI. La ejecución en BigQuery requiere permisos adecuados sobre el proyecto y los datasets.

## Notes

- `setup.sql` crea un conjunto pequeño y determinista para facilitar la demostración.
- Los IDs de negocio se mantienen estables para no romper dependencias entre modelos.
- Los valores descriptivos, como ciudad y región, pueden adaptarse sin afectar la lógica del pipeline.
- El proyecto está pensado como un caso reproducible y claro para portfolio, no como un entorno de producción real.