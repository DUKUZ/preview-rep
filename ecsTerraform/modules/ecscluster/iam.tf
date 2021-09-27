# Create IAM instance profile role



resource "aws_iam_instance_profile" "ECS_instance_profile" {
  name = "${var.name}-ECS_instance_profile"
  role = aws_iam_role.ECS_instance_iam_role.name
}


resource "aws_iam_role" "ECS_instance_iam_role" {
  name               = "${var.name}-ECS_instance_iam_role"
  path               = "/"
  assume_role_policy = templatefile("${path.module}/templates/iam_role.json.tpl", {})
}


resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerServiceforEC2Role" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


resource "aws_iam_role_policy_attachment" "AmazonEC2FullAccess" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


resource "aws_iam_role_policy_attachment" "ElasticLoadBalancingFullAccess" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
}


resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_role_policy_attachment" "AmazonKinesisVideoStreamsFullAccess" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisVideoStreamsFullAccess"
}


resource "aws_iam_role_policy_attachment" "AmazonECS_FullAccess" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonSSMFullAccess" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerServiceRole" {
  role       = aws_iam_role.ECS_instance_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
