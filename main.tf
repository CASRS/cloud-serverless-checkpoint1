terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "calculadora" {
  metadata {
    name = "calculadora"

    labels = {
      app = "calculadora"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "calculadora"
      }
    }

    template {
      metadata {
        labels = {
          app = "calculadora"
        }
      }

      spec {
        container {
          name  = "calculadora"
          image = "python:3.12-alpine"

          command = [
            "python",
            "-c"
          ]

          args = [<<-PYTHON
            from http.server import BaseHTTPRequestHandler, HTTPServer
            from urllib.parse import urlparse, parse_qs

            class Calculadora(BaseHTTPRequestHandler):

                def do_GET(self):
                    params = parse_qs(urlparse(self.path).query)

                    try:
                        a = float(params.get("a", ["0"])[0])
                        b = float(params.get("b", ["0"])[0])
                        operacao = params.get("op", ["soma"])[0]

                        if operacao == "soma":
                            resultado = a + b

                        elif operacao == "subtracao":
                            resultado = a - b

                        elif operacao == "multiplicacao":
                            resultado = a * b

                        elif operacao == "divisao":
                            if b == 0:
                                resultado = "Erro: divisão por zero"
                            else:
                                resultado = a / b

                        else:
                            resultado = "Erro: operação inválida"

                    except Exception as e:
                        resultado = f"Erro: {e}"

                    self.send_response(200)
                    self.send_header("Content-Type", "text/plain")
                    self.end_headers()

                    self.wfile.write(str(resultado).encode())

            print("Calculadora iniciada na porta 8080")

            HTTPServer(
                ("0.0.0.0", 8080),
                Calculadora
            ).serve_forever()
          PYTHON
          ]

          port {
            container_port = 8080
            host_port      = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "calculadora" {
  metadata {
    name = "calculadora"
  }

  spec {
    selector = {
      app = "calculadora"
    }

    type = "NodePort"

    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
      protocol    = "TCP"
    }
  }
}
