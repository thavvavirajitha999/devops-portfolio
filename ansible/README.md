# Creating two roles:
Installing ssm agent
Installing cloudwatch agent and publishing metrics to cloudwatch

# Role Structure
roles/
  ssm_agent/
    tasks/main.yml
    handlers/main.yml

  cloudwatch_agent/
    tasks/main.yml
    handlers/main.yml
    templates/config.json.j2

# Role 1: ssm_agent
1. tasks/main.yml

# --- Linux ---
- name: Download SSM Agent RPM
get_url:
  url: "https://amazon-ssm-agent.s3.us-east-1.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm"
  dest: "/tmp/amazon-ssm-agent.rpm"

- name: Install SSM Agent RPM
yum:
  name: /tmp/amazon-ssm-agent.rpm
  state: present

- name: Enable and start SSM Agent
service:
  name: amazon-ssm-agent
  state: started
  enabled: yes
when: ansible_os_family == "RedHat"

- name: Install SSM Agent (Debian/Ubuntu)
  apt:
    name: amazon-ssm-agent
    state: latest
  when: ansible_os_family == "Debian"

- name: Enable and start SSM Agent (Linux)
  service:
    name: amazon-ssm-agent
    state: started
    enabled: yes
  when: ansible_os_family in ["RedHat", "Debian"]

# --- Windows ---
- name: Download SSM Agent MSI
  win_get_url:
    url: https://s3.amazonaws.com/amazon-ssm-agent/latest/windows_amd64/AmazonSSMAgentSetup.msi
    dest: C:\Temp\AmazonSSMAgentSetup.msi
  when: ansible_os_family == "Windows"

- name: Install SSM Agent (Windows)
  win_package:
    path: C:\Temp\AmazonSSMAgentSetup.msi
    state: present
  when: ansible_os_family == "Windows"

- name: Ensure SSM Agent service is running (Windows)
  win_service:
    name: AmazonSSMAgent
    start_mode: auto
    state: started
  when: ansible_os_family == "Windows"


# Role 2: cloudwatch_agent
tasks/main.yml

# --- Linux ---
- name: Download CloudWatch Agent (Linux)
  get_url:
    url: https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/amazon-cloudwatch-agent.rpm
    dest: /tmp/amazon-cloudwatch-agent.rpm
  when: ansible_os_family == "RedHat"

- name: Install CloudWatch Agent (Linux)
  yum:
    name: /tmp/amazon-cloudwatch-agent.rpm
    state: present
  when: ansible_os_family == "RedHat"

- name: Enable and start CloudWatch Agent (Linux)
  service:
    name: amazon-cloudwatch-agent
    state: started
    enabled: yes
  when: ansible_os_family in ["RedHat", "Debian"]

# --- Windows ---
- name: Download CloudWatch Agent MSI
  win_get_url:
    url: https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.msi
    dest: C:\Temp\AmazonCloudWatchAgent.msi
  when: ansible_os_family == "Windows"

- name: Install CloudWatch Agent (Windows)
  win_package:
    path: C:\Temp\AmazonCloudWatchAgent.msi
    state: present
  when: ansible_os_family == "Windows"

- name: Ensure CloudWatch Agent service is running (Windows)
  win_service:
    name: AmazonCloudWatchAgent
    start_mode: auto
    state: started
  when: ansible_os_family == "Windows"

- name: Deploy CloudWatch Agent config (Linux only)
  template:
    src: config.json.j2
    dest: /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
  notify: Restart CloudWatch Agent
  when: ansible_os_family in ["RedHat", "Debian"]

# Handler:
handlers/main.yml
yaml
- name: Restart CloudWatch Agent
  service:
    name: amazon-cloudwatch-agent
    state: restarted

# Ignore this step in free tier
# Config Template
templates/config.json.j2

# This is the CloudWatch Agent config that defines which metrics to publish (CPU, memory, disk, etc.):

# (this is custome metrics so it will be chraged in free tier so ignore this step)
json
{
  "metrics": {
    "append_dimensions": {
      "InstanceId": "${aws:InstanceId}"
    },
    "metrics_collected": {
      "cpu": {
        "measurement": ["usage_idle", "usage_system", "usage_user"],
        "metrics_collection_interval": 60
      },
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 60
      },
      "disk": {
        "measurement": ["used_percent"],
        "metrics_collection_interval": 60,
        "resources": ["*"]
      }
    }
  }
}

# Playbook Using Both Roles

- hosts: ec2
  become: yes
  roles:
    - ssm_agent
    - cloudwatch_agent

# Execution Flow
Linux EC2 → installs agents via yum/apt, starts services.

Windows EC2 → downloads MSI installers, installs via win_package, ensures services are running.

CloudWatch Agent publishes metrics (CPU, memory, disk) → you can create alarms in AWS.

SSM Agent ensures you can manage both Linux and Windows EC2s via Systems Manager.
=========================================================================================

# Deployment:

Create ec2 for Ansible host
Install Ansible

Connect to the ansible host
1. Create the ssm_agent role

# ansible-galaxy init ssm_agent

This will generate the full role skeleton under roles/ssm_agent/.

Then, inside that folder, you’ll edit:

bash
roles/ssm_agent/tasks/main.yml
roles/ssm_agent/handlers/main.yml

2. Create the cloudwatch_agent role

# ansible-galaxy init cloudwatch_agent

This will generate the full role skeleton under roles/cloudwatch_agent/.

Then, inside that folder, you’ll edit:

bash
roles/cloudwatch_agent/tasks/main.yml
roles/cloudwatch_agent/handlers/main.yml
roles/cloudwatch_agent/templates/config.json.j2

# Resulting Structure
After running those commands and adding your files, you’ll have:

Code
roles/
  ssm_agent/
    tasks/main.yml
    handlers/main.yml
    defaults/main.yml
    vars/main.yml
    meta/main.yml
    files/
    templates/
    tests/
    README.md

  cloudwatch_agent/
    tasks/main.yml
    handlers/main.yml
    templates/config.json.j2
    defaults/main.yml
    vars/main.yml
    meta/main.yml
    files/
    tests/
    README.md
========================================================================================
Create targets to install the ssm and cw agent
if they are linux install python inside them, winrm for windows
provide the public ips inside the inventory file
Generate or use an SSH key pair

# Adding master key to target
On your local machine (Ansible master):


ssh-keygen -t rsa -b 4096 -f ~/.ssh/mykey
cat cat ~/.ssh/mykey.pub
copy the key
in target
~/.ssh/authorized_keys
paste the public key


# Configure Security Group

Allow inbound SSH (port 22) from your Ansible master’s IP.

# Test SSH login
ssh -i ~/.ssh/mykey.pem ec2-user@<EC2_PUBLIC_IP>

========================================================================================
# Create playbook
vi install_agents.yaml

paste:

- hosts: ec2
  become: yes
  roles:
    - ssm_agent
    - cloudwatch_agent

# Create inventory file
vi inventory.ini

paste:

[linux_ec2]
ec2-linux ansible_host=54.210.123.45 ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/mykey.pem

[windows_ec2]
ec2-windows ansible_host=3.92.45.67 ansible_user=Administrator ansible_password=YourPassword ansible_connection=winrm ansible_winrm_transport=basic

[ec2:children]
linux_ec2
windows_ec2


# Runplay book

ansible-playbook -i inventory.ini install_agents.yaml


