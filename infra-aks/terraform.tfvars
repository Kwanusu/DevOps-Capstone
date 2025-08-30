variable "resource_group_name" {
    description = "devsecops_rg"
    type = string
    default = "default-rg"
}

variable "location" {
    description = "East US"
    type = string
    default = "East US"
}

variable "address_space" {
    description = "Address space for the Vnet"
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "tags" {
    description = "Resource tags (map of strings)"
    type = map(string)
    default = {
        Environment = "Dev"
        ManagedBy = "Terraform"
    }
}

variable "aks_node_count" {
    description "Number of agent nodes in the AKS pool"
    type = string 
    default = "mycontainerregistry/my-flask-app:latest"
}