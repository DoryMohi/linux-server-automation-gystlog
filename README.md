# 🐧 Debian Server Infrastructure & Automation (GystLog Web Hosting)

A production-grade Linux server environment built on Debian 13 (Trixie), featuring an Nginx web server, containerized PostgreSQL database via Docker, strict multi-user POSIX access control, automated shell monitoring with Telegram alerting, and scheduled log rotation.

---

## 📌 Project Overview

This project simulates the complete system administration lifecycle for **GystLog**, a web hosting infrastructure:

* **OS Platform:** Debian 13 (Trixie) running minimal server configuration on ARM64 / QEMU.
* **Web Server:** Nginx configured with custom document root and access permissions.
* **Database Layer:** PostgreSQL 17 containerized using Docker Engine and isolated bridge networks.
* **User & Security Management:** Principle of Least Privilege enforcing role separation (`admin`, `dev`, `support`), group permissions (`webteam`, `supportteam`), sticky bits (`1770`), and `umask 027`.
* **Automation & Monitoring:** Bash scripts for CPU/RAM/Disk metrics, automated Telegram bot alerts upon exceeding thresholds (80%), cron job scheduling, and log rotation archiving.

---

## 🛠️ Tech Stack & Systems Tools

* **Operating System:** Debian GNU/Linux 13 (Trixie)
* **Web Server:** Nginx
* **Containerization:** Docker Engine & Docker Bridge Networks (`gystlog_network`)
* **Database:** PostgreSQL 17 (Dockerized)
* **Scripting & Shell:** Bash (`top`, `free`, `df`, `awk`, `sed`, `curl`, `tar`, `gzip`)
* **Automation & Monitoring:** Cron daemon, Telegram Bot API

---

## ⚙️ Key Implementation Modules

### 1. User Access & POSIX Permissions
* Structured multi-user access across `admin`, `dev`, and `support` accounts.
* Directory layout `/srv/gystlog/` enforcing mode `770` for web development, sticky bit `1770` for shared exchange, and `750` for logs.
* Configured symbolic links (`~dev/web_link` → `/srv/gystlog/web`) demonstrating Unix directory aliasing.

### 2. Containerized Services (Docker & PostgreSQL)
* Custom Docker network (`gystlog_network`) isolating internal communication.
* Persistent storage setup and port mapping (`5432:5432`) for PostgreSQL administrative access.
* Custom Nginx container built via `Dockerfile`.

### 3. Automated Monitoring & Alerts
* `disk_monitor.sh`: Collects real-time CPU, RAM, and Disk metrics every 5 minutes via `crontab`.
* Sends automated warnings to an administrator's Telegram chat via Telegram Bot API when disk usage surpasses 80%.
* `log_rotate.sh`: Archives, compresses (`tar.gz`), and manages retention for system/Nginx log files.

---

## 📁 Repository Structure

* `scripts/docker_install.sh` — Shell script automating Docker Engine installation.
* `scripts/user_setup.sh` — Script for user, group, and `.bashrc` alias provisioning.
* `scripts/directory_setup.sh` — Provisioning script for `/srv/gystlog/` directory permissions and symlinks.
* `scripts/disk_monitor.sh` — System monitoring script integrated with Telegram API.
* `scripts/log_rotate.sh` — Automated log archiving and retention script.
* `docker/Dockerfile` — Nginx container build configuration.

---

## 🎓 Academic Context

Developed for the **Operating Systems** (5COSC041C) module coursework at Westminster International University in Tashkent.
