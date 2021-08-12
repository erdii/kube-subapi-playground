#!/bin/bash
set -euo pipefail

CLIENT_CA_FILE="$(kubectl get configmap -n kube-system extension-apiserver-authentication -o 'jsonpath={.data.requestheader-client-ca-file}' | sed 's/^/    /')"
OUTPUT="config/certs/parent-requestheaders.configmap.yaml"

echo "Writing $OUTPUT"
cat > "$OUTPUT" <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: parent-requestheaders
data:
  client-ca-file: |
${CLIENT_CA_FILE}
EOF
