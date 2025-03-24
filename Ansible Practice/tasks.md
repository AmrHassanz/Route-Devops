# 🧪 Ansible Practice Tasks – Mixed Complexity

This document contains **5 practice tasks** for improving your Ansible playbook skills. Each task requires using features such as **loops, conditionals (`when`, `and`, `or`), with_items, modules, handlers**, and running **validations** (`--check`, `--diff`, `--syntax-check`, `ansible-lint`).

---

## 1️⃣ Task: User Creation Based on OS and Version

**Objective:**

Create a playbook that adds two users (`devuser` and `qauser`) **only** if:

- The target machine is using the `RedHat` OS family.
- The major version is **7 or higher**.

Use a loop to create the users and make sure the task **does not run** on Ubuntu or other distributions.

---

## 2️⃣ Task: Install Packages Using Loop with OR Condition

**Objective:**

Write a task that installs 3 packages (`htop`, `iftop`, `net-tools`) **only if** the distribution is either `CentOS` **or** `RedHat`.

- Use a loop to install the packages.
- Add condition using `or` to support both distributions.
- Include `--check` and `--diff` in your command to verify.

---

## 3️⃣ Task: Copy a Config File and Use Handlers

**Objective:**

Write a task that:

- Copies a config file (e.g., `nginx.conf`) to the correct path.
- If the file changes, it should **trigger a handler** to restart the related service (e.g., nginx).
- Use the `copy` module with `notify`.
- Use `--diff` to make sure you can see if the file would change during dry run.

---

## 4️⃣ Task: Ensure Service is Running Based on OS Version

**Objective:**

Create a task that starts and enables the `firewalld` service if:

- The system is `RedHat` with version >= 7 **OR**
- The system is `CentOS` with version >= 8

Use `when` with `and` + `or` logic properly.

---

## 5️⃣ Task: Ensure Log Directory Exists with Condition + Debug

**Objective:**

Write a task that:

- Ensures the directory `/var/log/myapp` exists with correct permissions.
- If the system is `Ubuntu`, display a debug message like “Log directory is in place!”.
- Use the `file` module + `debug` module.
- Add `--syntax-check` and `ansible-lint` before running the playbook.

---

## ✅ Validation Checklist

Use the following commands to verify your playbook before applying changes:

| Check Type         | Command                                         |
|--------------------|--------------------------------------------------|
| Syntax Check       | `ansible-playbook your_playbook.yml --syntax-check` |
| Dry Run (Check)    | `ansible-playbook your_playbook.yml --check`    |
| Show Diffs         | `ansible-playbook your_playbook.yml --diff`     |
| Linting            | `ansible-lint your_playbook.yml`                |

---

