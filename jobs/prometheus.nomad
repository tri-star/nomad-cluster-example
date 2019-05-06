job "prometheus" {
  datacenters = ["dc1"]

  type = "service"

  group "prometheus" {
    count = 1

    task "prometheus" {
      driver = "docker"

      config {
        image = "prom/prometheus:v2.9.2"

        port_map {
          prometheus = 9090
        }
        volumes = [
          "/data/prometheus/data:/prometheus",
          "/data/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml"
        ]
      }

      resources {
        cpu    = 200 //MHz
        memory = 100
        network {
          // mbits = 10
          port "prometheus" {
          }
        }
      }

      service {
        name = "prometheus"
        tags = ["prometheus"]
        address_mode = "host"
        port = "prometheus"
        check {
          name     = "prometheus-check"
          type     = "http"
          protocol = "http"
          address_mode = "host"
          port = "prometheus"
          path     = "/-/healthy"
          interval = "10s"
          timeout  = "2s"
          method   = "GET"
        }
      }
    }
  }
}
