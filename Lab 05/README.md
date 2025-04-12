# Ansible LAMP Stack Deployment (Lab 05)
This project automates the deployment of a LAMP stack (Linux, Apache, MySQL, PHP) across multiple servers using Ansible.

### Setup instructions ###
# 1- CLone the repo
git clone https://github.com/AmrHassanz/Route-Devops.git

cd "Route-Devops/Lab 05"

# 2- Install Ansible
sudo apt install ansible -y

### Inventory Structure ###
[Dev Inv]
    [web]
        web1 ansible_host=192.168.1.80 ansible_user=ubuntu
    [db]
        db1 ansible_host=192.168.1.81 ansible_user=ubuntu

[Production Inv]
    [web]
        web1 ansible_host=192.168.1.80 ansible_user=ubuntu

    [db]
        db1 ansible_host=192.168.1.81 ansible_user=ubuntu

### Steps to run the playbook ###
ansible-playbook -i inventories/dev/inventory.ini lamp_playbook.yml --vault-password-file=vault_password_file --ask-become-pass   # develpment
ansible-playbook -i inventories/prod/inventory.ini lamp_playbook.yml --vault-password-file=vault_password_file --ask-become-pass  # production

### Notes on error handling and structure ###
- **Roles:**  
  Each role (`apache`, `mysql`, `php`) is fully modular and reusable. They follow the standard role structure: `tasks/`, `handlers/`, `templates/`, `vars/`, etc.

- **Templates:**  
  Config files are dynamically generated using Jinja2 templates and role variables.

- **Idempotency:**  
  Playbooks are idempotent: running them multiple times won’t break your setup or produce duplicate effects.

- **Vault:**  
  Sensitive data like MySQL root passwords can be stored securely using `ansible-vault`. Ensure the `vault_password_file` exists and is secured.
