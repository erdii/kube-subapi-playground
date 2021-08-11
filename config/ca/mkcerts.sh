#!/bin/sh

# Generate self signed root CA cert
openssl req -nodes -x509 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/C=US/ST=US/L=US/O=US/OU=root/CN=cluster.local/emailAddress=US"

CERT="$(cat ca.crt | base64 -w 0)"
KEY="$(cat ca.key | base64 -w 0)"

rm -f ca.crt ca.key

cat > ca.secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: ca-key-pair
  namespace: apiserver-test
data:
  tls.crt: ${CERT}
  tls.key: ${KEY}
EOF
