variable "node_size" {
    default = 2
    description = "Size of total nodes"
}

variable "loadtest_dir_source" {
    default = "../plans/"
    description = "Directory where is the locust plan file"
}

variable "locust_plan_filename" {
    default = "main.py"
    description = "Locust plan filename"
}

variable "subnet_name" {
    default = ""
    description = "Subnet name"
}