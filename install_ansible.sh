#!/bin/bash

echo "************ansible-installation - start*************"
dnf install ansible -y
echo "************ansible-installation - end*************"
ansible --version
echo "**********Ansible Version*****************8"