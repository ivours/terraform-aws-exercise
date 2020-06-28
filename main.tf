module "network" {
  source             = "./modules/platform/network"
  vpc_cidr_block     = var.vpc_cidr_block
  new_bits           = var.new_bits
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.az_count) 
}

module "my-web-app" {
  source           = "./modules/business-units/my-web-app"
  vpc_id           = module.network.vpc_id
  vpc_cidr_block   = var.vpc_cidr_block
  nginx_subnet_id  = module.network.private_subnets_ids[0]
  apache_subnet_id = module.network.private_subnets_ids[1]
}