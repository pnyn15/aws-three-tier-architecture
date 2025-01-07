resource "aws_instance" "public_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = [var.web_tier_sg]
  associate_public_ip_address = true
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_role_name


}

resource "aws_instance" "private_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnets[0]
  vpc_security_group_ids      = [var.apptier_sg]
  associate_public_ip_address = false
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_role_name

}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mydb_instance" {
  engine                    = "mysql"
  instance_class            = var.db_instance_class
  allocated_storage         = 15
  db_subnet_group_name      = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids    = [var.db_sg]
  username                  = var.username
  password                  = var.password
  db_name                   = "mydb"
  multi_az                  = false
  publicly_accessible       = false
  storage_type              = "gp2"
  skip_final_snapshot       = var.skip_final_snapshot
}
