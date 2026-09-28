# Bike Store | Retail Analytics with Dataform

Bike Store es un caso de analítica retail orientado a medir ventas, margen y stock en una cadena de bicicletas y accesorios. El flujo transforma datos de tiendas, catálogo y ventas para responder preguntas de negocio clave y dejar una base reproducible para análisis y reporting.

## Business case

La cadena ficticia opera en tres ubicaciones argentinas: CABA, Córdoba y Mendoza. El objetivo es convertir datos transaccionales en métricas operativas útiles para:

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

- `stg_sales`: limpia y filtra ventas inválidas
- `sales_enriched`: une ventas, tienda y catálogo
- `mart_monthly_sales`: venta neta y margen por mes, tienda y categoría
- `mart_inventory_replenishment`: alertas de stock y sugerencia de reposición

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