#  Infrastructure as Code Setup (Terraform) in  GCP
---------------------------------------------------------------------------------------------

### Summary
---------------------------------------------------------------------------------------------
This project focuses on setting up a comprehensive infrastructure in Google Cloud Platform (GCP) using Terraform. The infrastructure includes the creation of a Google Kubernetes Engine (GKE) cluster, Virtual Private Cloud (VPC) network with subnets, routers, firewall rules, and more. Additionally, a Bastion host is created to facilitate secure access to the private GKE cluster.

### To run code:
-----------------------

**Prerequisite:** 
Before running the Terraform scripts, ensure the following prerequisites installed:

[ GCLOUD CLI](https://cloud.google.com/sdk/docs/install), [Terraform ](https://www.terraform.io/)


**Useful Commands**

1. Setup GCP Credentials:
    ```
    gcloud init
    ```
    - This command will guide you through the setup process, prompting you to log in with your GCP account, and configure default settings, including project selection.

2. Set Profile to Environment Variables::
    -   Linux/Mac
    ```
    export GOOGLE_APPLICATION_CREDENTIALS=/path/to/your/credentials.json
    ```
    -   Windows
    ```
    set GOOGLE_APPLICATION_CREDENTIALS=C:\path\to\your\credentials.json
    ```
    - Replace /path/to/your/credentials.json with the actual path to your GCP credentials file. This file contains the necessary authentication information for your GCP project.

3. Initialize Terraform:
    -  Run the following command to initialize Terraform in your project directory:
    ```
    terraform init
    ```
4. Validate Terraform:
    - To check the syntax of your Terraform configuration files, use:
    ```
    terraform validate 
    ```
5. Plan Terraform:
    - To check the syntax of your Terraform configuration files, use:
    ```
    terraform plan 
    ```
6. Apply Terraform:
    - Deploy your infrastructure by running:
    ```
    terraform apply 
    ```
7. Destroy Terraform:
    - To tear down your infrastructure, use:
    ```
    terraform destroy
    ```

### Infrastructure Setup

The Terraform scripts in this repository set up the following GCPinfrastructure components:

- **Virtual Private Cloud (VPC)**: A logically isolated section of the GCP Cloud where you can launch   resources.
- **Subnets**: GCP allows you to create subnets within your VPC for network segregation.
- **Routes**: GCP uses Routes to control the routing of traffic between subnets and to the internet.
- **Cloud Router**: To enable dynamic routing between your on-premises network and your VPC.
- **Firewall Rules**: GCP uses Firewall Rules to define inbound and outbound traffic rules for instances.
- **Instances (Bastion Host)**: A Bastion host is created in the same VPC, in a public subnet, to facilitate secure access to private GKE cluster.
- **NAT Gatewayr**: To enable internet access for a Kubernetes cluster, a NAT Gateway needs to be added.
- **Google Kubernetes Engine (GKE) Cluster**:  A private regional multi-zone GKE cluster in standard mode using Container-Optimized OS. It is set up for Binary Authorization and Workload Identity.



_This project is part of CSYE7125 course_




