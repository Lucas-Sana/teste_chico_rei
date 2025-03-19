# Use a base image with shell (e.g., alpine)
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache curl unzip bash

# Download and install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip && \
    unzip terraform_1.5.7_linux_amd64.zip -d /usr/local/bin && \
    rm terraform_1.5.7_linux_amd64.zip

# Install Python and create a virtual environment for AWS CLI
RUN apk add --no-cache python3 && \
    python3 -m venv /opt/aws-cli && \
    /opt/aws-cli/bin/pip install --upgrade pip && \
    /opt/aws-cli/bin/pip install awscli

# Add the virtual environment to PATH
ENV PATH="/opt/aws-cli/bin:${PATH}"

# Set the working directory
WORKDIR /workspace

# Copy Terraform files to the container
COPY . .

# Copy .env file to the container
COPY .env /workspace/.env

# Source the .env file to set environment variables
RUN echo "source /workspace/.env" >> /root/.bashrc

# Initialize Terraform
RUN terraform init

# Default command to apply Terraform
CMD ["bash", "-c", "source /workspace/.env && terraform apply -auto-approve"]