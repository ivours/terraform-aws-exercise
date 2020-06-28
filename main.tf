module "network" {
  source             = "./modules/platform/network"
  vpc_cidr_block     = var.vpc_cidr_block
  new_bits           = var.new_bits
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.az_count) 
}