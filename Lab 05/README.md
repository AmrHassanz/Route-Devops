# Ansible LAMP Stack Deployment (Lab 05)

This project automates the deployment of a LAMP stack (Linux, Apache, MySQL, PHP) across multiple servers using **Ansible**.

---

## 📦 Setup Instructions

### 1. Clone the repository
Clone the repository to your local machine:
```bash
git clone https://github.com/AmrHassanz/Route-Devops.git
cd "Route-Devops/Lab 05"
```

### 2. Install Ansible
If Ansible is not already installed, you can install it with the following command:
```bash
sudo apt install ansible -y
```

---

## 📁 Inventory Structure

Your inventory files are organized into different environments (Development and Production). The basic structure is as follows:

**Development Inventory (`inventories/dev/inventory.ini`)**
```ini
[web]
web1 ansible_host=192.168.1.80 ansible_user=ubuntu

[db]
db1 ansible_host=192.168.1.81 ansible_user=ubuntu
```

**Production Inventory (`inventories/prod/inventory.ini`)**
```ini
[web]
web1 ansible_host=192.168.1.80 ansible_user=ubuntu

[db]
db1 ansible_host=192.168.1.81 ansible_user=ubuntu
```

---

## ▶️ Steps to Run the Playbook

To deploy the LAMP stack, run the following commands:

### Development Environment
```bash
ansible-playbook -i inventories/dev/inventory.ini lamp_playbook.yml --vault-password-file=vault_password_file --ask-become-pass
```

### Production Environment
```bash
ansible-playbook -i inventories/prod/inventory.ini lamp_playbook.yml --vault-password-file=vault_password_file --ask-become-pass
```

- `--vault-password-file=vault_password_file`: Securely unlocks encrypted values in your playbooks.
- `--ask-become-pass`: Prompts for your sudo password to elevate privileges on the target machines.

---

## ⚙️ Notes on Error Handling and Structure

- **Roles:**  
  Each service (Apache, MySQL, PHP) is managed by its own role. Roles follow the standard structure: `tasks/`, `handlers/`, `templates/`, `vars/`, etc. This modular approach allows easy maintenance and customization.

- **Templates:**  
  Configuration files are dynamically generated using **Jinja2** templates and role variables. This ensures flexibility and easy updates to configurations.

- **Idempotency:**  
  Ansible playbooks are designed to be idempotent, meaning running the playbook multiple times will not cause unintended changes or errors.

- **Vault:**  
  Sensitive data such as MySQL root passwords can be stored securely using **Ansible Vault**. Ensure the `vault_password_file` exists and is secured. You can create encrypted files with `ansible-vault create` and manage them using `ansible-vault edit`.

---
