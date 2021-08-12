#!/bin/bash
set -euo pipefail

REQUESTHEADER_CLIENT_CA_FILE="$(kubectl get configmap -n kube-system extension-apiserver-authentication -o 'jsonpath={.data.requestheader-client-ca-file}' | sed 's/^/    /')"
CLIENT_CA_FILE="$(kubectl get configmap -n kube-system extension-apiserver-authentication -o 'jsonpath={.data.client-ca-file}' | sed 's/^/    /')"
OUTPUT="config/certs/parent-certs.configmap.yaml"

echo "Writing $OUTPUT"
cat > "$OUTPUT" <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: parent-certs
data:
  requestheader-client-ca-file: |
${REQUESTHEADER_CLIENT_CA_FILE}
  client-ca-file: |
${CLIENT_CA_FILE}
EOF
