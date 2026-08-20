# Checkpoint 1 - Função Serverless na Nuvem

**Descrição do produto: Calculadora

## Pre-requisitos
Terraform instalado

### Passo a passo
1. Clone o repositorio para sua maquina:
   git clone https://github.com/CASRS/cloud-serverless-checkpoint1.git

2. Entre na pasta do projeto:
cd cloud-serverless-checkpoint1

3. Use o terraform\
terraform init\
terraform plan\
terraform apply
4. Uso e funções do serviço

Operações da Calculadora

Soma
http://xxxxxx:8080/?a=10&b=5&op=soma

Subtração
http://xxxxxx:8080/?a=17&b=5&op=subtracao

Multiplicação
http://xxxxxx:8080/?a=20&b=5&op=multiplicacao

Divisão
http://xxxxxx:8080/?a=12&b=4&op=divisao


Método de uso do prompt:

Uso no navegador:
http://xxxxxx:8080/?a=10&b=5&op=soma

Uso prompt:
curl "http://xxxxxx:8080/?a=10&b=5&op=soma"
