To make the code work in Test, Staging and Production environment, I have successfully created CI/CD pipline with control checks like incorporating 'terraform format', 
'terraform validate' on triggers like push to remote repository and 2 code reviews and 'terraform plan' on triggers when PR is created and finally 'terraform apply' when the PR is merged.
