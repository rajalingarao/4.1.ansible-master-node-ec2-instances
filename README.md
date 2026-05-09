* We will ansible software on master node, won't install on agent node.

ansible -i <agent-IP>, all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ping
```
ansible -i 44.207.6.148, all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ping
```
```
ansible -i inventory.ini all -e ansible_user=ec2-user -e ansible_password=DevOps321 -m ping, here inventory.init is not working.
```
```
ansible-playbook -i inventory.ini -e ansible_user=ec2-user -e ansible_password=DevOps321 01-ping.yaml 
```

inventory.ini 
# This is un-listed servers.
119.81.92.511
125.23.42.421

[web]  # this is web group
172.31.16.150
172.31.16.151
172.31.16.152


