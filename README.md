# OKE Admission Control Webhook For Network POC
## Requirement:
 We need implement a policy requested by security team that kubernetes service should have an annotation : service.beta.kubernetes.io/oci-load-balancer-security-list-management-mode: None
Thus no security list will be upated by kuernetes. This is an example that how we build our own admission controller which implements various policies from security or other teams. ie we can add only internal loadbalancer is allowed for internal service.....etc
## Solution:
* git clone https://github.com/HenryXie1/oke-admission-webhook
* go build -o oke-admission-webhook
* docker build --no-cache -t repo-url/oke-admission-webhook:v1 .
* rm -rf oke-admission-webhook
* docker push repo-url/oke-admission-webhook:v1
* ./deployment/webhook-create-signed-cert.sh --service oke-admission-webhook-svc --namespace kube-system --secret oke-admission-webhook-secret
* kubectl replace --force -f deployment/validatingwebhook.yaml
* kubectl replace --force -f deployment/deployment.yaml
* kubectl replace --force -f deployment/service.yaml
## Test:
* kubectl create -f  deployment/test-service.yaml 
  * Below error shall popup
```
Error from server (required annotations value are not set): error when creating "deployment/test-service.yaml": admission webhook "oke-validation-webhook.oracle.com" denied the request: required annotations value are not set
```
* Remove belowcomment of annotation in test-service.yaml, the error shall be gone
```
#annotations:
 #   service.beta.kubernetes.io/oci-load-balancer-security-list-management-mode: None
 ```
