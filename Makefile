up:
	terraform apply

down:
	terraform destroy

ssh:
	ssh -i $$(terraform output -raw ssh_key_filename) ubuntu@$$(terraform output -raw public_ip_address)