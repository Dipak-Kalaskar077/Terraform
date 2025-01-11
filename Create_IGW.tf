resource "aws_internet_gateway" "Dipak_IGW" {
  vpc_id = aws_vpc.Dipak_VPC.id

  tags = {
    Name = "Dipak_IGW"
  }
}