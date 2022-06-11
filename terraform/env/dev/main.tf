module "users" {
    source = "../../infra/users"
    envirmonment = "${var.envirmonment}"
    write_capacity = 1
    read_capacity = 1
}
