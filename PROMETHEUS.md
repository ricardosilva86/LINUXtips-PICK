# Alertas do Prometheus 🚨

Este documento descreve os alertas do Prometheus utilizados no projeto.

## Alerta: Giropops-Senhas Down 🔴

**Arquivo:** `alert-app-down.yaml`

**Descrição:** Este alerta é acionado quando o serviço Giropops-Senhas está fora do ar por mais de 1 minuto.

**Manifesto:**
```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: giropops-senhas-rule
  namespace: monitoring
  labels:
    prometheus: k8s
    role: alert-rules
    app.kubernetes.io/name: kube-prometheus
    app.kubernetes.io/part-of: kube-prometheus
spec:
  groups:
    - name: giropops-senhas-rule
      rules:
        - alert: GiropopsSenhasDown
          expr: up{job="giropops-senhas"} == 0
          for: 1m
          labels:
            severity: critical
          annotations:
            summary: "Giropops-Senhas caiu"
            description: "Giropops-Senhas está fora do ar"
```

## Service Monitor: Giropops-Senhas 📡

**Arquivo:** `service-monitor-app.yaml`

**Descrição:** Este ServiceMonitor coleta métricas do serviço Giropops-Senhas a cada 30 segundos.

**Manifesto:**
```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: giropops-senhas
  namespace: monitoring
spec:
  endpoints:
    - interval: 30s
      port: web
    - interval: 30s
      port: http
  selector:
    matchLabels:
        app.kubernetes.io/instance: giropops-senhas
        app.kubernetes.io/name: giropops-senhas-chart
```