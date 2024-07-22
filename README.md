# Vagrant Flask Challenge

This project is a Vagrant-managed development environment for a Flask application. It automatically reloads Gunicorn and Nginx upon detecting changes in the project files. I have done this using Ansible.

## Prerequisites
- Git
- Vagrant
- VirtualBox
- requirements.txt
- Ansible

## Installation
Clone this repository:
```bash
git clone --branch ansible https://github.com/enbiyagoral/vagrant-flask-challenge.git
cd vagrant-flask-challenge
```

Start the Vagrant environment:

```bash
vagrant up
```

This will:

- Download the specified Vagrant box (ubuntu/jammy64).
- Set up the virtual machine with the configurations specified in the Vagrantfile.
- Run the provisioning script located at scripts/provision.sh.


### Ansible/playbook 

The playbook will:

- Install necessary packages
- Create virtual environment
- Install packages from requirements.txt
- Create and start Gunicorn Service
- Configure Nginx 
- Run health_chech.sh script
- watch_and_run.sh script

Start the watch_and_run.sh script in the background to monitor for changes.
