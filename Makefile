##############################################################################

TF_VAR_environment          ?= dev
AWS_DEFAULT_REGION          ?= eu-west-1

export

clean:
	rm -rf terraform/.terraform

init: clean
	cd terraform && \
		terraform init \
		-backend-config "region=$(AWS_DEFAULT_REGION)" 

plan:
	cd terraform && \
		terraform plan -no-color \
		-out /tmp/$(TF_VAR_environment).plan

apply:
	cd terraform && \
		terraform apply -auto-approve /tmp/$(TF_VAR_environment).plan

destroy:
	cd terraform && \
		terraform destroy -auto-approve

fmt_check:
	terraform fmt -check -recursive terraform/

validate:
	cd terraform && terraform validate

validate_no_backend: init_no_backend
	cd terraform && terraform validate

validate_modules:
	VALIDATE_ALL=true ./validate-modules.sh

# TODO: want to use tflint --deep?
lint:
	tflint terraform

security_analysis:
	tfsec --no-colour terraform
