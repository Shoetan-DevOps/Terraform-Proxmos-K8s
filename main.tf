/* Uses Cloud-Init options from Proxmox 5.2 */
resource "proxmox_vm_qemu" "k8s-node" {
  for_each = local.node_iterator

  name        = each.value.name
  desc        = each.value.descripion
  target_node = "pve01"
  vmid        = each.value.vmid
  clone       = "CIT-ubuntu-jammy"
  cores       = each.value.cpu
  sockets     = 1
  memory      = each.value.mem
  nic         = "virtio"
  bridge      = "vmbr0"

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = each.value.hdd
  }

  #ssh_user        = "ansible"
  #ssh_private_key = file("./vault/id_rsa")
  #sshkeys = file("./vault/id_rsa.pub")

  os_type    = "cloud-init" #"ubuntu" #"cloud-init"
  ipconfig0  = each.value.ipconfig0
  nameserver = "1.1.1.1"

}


