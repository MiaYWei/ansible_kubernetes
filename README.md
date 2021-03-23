# Project Title

SYSC5804 5G Neworks Project

## Objective

The objective of the projetc is using Ansible automation tool to deploy and configure Kubernetes cluster 

These instructions will get you a copy of the project up and running on your local machine for development purposes.

## Related Tools and Software

* [Ansible](https://docs.ansible.com/ansible/latest/index.html) - Ansible Tool
* [Kubernetes](https://kubernetes.io/docs/home/) - Kubernetes Cluster
* Google Cloud Platform

### Test Environment

* Linux OS: CentOS Linux release 7.9.2009 (Core)
* VMs deployed on Google Cloud Platform
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/GoogleCloudPlatform.jpg)

### Network Topology

![image](https://github.com/MiaYWei/ansible_kubernetes/blob/readme/images/topology.jpg)
```
Ansible Server:
  10.128.0.30
Kubernetes Clusters: 
  10.128.0.32 k8s-master
  10.128.0.33 k8s-node-1
  10.128.0.34 k8s-node-2
  10.128.0.35 k8s-node-3
  10.128.0.36 k8s-node-4
Pods Addresses: 10.244.0.0./16
```

### Ansible Installation and Configuration

#### 1. Install Ansible Server (10.128.0.30)
Install ansible tool 
```
  sudo yum install epel-release
  sudo yum install ansible
  ansible --version
```
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/ansible.jpg)

#### 2. Configure Ansible Inventory (/etc/ansible/hosts)
```
  sudo vi /etc/ansible/hosts
	[k8s-all]
	10.128.0.32
	10.128.0.33
	10.128.0.34
	10.128.0.35
	10.128.0.36
	[k8s-master]
	k8s-master
	[k8s-nodes]
	k8s-node-1
	k8s-node-2
	k8s-node-3
	k8s-node-4
```

#### 3. SSH Connection for password less authentication

##### 3.1 SSH configuration on all the nodes (10.28.0.30; 10.28.0.32/33/34/35/36)
```
  vim /etc/ssh/sshd_config    
	• PasswordAuthentication yes 
	• PermitRootLogin yes
  sudo systemctl restart sshd
```

##### 3.2 Generate ssh key on ansible node
```
  ssh-keygen
```

##### 3.3 Copy ssh key from ansile node to all the nodes 
```
  ssh-copy-id -i ~/.ssh/id_rsa.pub 10.128.0.32
  ssh-copy-id -i ~/.ssh/id_rsa.pub 10.128.0.33
  ssh-copy-id -i ~/.ssh/id_rsa.pub 10.128.0.34
  ssh-copy-id -i ~/.ssh/id_rsa.pub 10.128.0.35
  ssh-copy-id -i ~/.ssh/id_rsa.pub 10.128.0.36
```

##### 3.4 Check Connectivity  
```
  ansible -m ping all
```
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/readme/images/ansible_ping.jpg)

## Ansible Playbooks
In our project, Ansible playbooks are implemented to

* Deploy Kubernetes cluster: master node and worker nodes
* Install, upgrade or downgrade software: Docker and kubectl and kubelet

```
  deploy_master_playbook.yml
  deploy_worker_playbook.yml
  install_docker_playbook.yml
  install_kube_playbook.yml
```

### 1. Upload playbooks to ansible server node
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/playbooks.jpg)

### 2. Deploy master node
```
  cd mia_playbook
  ansible-playbook deploy_master_playbook.yml
```
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/master.jpg)

### 3. Deploy worker nodes 
```
  ansible-playbook deploy_worker_playbook.yml
```
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/workers.jpg)

### 4. Install kubectl and kubelet 
```
  ansible-playbook deploy_kube_playbook.yml
```

### 5. Install Docker
```
  ansible-playbook deploy_docker_playbook.yml
```
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/docker.jpg)

### 6. Check the deployment status
![image](https://github.com/MiaYWei/ansible_kubernetes/blob/main/images/nodes.jpg)
![image](https://github.com/MiaYWei/ansible_kubernetes/tree/main/images/pods.jpg)

## Authors

* **Mia Wei** - *Initial work*

See also [Mengyao Wu](https://github.com/MengyaoWuNotAvailable/jetson_ML_container_collection) who participated in this project for ML part.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
* etc

