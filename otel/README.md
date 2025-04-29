# OTEL: OpenTelemetry

Open-source project to:
- collect
- process
- export 
telemetry data, like:
- **logs**: text records of events: useful for specific occurences but not overal system healths or prediction
- **metrics**: Numerical data on system state and resource use.
- **traces**: Tracing a reques across services: most detailed in localising errors.

## Benefits

| to enable effective observability by making **high-quality, portable** telemetry ubiquitous.

- Unified telemetry (nodejs front, java back, mysql) for finding connections and understand problems
- Vendor-agnostic: reduce lock-in
- Consistent across projects, jobs
- Built-in obeservability for libraries and services

## OTEL Concepts
Signal, context,semantic conventions

Signals:
- logs
- metrics
- traces

Context:
- when
- where
- what

Semantic Conventions:
- standardized naming for seamless analysis, like:
  - service.name
  - http.request.method
  - db.query.text
  - user.id

## Components

- A spec for all components
- A standard protocol that defines the shape of telemetry data
- Language SDKs: that implement the spec
- A library ecosystem: implements instrumentation for common libraries and frameworks
- The OTEL Collector, a proxy that receives, processeses and exports telemetry data


## Slow Image flag

Slow images are simulated by adding http headers fron the nodejs fronten, while refering to static images served through the fontend-proxy (linker)

As cloudflare tunnel is used to expose otel-demo running on iximiuz labs,
cacheing is switched on by default. To clear cache for 1 url:
```
cf-clear-cache   https://otel.k3z.eu/images/products/RedFlashlight.jpg
```

After that 
``

curl  https://otel.k3z.eu/images/products/RedFlashlight.jpg -o x.jpg -H "Cache-Control: no-cache" -H "x-envoy-fault-delay-request: 3000"
```

### Slow image implementation

Implementation code for the demo: https://github.com/open-telemetry/opentelemetry-demo/pull/1733/files

Envoy docs: search for **x-envoy-fault-delay-request** https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/fault_filter

in kubernetes there is a configmap storing available values:
```
kubectl -n otel get cm flagd-config -o yaml \
  | yq '.data."demo.flagd.json"' \
  | jq .flags.imageSlowLoad
```

## frontend API

All api routes: https://github.com/open-telemetry/opentelemetry-demo/blob/main/src/frontend/gateways/Api.gateway.ts


- products:
    curl -s "http://otel.lufi.lol/api/products"|jq '.[]|[.id,.priceUsd.units,.name,.categories]' -c`
- specific product:
    curl -s "http://otel.lufi.lol/api/products/OLJCESPC7Z"
- recommendations:
    curl -s "http://otel.lufi.lol/api/recommendations?productIds=2ZYFJ3GM2N"|jq '.[]|[.id,.name]' -c
- show ads:
    curl "http://otel.lufi.lol/api/data?contextKeys=binoculars"

## Links

[opentelemetry-demo helm-chart](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-demo)

## Flags
- https://opentelemetry.io/docs/demo/feature-flags/
- all flags: https://github.com/open-telemetry/opentelemetry-demo/blob/1227f208e9d2c666be664738a6f46e584648ae60/src/flagd/demo.flagd.json


- catalog failure:  
  - https://github.com/open-telemetry/opentelemetry-demo/blob/1227f208e9d2c666be664738a6f46e584648ae60/src/product-catalog/main.go#L337C12-L337C22
  - check: curl -s "http://otel.lufi.lol/api/products/OLJCESPC7Z"