# Introduction

# What is Observability?

- Ability to infer internal system state from external outputs
- Built around three pillars:
    - 📊 Metrics
    - 📄 Logs
    - 📈 Traces
- More than monitoring: it's about deep system understanding

---

# Why Observability Matters

- Complex, distributed systems need deep insights
- Faster incident detection and resolution
- Root cause analysis becomes easier
- Improves system reliability and customer satisfaction

---

# The Three Pillars of Observability

- 📊 **Metrics**: numerical data over time
- 📄 **Logs**: detailed event records
- 📈 **Traces**: journeys of individual requests
- **Pillars complement each other, not replace each other**

---

# Metrics

- Lightweight, numerical time series
- Ideal for dashboards, alerting
- Examples:
    - CPU usage
    - HTTP request rates
    - Error counts

---

# Logs

- High-detail, rich event records
- Useful for postmortem analysis and debugging
- Examples:
    - Startup logs
    - Exceptions
    - User action events

---

# Traces

- Show the flow of requests across distributed services
- Useful for understanding dependencies and bottlenecks
- Key to troubleshooting microservices

---

# Our Observability Stack Today

- **Metrics**: Prometheus ➡️ Grafana
- **Logs**: Promtail ➡️ Loki ➡️ Grafana
- **Traces**: OpenTelemetry ➡️ Tempo/Jaeger ➡️ Grafana
- Unified view in Grafana

---

# Observability vs Monitoring

| Monitoring | Observability |
| --- | --- |
| Known failures | Unknown failures |
| Reactive | Proactive |
| Thresholds | Exploratory |
| Dashboards | System Understanding |

---

# What You Will Learn Today

- Set up Prometheus, Grafana, Loki, and OpenTelemetry
- Monitor Metrics
- Search Logs
- Analyze Traces
- Troubleshoot real-world issues effectively

---

# Let's Begin! 🚀

- Ensure Docker and Java are installed
- First stop: **Prometheus** and **Metrics Collection**

---