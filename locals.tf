locals {
  tokens   = yamldecode(file("./vault/token.yaml"))
  clusters = yamldecode(file("./k8s.yaml"))
  nodes    = lookup(local.clusters["k8s-sandbox"], "nodes", {})

  node_iterator = { for k, v in flatten(
    [for cluster_key, cluster_value in local.clusters :
      [for node_key, node_value in lookup(cluster_value, "nodes", {}) :
        {
          #name =  cluster_key + "-" + substr(node_value.type, 0, 1) + 
          name       = node_value.hostname
          descripion = "${cluster_key} ${node_value.type} node"
          cpu        = node_value.cpu
          mem        = node_value.mem
          hdd        = node_value.hdd
          vmid       = 800 + node_key
          key        = node_key
          host       = cluster_value.network.ip_start + node_key
          ipconfig0  = "ip=${cluster_value.network.net_addr}.${cluster_value.network.ip_start + node_key}${cluster_value.network.net_mask},gw=10.0.0.1"
        }
      ]
    ]
  ) : k => v }

}

# output "clusters" {
#     value =  local.clusters
# }

output "nodes-node_iterator" {
  value = local.node_iterator
}

output "lookup_nodes" {
  value = local.nodes
}
