#!/bin/bash
set -euo pipefail

KUBECONFIG="$(sudo kind get kubeconfig --internal | sed 's/^/    /')"
OUTPUT="config/certs/parent-kubeconfig.secret.yaml"

echo "Writing $OUTPUT"
cat > "$OUTPUT" <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: parent-kubeconfig
stringData:
  kubeconfig: |
${KUBECONFIG}
EOF
