# 🚀 DevOps Project: Terraform + Ansible + Netdata + Nginx Proxy


[![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com/)
[![Netdata](https://img.shields.io/badge/Netdata-1DA1F2?style=for-the-badge&logo=netdata&logoColor=white)](https://www.netdata.cloud/)


This project demonstrates provisioning **EC2 instances** using Terraform and configuring them with **Ansible** to deploy a monitoring setup:

- **Frontend group**: Amazon Linux EC2 running **Nginx** as a reverse proxy.
- **Backend group**: Ubuntu EC2 running **Netdata** on port `19999`.
- Optional: Multiple backend nodes can be load balanced via Nginx.

---

## 📂 Project Structure

<img width="476" height="415" alt="image" src="https://github.com/user-attachments/assets/865ab7c8-57d8-4852-bd89-062c2d0198c1" />

<img width="507" height="444" alt="image" src="https://github.com/user-attachments/assets/18d82a95-0ec2-406d-b1a2-a6dad443a5f9" />


├── terraform/ # Terraform code to provision EC2
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── ansible/ # Ansible automation
│ ├── inventory.ini
│ ├── site.yml
│ ├── roles/
│ │ ├── frontend/ # Nginx role
│ │ └── backend/ # Netdata role
└── README.md



---

## ⚙️ Tools Used

- **Terraform** → Provision AWS resources (VPC, EC2, Security Groups).
- **Ansible** → Configuration management (install Nginx, Netdata).
- **AWS EC2** → Cloud infrastructure.
- **Nginx** → Reverse proxy to Netdata.
- **Netdata** → Monitoring tool running on backend nodes.

---

## 🖥️ Infrastructure Setup

### 1. Provision EC2 with Terraform
```bash
cd terraform
terraform init
terraform apply -auto-approve



Terraform will:

Create 1 Amazon Linux (frontend) and 1 Ubuntu (backend) EC2.

Security groups allow SSH (22), HTTP (80), and Netdata (19999).


2. Configure with Ansible

Update your ansible/inventory.ini:

[frontend]
c8.local ansible_host=<frontend_public_ip> ansible_user=ec2-user

[backend]
u21.local ansible_host=<backend1_public_ip> ansible_user=ubuntu
u22.local ansible_host=<backend2_public_ip> ansible_user=ubuntu   # optional extra backend



Run the playbook:

cd ansible
ansible-playbook -i inventory.ini site.yml


📦 Ansible Roles
🔹 Frontend Role

Installs Nginx.

Configures reverse proxy:

upstream netdata_backends {
    server {{ hostvars['u21.local'].ansible_host }}:19999;
    server {{ hostvars['u22.local'].ansible_host }}:19999; # optional for load balancing
}

server {
    listen 80;
    location / {
        proxy_pass http://netdata_backends;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}


🔹 Backend Role

Installs prerequisites.

Installs Netdata from official script.

Ensures it runs on port 19999.



✅ Verification Steps
🔹 On backend (Ubuntu)

systemctl status netdata
ss -tulpn | grep 19999


🔹 On frontend (Amazon Linux)

systemctl status nginx
curl http://localhost


🔹 From Browser

Access Netdata dashboard:

http://<frontend_public_ip>


If multiple backends are added, Nginx load balances across them.

🎯 Key Learnings

Used Terraform for infra provisioning.

Used Ansible for configuration management.

Deployed Nginx reverse proxy.

Deployed Netdata monitoring backend.

Verified connectivity via curl and browser.

<img width="1920" height="887" alt="image" src="https://github.com/user-attachments/assets/2617f13f-a1e8-49bc-bd89-b93fa4987f34" />

<img width="1905" height="881" alt="image" src="https://github.com/user-attachments/assets/1c1c2bf6-5d85-4f7c-b9b7-e73a96cebb88" />

<img width="1092" height="879" alt="image" src="https://github.com/user-attachments/assets/1b40f25f-d544-4cb4-a468-353c3e979bb5" />


<img width="1920" height="881" alt="image" src="https://github.com/user-attachments/assets/9a81707e-6b68-43b8-b376-be825f7fdec2" />


🙌 Author

👤 Mohammad Imaran Khan
💼 DevOps Engineer
🌐 Skills: Terraform | Ansible | AWS | Linux | Nginx | Netdata | Jenkins | Kubernetes | Docker and so on....


