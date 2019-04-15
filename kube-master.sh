apt-get update -y

sleep 5

swapoff -a

apt-get install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update -y

apt-get install docker-ce -y

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update -y

apt-get install kubelet kubeadm kubectl -y

kubeadm init | tail -3  > master-key.txt

mkdir -p $HOME/.kube

cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

chown $(id -u):$(id -g) $HOME/.kube/config

sleep 10

kubectl apply -f \
https://docs.projectcalico.org/v3.6/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

sleep 100

kubectl get nodes
