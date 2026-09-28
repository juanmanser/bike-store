# Bike Store | Dataform ELT

Proyecto de analítica para una cadena ficticia de bicicletas y accesorios. El flujo parte de ventas, catálogo, tiendas e inventario; limpia las fuentes, calcula ventas y margen, y publica métricas mensuales y alertas de reposición.

## Estructura

```text
bike_store/
├── workflow_settings.yaml
├── setup.sql
└── definitions/
    ├── sources/       # Declaraciones BigQuery
    ├── staging/       # Normalización y prueba unitaria
    ├── processing/    # Ventas enriquecidas
    ├── marts/         # Ventas mensuales e inventario
    └── assertions/    # Reglas de calidad
```

## Modelo

- `bike_store_raw`: tablas de tiendas, productos, ventas e inventario.
- `bike_store_staging`: vistas con claves normalizadas y filas válidas.
- `bike_store_processing`: ventas con descuento, costo y margen bruto.
- `bike_store_marts`: ventas mensuales por tienda/categoría y sugerencias de reposición.
- `bike_store_assertions`: resultados de assertions de Dataform.

El setup contiene pocas filas deterministas para que el ejemplo sea reproducible y económico. Ejecuta `setup.sql` manualmente en BigQuery, con el proyecto `project-242e6158-c375-436e-aba` activo y ubicación `US`. El script solo crea el dataset de fuentes y cuatro tablas de datos de demostración.

## Desarrollo

Desde la raíz de este repositorio:

```powershell
npx.cmd --yes @dataform/cli@3.0.56 compile
```

En Google Dataform, conecta este repositorio Git como un repositorio Dataform independiente. La ejecución de acciones en BigQuery requiere que el servicio de Dataform tenga los permisos necesarios sobre el proyecto y los datasets.

El workflow de GitHub Actions compila en push y pull request; no ejecuta consultas ni modifica BigQuery.