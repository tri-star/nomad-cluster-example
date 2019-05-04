job "node-exporter" {
  datacenters = ["dc1"]

  type = "system"

  group "node-exporter" {
    count = 1

    task "node-exporter" {
      driver = "docker"

      config {
        image = "prom/node-exporter:v0.17.0"
        network_mode = "host"

        port_map {
          node_exporter = 9100
        }
      }

      resources {
        // cpu    = 500 # 500 MHz
        // memory = 256 # 256MB
        network {
          // mbits = 10
          port "node_exporter" {
            static = 9100
          }
        }
      }

      service {
        name = "node-exporter"
        tags = ["node-exporter"]
        address_mode = "driver"
        port = "node_exporter"
        check {
          name     = "node-exporter-check"
          type     = "http"
          protocol = "http"
          address_mode = "driver"
          port = "node_exporter"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
          method   = "GET"
        }
      }

    }
  }
}
