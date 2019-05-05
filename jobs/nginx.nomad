job "nginx" {
  datacenters = ["dc1"]

  type = "system"

  group "nginx" {
    count = 1

    task "nginx" {
      driver = "docker"

      config {
        image = "nginx:1.15.12"
        network_mode = "host"

        port_map {
          nginx = 80
        }

        volumes = [
          "/data/nginx/conf.d:/etc/nginx/conf.d",
          "/data/nginx/nginx.conf:/etc/nginx/nginx.conf",
          "/data/nginx/public:/etc/nginx/public"
        ]
      }

      resources {
        // cpu    = 500 # 500 MHz
        // memory = 256 # 256MB
        network {
          // mbits = 10
          port "nginx" {
            static = 80
          }
        }
      }

      service {
        name = "nginx"
        tags = ["nginx"]
        address_mode = "driver"
        port = "nginx"
        check {
          name     = "nginx-check"
          type     = "http"
          protocol = "http"
          address_mode = "driver"
          port = "nginx"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
          method   = "GET"
        }
      }

      template {
        source = "/data/nginx/conf.d/prometheus.conf.ctmpl"
        destination = "local/conf.d/prometheus.conf"
        change_mode = "restart"
        #change_signal = "SIGHUP"
      }

    }
  }
}
