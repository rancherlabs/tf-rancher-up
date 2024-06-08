#!/bin/bash

PUBLIC_IP=$(curl ifconfig.io)

cat > /tmp/config.yaml <<EOF
token: ${rke2_token}
server: https://${server_ip}:9345
node-external-ip: $PUBLIC_IP
tls-san:
  - "$PUBLIC_IP"
  - "$PUBLIC_IP.sslip.io"
%{ if rke2_config != "false" }
${rke2_config}
%{ endif }
EOF

%{ if rke2_version != "false" }
export INSTALL_RKE2_VERSION=${rke2_version}
%{ endif }

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
mkdir -p /etc/rancher/rke2
cp /tmp/config.yaml /etc/rancher/rke2
systemctl enable rke2-agent.service
systemctl start rke2-agent.service

cat > /var/lib/rancher/rke2/server/manifests/rke2-ingress-nginx-config.yaml << EOF
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-ingress-nginx
  namespace: kube-system
spec:
  valuesContent: |-
    controller:
      admissionWebhooks:
        failurePolicy: Ignore
EOF

cat >> /etc/profile <<EOF
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
export CRI_CONFIG_FILE=/var/lib/rancher/rke2/agent/etc/crictl.yaml
PATH="$PATH:/var/lib/rancher/rke2/bin"
alias k=kubectl
EOF
