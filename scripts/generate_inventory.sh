#!/usr/bin/env bash
set -euo pipefail

TF_DIR="${1:-terraform}"
OUT_FILE="${2:-ansible/inventory.ini}"

pushd "$TF_DIR" > /dev/null

tfjson=$(terraform output -json)

popd > /dev/null

mkdir -p "$(dirname "$OUT_FILE")"

cat > "$OUT_FILE" <<EOF
[frontend]
EOF

echo "$tfjson" | jq -r '.frontend.value | "\(.public_ip) c8.local ansible_host=\(.public_ip) ansible_user=ec2-user"' >> "$OUT_FILE"

cat >> "$OUT_FILE" <<EOF

[backend]
EOF

echo "$tfjson" | jq -r '.backend.value | "\(.public_ip) u21.local ansible_host=\(.public_ip) ansible_user=ubuntu"' >> "$OUT_FILE"

cat >> "$OUT_FILE" <<'EOF'

[frontend:vars]
ansible_python_interpreter=/usr/bin/python3

[backend:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

echo "Wrote inventory to $OUT_FILE"
