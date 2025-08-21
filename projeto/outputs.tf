output "instance_ip" {
  value = aws_instance.ec2.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.mod_bucket.bucket
}

output "vpc_id" {
  value = aws_vpc.main.id
}
