# terraform_source

# CLI vela create yaml
vela def init cce-eip-vpc-nginx --type component  --provider huawei --desc huawei-cce-eip-vpc-nginx --git https://github.com/zyc839/huawei-terraform-source.git --path cce-vpc-eip-nginx -o cce-vpc-eip-nginx.yaml

# CLI vela apply component
vela def apply cce-vpc-eip-nginx.yaml -n vela-system