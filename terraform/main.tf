module "loadtest" {

    # https://registry.terraform.io/modules/marcosborges/loadtest-distribuited/aws/latest
    source  = "marcosborges/loadtest-distribuited/aws"

    name = "loadtests"
    nodes_size = var.node_size
    executor = "locust"
    loadtest_dir_source = var.loadtest_dir_source

    # LEADER ENTRYPOINT
    loadtest_entrypoint = <<-EOT
        nohup locust \
            -f ${var.locust_plan_filename} \
            --web-port=8080 \
            --expect-workers=${var.node_size} \
            --master > locust-leader.out 2>&1 &
    EOT

    # NODES ENTRYPOINT
    node_custom_entrypoint = <<-EOT
        nohup locust \
            -f ${var.locust_plan_filename} \
            --worker \
            --master-host={LEADER_IP} > locust-worker.out 2>&1 &
    EOT

    subnet_id = data.aws_subnet.current.id

    locust_plan_filename = var.locust_plan_filename

    ssh_export_pem = false

    nodes_associate_public_ip_address = false
    leader_associate_public_ip_address = false

    ssh_cidr_ingress_blocks = ["0.0.0.0/0"]
    web_cidr_ingress_blocks = ["0.0.0.0/0"]

    leader_tags = local.loadtests_tags
    nodes_tags = local.loadtests_tags
    tags = local.loadtests_tags
}

locals {
  loadtests_tags = merge({
    application       = "App Loadtest"
  })
}