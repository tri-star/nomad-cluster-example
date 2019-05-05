job "prometheus" {
  datacenters = ["dc1"]

  type = "service"

  group "prometheus" {
    count = 1

    task "prometheus" {
      driver = "docker"

      config {
        image = "prom/prometheus:v2.9.2"
        network_mode = "weave"

        port_map {
          prometheus = 9090
        }
        volumes = [
          "/data/prometheus/data:/prometheus",
          "/data/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml"
        ]
      }

      resources {
        // cpu    = 500 # 500 MHz
        // memory = 256 # 256MB
        network {
          // mbits = 10
          port "prometheus" {
          }
        }
      }

      service {
        name = "prometheus"
        tags = ["prometheus"]
        port = "prometheus"
        check {
          name     = "prometheus-check"
          type     = "http"
          protocol = "http"
          path     = "/-/healthy"
          interval = "10s"
          timeout  = "2s"
          method   = "GET"
        }
      }
    }
  }
}
