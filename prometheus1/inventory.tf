resource "local_file" "inventory" {
  filename = "inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    node1_ip = module.node1.public_ip
    node2_ip = module.node2.public_ip
  })
}
