#!/usr/bin/env python3
import json
import os

# Path to terraform output
tf_output_path = os.path.join("..", "terraform", "inventory.json")

# Read terraform output JSON
with open(tf_output_path) as f:
        data = json.load(f)

frontend = data["frontend"]["value"]
backend = data["backend"]["value"]

# Write inventory in the ansible folder
with open("inventory.ini", "w") as f:
    f.write("[frontend]\n")
    f.write(f"{frontend['hostname']} ansible_host={frontend['public_ip']} ansible_user=ec2-user ansible_ssh_private_key_file=keys/ansible.pem\n\n")

    f.write("[backend]\n")
    f.write(f"{backend['hostname']} ansible_host={backend['public_ip']} ansible_user=ubuntu ansible_ssh_private_key_file=keys/ansible.pem ansible_port=22\n")

print("inventory.ini generated successfully!")
