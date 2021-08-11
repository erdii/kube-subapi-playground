#!/bin/bash
set -euo pipefail

CLIENT_SECRET_NAME="client-tls"
OUTPUT="subeconfig"

CLIENT_TLS_KEY="$(kubectl get secret $CLIENT_SECRET_NAME -o 'jsonpath={.data.tls\.key}')"
CLIENT_TLS_CERT="$(kubectl get secret $CLIENT_SECRET_NAME -o 'jsonpath={.data.tls\.crt}')"
CA_CERT="$(kubectl get secret $CLIENT_SECRET_NAME -o 'jsonpath={.data.ca\.crt}')"

echo "Writing $OUTPUT"
cat > "$OUTPUT" <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${CA_CERT}
    server: https://127.0.0.1:6443
  name: subnetes
contexts:
- context:
    cluster: subnetes
    user: subnetes
  name: subnetes
current-context: subnetes
kind: Config
preferences: {}
users:
- name: subnetes
  user:
    client-certificate-data: ${CLIENT_TLS_CERT}
    client-key-data: ${CLIENT_TLS_KEY}
EOF
