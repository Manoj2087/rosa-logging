## loki-operator Helm chart

Installs the **Grafana Loki Operator** on OpenShift via OLM by creating:

- `Namespace` (optional)
- `OperatorGroup`
- `Subscription`

### Install

```bash
helm upgrade --install loki-operator ./helm/loki-operator
```

### Common overrides

Install into a custom namespace (and create Namespace + OperatorGroup):

```bash
helm upgrade --install loki-operator ./helm/loki-operator \
  --set installNamespace=loki-operator \
  --set createNamespace=true \
  --set operatorGroup.create=true
```

Use a specific channel / manual approval:

```bash
helm upgrade --install loki-operator ./helm/loki-operator \
  --set subscription.channel=stable \
  --set subscription.installPlanApproval=Manual
```

Pin `startingCSV` (optional):

```bash
helm upgrade --install loki-operator ./helm/loki-operator \
  --set subscription.startingCSV=loki-operator.vX.Y.Z
```
