# terraform_source

# CLI vela create yaml
vela def init cce-eip-vpc --type component  --provider huawei --desc huawei-cce-eip-vpc --git https://github.com/zyc839/huawei-terraform-source.git --path cce-vpc-eip-nginx -o cce-vpc-eipyaml

# CLI vela apply component
vela def apply cce-vpc-eip.yaml -n vela-system