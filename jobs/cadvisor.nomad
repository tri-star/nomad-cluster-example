job "cadvisor" {
  datacenters = ["dc1"]

  type = "system"

  group "cadvisor" {
    count = 1

    task "cadvisor" {
      driver = "docker"

      config {
        image = "google/cadvisor:v0.33.0"
        network_mode = "host"

        port_map {
          cadvisor = 8080
        }

        volumes = [
          "/:/rootfs",
          "/var/run:/run",
          "/sys:/sys",
          "/var/lib/docker:/var/lib/docker"
        ]
      }

      resources {
        cpu    = 200 //MHz
        memory = 100
        network {
          // mbits = 10
          port "cadvisor" {
            static = 8080
          }
        }
      }

      service {
        name = "cadvisor"
        tags = ["cadvisor"]
        address_mode = "driver"
        port = "cadvisor"
        check {
          name     = "cadvisor-check"
          type     = "http"
          protocol = "http"
          address_mode = "driver"
          port = "cadvisor"
          path     = "/healthz"
          interval = "10s"
          timeout  = "2s"
          method   = "GET"
        }
      }

    }
  }
}
