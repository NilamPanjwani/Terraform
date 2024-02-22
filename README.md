To get the DNS name of the load balancer you can get it either from AWS management console by navigating to EC2 services --> Load Balancers --> select the right ALB --> Description --> you can see DNS name.
Or you can find the DNS name from AWS CLI by specifying right values in the below command-
aws elbv2 describe-load-balancers --load-balancer-arns arn:aws:elasticloadbalancing:region:account-id:loadbalancer/load-balancer-name


To make the code work in Test, Staging and Production environment, I have successfully created CI/CD pipline with control checks like incorporating 'terraform format', 'terraform validate' on triggers like push to remote repository and 2 code reviews and 'terraform plan' on triggers when PR is created and finally 'terraform apply' when the PR is merged.
