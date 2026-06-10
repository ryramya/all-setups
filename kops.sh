vim .bashrc
export PATH=$PATH:/usr/local/bin/
source .bashrc

#! /bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl
export KOPS_STATE_STORE=s3://ramya.ch.k8s
kops create cluster --name ramya.k8s.local --cloud=aws --zones eu-north-1c,eu-north-1b,eu-north-1a --control-plane-size c7i-flex.large --control-plane-count 1 --control-plane-volume-size 30 --node-size t3.small --node-count 2 --node-volume-size 20
kops update cluster --name ramya.k8s.local --yes --admin
