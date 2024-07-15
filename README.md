# Vagrant Flask Challenge

This project is a Vagrant-managed development environment for a Flask application It automatically reloads Gunicorn and Nginx upon detecting changes in the project files.

## Prerequisites
- Git
- Vagrant
- VirtualBox
- requirements.txt

## Installation
Clone this repository:
```bash
git clone https://github.com/enbiyagoral/vagrant-flask-challenge.git
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


### Provisioning Script

The provision.sh script will:

Make all scripts in the scripts/ directory executable.
Execute the following scripts in order:
- setup.sh
- project_setup.sh
- gunicorn_service_setup.sh
- nginx_setup.sh
- health_check.sh

Start the watch_and_run.sh script in the background to monitor for changes.

After starting the Vagrant environment, access the application via your web browser using the IP address assigned by your network. For example, if the VM is assigned 192.168.1.100, you can access the application at:

```bash
http://192.168.1.100
```


