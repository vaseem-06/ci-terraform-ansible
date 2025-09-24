#!/usr/bin/env bash
set -euo pipefail

TF_DIR="${1:-terraform}"
OUT_FILE="${2:-ansible/inventory.ini}"
KEY_FILE="~/keys/ansible.pem"  # Path to your private key relative to ansible folder

# Enter Terraform directory
pushd "$TF_DIR" > /dev/null

# Get Terraform output in JSON
tfjson=$(terraform output -json)

popd > /dev/null

# Ensure the output directory exists
mkdir -p "$(dirname "$OUT_FILE")"

# Frontend section
cat > "$OUT_FILE" <<EOF
[frontend]
EOF

echo "$tfjson" | jq -r --arg key "$KEY_FILE" \
'.frontend.value | "\(.public_ip) ansible_host=\(.public_ip) ansible_user=ec2-user ansible_ssh_private_key_file=\($key)"' >> "$OUT_FILE"

# Backend section
cat >> "$OUT_FILE" <<EOF

[backend]
EOF

echo "$tfjson" | jq -r --arg key "$KEY_FILE" \
'.backend.value | "\(.public_ip) ansible_host=\(.public_ip) ansible_user=ubuntu ansible_ssh_private_key_file=\($key)"' >> "$OUT_FILE"

# Variables section
cat >> "$OUT_FILE" <<'EOF'

[frontend:vars]
ansible_python_interpreter=/usr/bin/python3

[backend:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

echo "Wrote inventory to $OUT_FILE"
