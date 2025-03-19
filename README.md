# Teste Técnico DevOps

Este repositório contém a implementação de uma infraestrutura AWS utilizando Terraform, além de documentação e explicações para cada um dos exercícios propostos.

## 1. Infraestrutura AWS

### Descrição:
Criei uma configuração básica utilizando Terraform para provisionar:

- **Instância EC2**: Duas instâncias EC2 rodando Amazon Linux 2023.
- **RDS (MySQL)**: Um banco de dados MySQL com segurança configurada para aceitar conexões apenas das instâncias EC2.
- **S3**: Um bucket S3 privado, configurado para negar acesso público.

### Como reproduzir:
1. Clone o repositório:
   ```bash
   git clone https://github.com/Lucas-Sana/meu-projeto-node.git
   cd meu-projeto-node
   ```
2. Configure suas credenciais da AWS no arquivo `.env`:
   ```plaintext
   AWS_ACCESS_KEY_ID=SUA_ACCESS_KEY
   AWS_SECRET_ACCESS_KEY=SUA_SECRET_KEY
   AWS_DEFAULT_REGION=us-east-2
   ```
3. Execute `terraform init` para inicializar o Terraform:
   ```bash
   terraform init
   ```
4. Aplique a infraestrutura:
   ```bash
   terraform apply -auto-approve
   ```
5. Para destruir a infraestrutura após os testes:
   ```bash
   terraform destroy -auto-approve
   ```
## Comandos Úteis

Acessar a Instância EC2 via SSH:
```bash
ssh -i C:\Users\-----\.ssh\minha_chave_aws2.pem ec2-user@<IP_PUBLICO_DA_INSTANCIA>
```

Aplicar a Infraestrutura:
```bash
terraform apply -auto-approve
```

Destruir a Infraestrutura:
```bash
terraform destroy -auto-approve
```


# README

## 1. Infraestrutura AWS

### Descrição:
Criei uma configuração básica utilizando Terraform para provisionar:

- **Instância EC2:** Duas instâncias EC2 rodando Amazon Linux 2023.
- **RDS (MySQL):** Um banco de dados MySQL com segurança configurada para aceitar conexões apenas das instâncias EC2.
- **S3:** Um bucket S3 privado, configurado para negar acesso público.

### Como reproduzir:

Clone o repositório:
```bash
git clone https://github.com/Lucas-Sana/meu-projeto-node.git
cd meu-projeto-node
```

Configure suas credenciais da AWS no arquivo `.env`:
```plaintext
AWS_ACCESS_KEY_ID=SUA_ACCESS_KEY
AWS_SECRET_ACCESS_KEY=SUA_SECRET_KEY
AWS_DEFAULT_REGION=us-east-2
```

Execute `terraform init` para inicializar o Terraform:
```bash
terraform init
```

Aplique a infraestrutura:
```bash
terraform apply -auto-approve
```

Para destruir a infraestrutura após os testes:
```bash
terraform destroy -auto-approve
```

---
## 2. Infraestrutura como Código (IaC)

### Descrição:
Utilizei o Terraform para criar um **Application Load Balancer (ALB)** que distribui o tráfego entre duas instâncias EC2. O ALB está configurado para:

- Escutar na porta **80 (HTTP)**.
- Realizar **health checks** nas instâncias EC2.
- Distribuir o tráfego de forma equilibrada.

### Por que Terraform?
O Terraform é amplamente adotado, suporta múltiplos provedores de nuvem e possui uma sintaxe declarativa que facilita a leitura e manutenção do código.

### Como reproduzir:
O código do ALB está no arquivo `main.tf`. Execute `terraform apply` para criar o Load Balancer.

---
## 3. Continuidade de Negócio
Para garantir a continuidade dos serviços críticos na AWS em caso de falha na região principal, é essencial implementar uma estratégia de **Disaster Recovery (DR)** ou **Recuperação de Desastres**. Abaixo está um plano básico que utiliza serviços da AWS para garantir a resiliência e a disponibilidade dos serviços:

## Identificação de Serviços Críticos
- Liste todos os serviços críticos que precisam ser mantidos em caso de falha.
- Defina os **RTO (Recovery Time Objective)** e **RPO (Recovery Point Objective)** para cada serviço.

## Configuração de Multi-Região
- Utilize uma segunda região AWS como região de failover.
- Certifique-se de que todos os serviços críticos estejam replicados na região secundária.

## Replicação de Dados
- **Amazon S3**: Use a funcionalidade de **Cross-Region Replication (CRR)** para replicar dados entre buckets S3 em regiões diferentes.
- **Amazon RDS**: Configure a **Multi-AZ** e **Read Replicas** em outra região para garantir a disponibilidade do banco de dados.
- **Amazon DynamoDB**: Use **Global Tables** para replicar tabelas em várias regiões automaticamente.
- **Amazon EFS**: Utilize **EFS Cross-Region Replication** para replicar sistemas de arquivos.

## Balanceamento de Carga e Failover
- **Amazon Route 53**: Configure **DNS Failover** para redirecionar o tráfego para a região secundária em caso de falha na região principal.
- **AWS Elastic Load Balancer (ELB)**: Use **Cross-Zone Load Balancing** ou configure ELBs em ambas as regiões para distribuir o tráfego.

## Automação de Failover
- **AWS CloudFormation**: Crie templates para implantação automatizada de infraestrutura na região secundária.
- **AWS Lambda**: Automatize processos de failover, como a ativação de instâncias EC2 ou a mudança de endpoints de banco de dados.
- **AWS Systems Manager**: Use para gerenciar e automatizar a configuração de instâncias EC2 em ambas as regiões.

## Monitoramento e Alerta
- **Amazon CloudWatch**: Configure alarmes para monitorar a saúde dos serviços e disparar alertas em caso de falhas.
- **AWS CloudTrail**: Monitore atividades e eventos na AWS para identificar problemas rapidamente.

## Testes Regulares
- Realize testes de failover periódicos para garantir que o plano de continuidade funcione conforme o esperado.
- Use o **AWS Fault Injection Simulator** para simular falhas e validar a resiliência da arquitetura.

## Backup e Restauração
- **AWS Backup**: Configure backups automatizados para serviços como RDS, DynamoDB, EFS e EC2, com armazenamento em outra região.
- **Amazon Glacier**: Armazene backups de longo prazo para dados menos críticos.

## Segurança e Conformidade
- Certifique-se de que as políticas de segurança (**IAM, VPC, etc.**) estejam replicadas na região secundária.
- Use **AWS Config** para garantir a conformidade contínua das configurações.

## Documentação e Treinamento
- Documente todos os processos de failover e recuperação.
- Treine a equipe para executar o plano de continuidade de negócios em caso de emergência.

## Serviços AWS Principais Utilizados
- **Amazon S3** (Cross-Region Replication)
- **Amazon RDS** (Multi-AZ e Read Replicas)
- **Amazon DynamoDB** (Global Tables)
- **Amazon Route 53** (DNS Failover)
- **AWS Elastic Load Balancer (ELB)**
- **AWS CloudFormation** (Automação de Infraestrutura)
- **AWS Lambda** (Automação de Processos)
- **Amazon CloudWatch** (Monitoramento)
- **AWS Backup** (Backup Automatizado)


---
## 4. Monitoramento e Logging

### Descrição:
Utilizei o **AWS CloudWatch** para monitoramento:

- Coletando métricas de CPU e memória.
- Logs enviados para o grupo `myapp-logs`.
- CloudWatch Agent configurado via `user_data`.

---
## 6. Segurança

# Política de Segurança para Amazon S3

## Política de Bucket (Bucket Policy)
A política de bucket é uma forma de controlar o acesso ao nível do bucket. Ela permite definir permissões granulares para usuários, grupos ou serviços AWS.

### Exemplo de Política de Bucket:
A política abaixo permite acesso apenas a um usuário ou função específica e bloqueia todo o resto:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:user/UsuarioAutorizado"
      },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::nome-do-bucket",
        "arn:aws:s3:::nome-do-bucket/*"
      ]
    },
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::nome-do-bucket",
        "arn:aws:s3:::nome-do-bucket/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalArn": "arn:aws:iam::123456789012:user/UsuarioAutorizado"
        }
      }
    }
  ]
}
```

### Explicação:
- A primeira instrução (`Allow`) concede permissões totais (`s3:*`) ao usuário `UsuarioAutorizado`.
- A segunda instrução (`Deny`) bloqueia o acesso a todos os outros usuários ou serviços que não correspondam ao `PrincipalArn` especificado.

## Controle de Acesso Baseado em Funções (IAM Roles)
- Use **IAM Roles** para conceder permissões temporárias a usuários ou serviços que precisam acessar o bucket.
- Evite usar credenciais de acesso de longo prazo (chaves de acesso).

## Listas de Controle de Acesso (ACLs)
- Embora menos recomendado que as políticas de bucket, você pode usar **ACLs** para controlar o acesso a objetos específicos dentro do bucket.
- Configure ACLs para garantir que apenas proprietários ou usuários autorizados tenham permissões de leitura/escrita.

## Criptografia de Dados
- **Criptografia no Repouso**: Use **Amazon S3 Managed Keys (SSE-S3)**, **AWS KMS (SSE-KMS)** ou **Criptografia do Cliente (SSE-C)** para criptografar os dados armazenados no S3.
- **Criptografia em Trânsito**: Use **HTTPS** para transferir dados para e do S3.

## Bloqueio Público do Bucket
- Ative o **Block Public Access** nas configurações do bucket para evitar que os dados sejam tornados públicos acidentalmente.
- Isso impede a configuração de políticas de bucket ou ACLs que permitam acesso público.

## Uso de VPC Endpoints
- Configure **VPC Endpoints** para acessar o S3 de forma privada, sem passar pela internet pública.
- Isso garante que o tráfego entre sua VPC e o S3 permaneça seguro e isolado.

## Monitoramento e Auditoria
- Use **AWS CloudTrail** para registrar todas as chamadas de API relacionadas ao S3.
- Configure **Amazon CloudWatch** para monitorar atividades suspeitas, como tentativas de acesso não autorizado.
- Use **Amazon Macie** para identificar e classificar dados sensíveis armazenados no S3.

## Versionamento e MFA Delete
- Ative o **Versionamento** no bucket para proteger contra exclusões acidentais ou maliciosas.
- Configure **MFA Delete** para exigir autenticação multifator antes de excluir objetos.

## Políticas de Ciclo de Vida
- Configure **políticas de ciclo de vida** para mover dados não críticos para classes de armazenamento mais seguras, como **S3 Glacier**, ou excluí-los automaticamente após um período especificado.

## Testes e Revisões Regulares
- Realize **auditorias regulares** para garantir que as políticas de acesso estejam atualizadas e alinhadas com as necessidades de negócios.
- **Teste as configurações de segurança** para identificar e corrigir vulnerabilidades.

---
## 7. Otimização de Performance

# Otimização de Desempenho para Aplicações Web na AWS

Para garantir que sua aplicação web consiga lidar com milhares de usuários simultâneos de forma eficaz, otimizar o desempenho é essencial. Implementar estratégias de cache, armazenamento estático, escalabilidade e ferramentas de monitoramento é crucial para alcançar alta disponibilidade e latência mínima. Este guia descreve vários procedimentos e configurações para otimizar o desempenho da aplicação web, especificamente em um ambiente AWS.
---

## Uso de CDN (Content Delivery Network)

### Amazon CloudFront
O CloudFront é uma CDN que entrega conteúdo a partir de locais de borda mais próximos dos usuários, reduzindo a latência e acelerando o carregamento de conteúdo estático e dinâmico, como imagens, CSS, JavaScript e APIs.

**Benefícios:**
- **Redução de Latência:** O conteúdo é entregue do local de borda mais próximo.
- **Carregamento Mais Rápido:** Melhora a experiência do usuário com carregamento mais rápido.
- **Escalabilidade:** Pode lidar com grandes números de usuários simultâneos de forma eficaz.

**Configuração:**
1. Crie uma distribuição do CloudFront.
2. Defina seu bucket S3 ou servidor de origem (EC2, ALB) como fonte.
3. Ative a compressão de objetos usando **Gzip** ou **Brotli** para reduzir o tamanho do conteúdo.
4. Defina políticas de cache apropriadas, como **Time to Live (TTL)**, para diferentes tipos de conteúdo.

---

## Armazenamento Estático no S3

### Amazon S3
Armazene arquivos estáticos (ex.: imagens, vídeos, CSS, JS) no Amazon S3 para durabilidade, escalabilidade e custo-benefício.

**Benefícios:**
- **Alta Durabilidade:** O S3 oferece 99.999999999% de durabilidade.
- **Escalabilidade:** O S3 escala automaticamente para acomodar o crescimento de dados.
- **Custo-Benefício:** Pague apenas pelo que armazena e transfere.

**Configuração:**
1. Habilite o **versionamento** para proteger contra exclusões acidentais.
2. Use **políticas de ciclo de vida** para mover dados não utilizados para classes de armazenamento mais baratas, como **S3 Glacier**.
3. Defina as **permissões** para controlar o acesso aos arquivos armazenados.
4. Ative a **Aceleração de Transferência S3** para uploads mais rápidos de locais globais.

---

## Cache de Dados

### Amazon ElastiCache
O ElastiCache oferece uma solução gerenciada de cache com Redis e Memcached, permitindo armazenar em cache dados acessados frequentemente, como informações de sessão ou resultados de consultas ao banco de dados.

**Benefícios:**
- **Reduz a Carga no Banco de Dados:** Dados acessados com frequência são armazenados em memória, reduzindo consultas ao banco de dados.
- **Tempo de Resposta Melhorado:** A recuperação de dados mais rápida resulta em melhor desempenho da aplicação.

**Configuração:**
1. Crie um cluster Redis ou Memcached.
2. Integre sua aplicação para armazenar e recuperar dados do cache.
3. Configure políticas de eliminação com base nos padrões de uso de dados (ex.: eliminação LRU).

---

## Auto Scaling

### AWS Auto Scaling
O AWS Auto Scaling ajusta automaticamente o número de instâncias EC2 para atender à demanda. Isso garante que sua aplicação consiga lidar com o aumento de tráfego sem intervenção manual.

**Benefícios:**
- **Lida com Picos de Tráfego:** Escala sua infraestrutura com base no tráfego em tempo real.
- **Custo-Benefício:** Reduz durante períodos de baixo tráfego, economizando custos.

**Configuração:**
1. Crie um **grupo de Auto Scaling**.
2. Configure **políticas de escalonamento** com base em métricas do CloudWatch, como CPU, uso de memória ou métricas personalizadas.
3. Use um **Application Load Balancer (ALB)** para distribuir o tráfego de entrada entre as instâncias EC2.

---

## Balanceamento de Carga

### Elastic Load Balancer (ELB)
Use o ELB para distribuir o tráfego entre várias instâncias EC2, melhorando a disponibilidade e a tolerância a falhas.

**Benefícios:**
- **Maior Disponibilidade:** Garante que sua aplicação esteja disponível mesmo se uma instância falhar.
- **Escalabilidade:** Pode lidar com variações de tráfego distribuindo a carga entre várias instâncias.

**Configuração:**
1. Crie um **Application Load Balancer (ALB)** ou **Network Load Balancer (NLB)**.
2. Configure ouvintes para tráfego **HTTP/HTTPS**.
3. Habilite **Sessões Persistentes (Sticky Sessions)**, se necessário, para manter o estado de sessão dos usuários.

---

## Otimização de Banco de Dados

### Amazon RDS
O Amazon RDS oferece instâncias de banco de dados gerenciadas para melhorar o desempenho do banco de dados com escalabilidade e tolerância a falhas.

**Benefícios:**
- **Melhor Desempenho de Consultas:** Com Réplicas de Leitura e Cache de Consultas.
- **Escalabilidade:** Use o **Amazon Aurora** para alta performance e escalabilidade.
- **Serviços Gerenciados:** A AWS gerencia atualizações, backups e failover.

**Configuração:**
1. Habilite **Réplicas de Leitura** para distribuir a carga de leitura entre várias instâncias.
2. Use **Amazon Aurora** para melhorar o desempenho e a escalabilidade.
3. Configure o **Cache de Consultas** no RDS para armazenar consultas frequentes.

---

## Compressão de Arquivos e Minificação

### Compressão de Arquivos e Minificação
Minifique e comprima arquivos estáticos como CSS, JavaScript e HTML para reduzir o tamanho dos arquivos, melhorando o tempo de carregamento.

**Benefícios:**
- **Tamanho Menor de Arquivos:** Arquivos menores melhoram a velocidade de download.
- **Uso Reduzido de Largura de Banda:** A compressão de conteúdo reduz a transferência de dados.

**Ferramentas:**
- Use **Webpack**, **Gulp** ou **Grunt** para automatizar o processo de minificação.
- Habilite a compressão **Gzip** ou **Brotli** para respostas do servidor.

---

##  Cache de Navegador

### Cache de Navegador
Configure seu servidor web para armazenar arquivos estáticos no navegador dos usuários por um período determinado, reduzindo as requisições ao servidor em visitas subsequentes.

## Monitoramento e Ajustes
Amazon CloudWatch
Use o CloudWatch para monitorar métricas da aplicação, como latência, taxas de erro e utilização de recursos em tempo real.

Benefícios:
Insights de Aplicação: Rastreie e depure problemas de desempenho em aplicações distribuídas.

---
## 8. Resolução de Problemas

## Coleta de Informações Iniciais

### Identifique o escopo do problema:
- Quais serviços ou componentes estão falhando?
- Quando as falhas começaram a ocorrer?
- Qual é a frequência e o padrão das falhas (ex.: ocorrem em horários específicos)?

### Revise os logs:
- Acesse logs relevantes no **Amazon CloudWatch Logs**.
- Use o **CloudWatch Logs Insights** para consultar e filtrar logs de forma eficiente.

## Análise de Métricas

### Amazon CloudWatch:
- Verifique métricas como latência, taxa de erro, utilização de CPU, memória e rede.
- Crie gráficos para identificar padrões ou picos que coincidam com as falhas.
- Configure alarmes para monitorar métricas críticas em tempo real.

### AWS X-Ray:
- Use o **X-Ray** para rastrear solicitações e identificar gargalos ou falhas em componentes específicos.

## Verificação de Configurações

### AWS Config:
- Verifique se houve mudanças recentes na configuração do serviço.
- Revise regras de conformidade para garantir que as configurações estejam corretas.

### IAM Policies:
- Confira se as permissões de acesso estão corretas e não estão causando falhas intermitentes.

## Testes de Conectividade e Dependências

### Verifique dependências externas:
- Teste a conectividade com APIs de terceiros, bancos de dados ou outros serviços.
- Use ferramentas como **telnet**, **curl** ou **Postman** para verificar a disponibilidade e o tempo de resposta.

### Amazon VPC Flow Logs:
- Analise os **logs de fluxo de rede** para identificar problemas de conectividade ou tráfego bloqueado.

## Análise de Código e Deployments

### Revise o código:
- Verifique se há erros de lógica, exceções não tratadas ou problemas de concorrência.
- Use ferramentas de análise estática de código (ex.: **SonarQube**) para identificar possíveis vulnerabilidades.

### Verifique deployments recentes:
- Use o **AWS CodeDeploy** para revisar históricos de implantação e identificar mudanças que possam ter causado as falhas.

## Simulação de Falhas

### AWS Fault Injection Simulator:
- Simule falhas em componentes específicos (ex.: instâncias **EC2**, banco de dados) para entender como o sistema se comporta.
- Identifique pontos fracos na arquitetura e implemente melhorias.

---
## 9. Lambda e EC2

# Diferenças entre Amazon EC2 e AWS Lambda

O **Amazon EC2 (Elastic Compute Cloud)** e o **AWS Lambda** são dois serviços de computação oferecidos pela AWS, mas atendem a necessidades diferentes e são usados em cenários distintos. Abaixo, você encontrará uma explicação detalhada das diferenças entre eles e em quais situações cada um é mais adequado.

## Amazon EC2

O EC2 é um serviço que permite provisionar e gerenciar máquinas virtuais (instâncias) na nuvem. Você tem controle total sobre o sistema operacional, configurações de rede, armazenamento e software instalado.

### Características Principais

#### Controle Total:
- Acesso root/administrador à instância.
- Personalização completa do ambiente (SO, bibliotecas, dependências).

#### Escalabilidade:
- Escalabilidade vertical (aumento do tamanho da instância) e horizontal (adição de mais instâncias).
- Uso do **Auto Scaling** para ajustar automaticamente o número de instâncias com base na demanda.

#### Custo:
- Cobrança por hora ou segundo (dependendo do tipo de instância).
- Opções de instâncias sob demanda, reservadas ou spot para otimização de custos.

#### Uso Contínuo:
- Ideal para aplicações que precisam estar em execução 24/7.

#### Manutenção:
- Responsabilidade do usuário em gerenciar patches, atualizações e segurança do sistema operacional.

## AWS Lambda

O Lambda é um serviço de computação sem servidor (serverless) que permite executar código sem provisionar ou gerenciar servidores. Você só precisa fornecer o código, e a AWS gerencia a infraestrutura subjacente.

### Características Principais

#### Sem Servidor:
- Não é necessário gerenciar servidores, patches ou atualizações.
- Escalabilidade automática e instantânea.

#### Cobrança por Uso:
- Cobrança baseada no número de execuções e tempo de execução (em milissegundos).
- Sem custo quando o código não está em execução.

#### Integração com Serviços AWS:
- Facilidade de integração com outros serviços AWS, como **S3**, **DynamoDB**, **API Gateway**, etc.

#### Tempo de Execução Limitado:
- Tempo máximo de execução de 15 minutos por chamada (configurável).

#### Linguagens Suportadas:
- Suporta várias linguagens, como **Python**, **Node.js**, **Java**, **Go**, **C#**, **Ruby** e **Rust**.

## Conclusão

- O **Amazon EC2** é ideal para aplicações que exigem controle total sobre a infraestrutura, com opções de escalabilidade e uso contínuo.
- O **AWS Lambda** é perfeito para cenários onde você precisa de computação serverless, com cobrança baseada em execução, e integração fácil com outros serviços AWS, ideal para tarefas mais curtas e event-driven.

Escolher entre EC2 e Lambda depende dos requisitos específicos do seu projeto, incluindo controle de infraestrutura, escalabilidade, custo e tempo de execução.

---
## 10. Automação
# Automação de Tarefas em Pipelines CI/CD

A automação de tarefas repetitivas em um pipeline CI/CD (Integração Contínua e Entrega Contínua) é essencial para melhorar a eficiência, a confiabilidade e a velocidade do processo de desenvolvimento e entrega de software. Abaixo estão exemplos de tarefas que podem ser automatizadas e como isso beneficia o pipeline.

## Exemplos de Tarefas Repetitivas para Automação

### 1. **Compilação e Build**
- **Descrição**: Automatize a compilação do código-fonte e a criação de artefatos (ex.: binários, pacotes, imagens Docker).
- **Ferramentas**: Jenkins, AWS CodeBuild, GitHub Actions, GitLab CI.

### 2. **Execução de Testes Automatizados**
- **Descrição**: Execute testes unitários, de integração e end-to-end automaticamente após cada commit.
- **Ferramentas**: JUnit, pytest, Selenium, Cypress.

### 3. **Análise Estática de Código**
- **Descrição**: Verifique a qualidade do código, identifique vulnerabilidades e aplique padrões de codificação.
- **Ferramentas**: SonarQube, ESLint, Pylint, Checkmarx.

### 4. **Gerenciamento de Dependências**
- **Descrição**: Atualize e valide dependências do projeto automaticamente.
- **Ferramentas**: Dependabot, Renovate, npm-check.

### 5. **Geração de Documentação**
- **Descrição**: Crie documentação automaticamente a partir do código-fonte ou especificações.
- **Ferramentas**: Sphinx, Javadoc, Swagger.

### 6. **Empacotamento e Versionamento**
- **Descrição**: Gere pacotes (ex.: .jar, .zip, imagens Docker) e atribua versões automaticamente.
- **Ferramentas**: Docker, Maven, npm.

### 7. **Implantação em Ambientes de Teste**
- **Descrição**: Implante automaticamente a aplicação em ambientes de staging ou teste após a conclusão dos testes.
- **Ferramentas**: AWS CodeDeploy, Kubernetes, Terraform.

### 8. **Notificações e Alertas**
- **Descrição**: Envie notificações (ex.: email, Slack) sobre o status do pipeline (sucesso, falha, etc.).
- **Ferramentas**: Slack Webhooks, Amazon SNS, PagerDuty.

### 9. **Rollback Automático**
- **Descrição**: Reverta automaticamente implantações em caso de falha em testes pós-implantação.
- **Ferramentas**: AWS CodeDeploy, Spinnaker.

### 10. **Limpeza de Recursos**
- **Descrição**: Remova recursos temporários (ex.: instâncias EC2, contêineres) após a conclusão do pipeline.
- **Ferramentas**: AWS CloudFormation, Kubernetes Jobs.

## Como a Automação Melhora a Eficiência e Confiabilidade

### 1. **Redução de Erros Humanos**
Tarefas manuais estão sujeitas a erros, como comandos incorretos ou esquecimento de etapas. A automação elimina esses riscos.

### 2. **Consistência**
Garante que todas as etapas do pipeline sejam executadas da mesma forma, independentemente de quem aciona o processo.

### 3. **Velocidade**
A automação permite que tarefas sejam executadas em paralelo e de forma mais rápida, reduzindo o tempo total do pipeline.

### 4. **Escalabilidade**
Pipelines automatizados podem lidar com um aumento no volume de commits ou implantações sem exigir esforço adicional da equipe.

### 5. **Feedback Rápido**
Desenvolvedores recebem feedback imediato sobre a qualidade do código e problemas de integração, permitindo correções rápidas.

### 6. **Conformidade e Segurança**
A automação de verificações de segurança e conformidade garante que todas as implantações atendam aos padrões da organização.

### 7. **Economia de Tempo e Custos**
A equipe pode focar em tarefas de maior valor, enquanto tarefas repetitivas são executadas automaticamente.

### 8. **Disponibilidade Contínua**
Pipelines automatizados permitem implantações frequentes e confiáveis, garantindo que novas funcionalidades e correções cheguem aos usuários rapidamente.

## Exemplo de Pipeline CI/CD Automatizado

### **Integração Contínua (CI)**

1. **Trigger**: Um desenvolvedor faz um push para o repositório Git.
2. **Build**: O código é compilado e os artefatos são gerados.
3. **Testes**: Testes unitários e de integração são executados.
4. **Análise de Código**: Ferramentas de análise estática verificam a qualidade e segurança do código.
5. **Notificação**: O desenvolvedor é notificado sobre o sucesso ou falha do processo.

### **Entrega Contínua (CD)**

1. **Implantação em Staging**: O código é implantado automaticamente em um ambiente de staging.
2. **Testes End-to-End**: Testes automatizados validam a aplicação no ambiente de staging.
3. **Aprovação Manual (Opcional)**: A equipe de QA valida manualmente, se necessário.
4. **Implantação em Produção**: O código é implantado em produção automaticamente ou após aprovação.
5. **Rollback Automático**: Em caso de falha, a implantação é revertida automaticamente.


---
## 11. Experiência Profissional

# Automação de Infraestrutura - ALTI Tecnologia

## Descrição

Quando entrei na ALTI Tecnologia, fui designado para um projeto crítico: automatizar a infraestrutura on-premise de um sistema central que eu mesmo havia desenvolvido em PHP. Esse sistema gerenciava o cadastro de clientes, contratação de serviços, gestão de funcionários e oportunidades de negócio. Embora funcional, o sistema dependia totalmente de processos manuais para provisionamento de servidores, configurações e monitoramento, o que gerava atrasos, erros humanos e uma carga operacional insustentável para a equipe de TI.

## O Problema

A infraestrutura era composta por servidores físicos rodando em VMware, com configurações manuais e pouca padronização. Sempre que um novo cliente era cadastrado ou um serviço contratado, a equipe precisava:

- Provisionar manualmente um novo servidor.
- Configurar o ambiente (rede, segurança, aplicações).
- Realizar testes manuais para garantir que tudo funcionava corretamente.
- Adicionar o servidor ao sistema de monitoramento.

Esse processo levava horas ou até dias, dependendo da complexidade. Além disso, qualquer erro na configuração poderia impactar diretamente os clientes, causando indisponibilidade ou falhas críticas.

## A Solução Proposta

Minha missão foi automatizar todo o fluxo, desde o provisionamento até o monitoramento, utilizando ferramentas modernas como **Terraform**, **Ansible**, **Docker**, **Kubernetes**, **Prometheus** e **Grafana**. O objetivo era criar um sistema que pudesse:

- Provisionar servidores automaticamente ao detectar uma nova contratação de serviço.
- Configurar o ambiente de forma padronizada e replicável.
- Adicionar o servidor ao sistema de monitoramento em tempo real.
- Garantir alta disponibilidade e resiliência.

## Os Desafios Encontrados

### Integração com o Sistema em PHP

O sistema central, desenvolvido em PHP, não tinha APIs bem definidas para comunicação com ferramentas de automação.

**Solução:** Desenvolvi uma API em PHP que se integrava ao banco de dados e ao sistema central, capturando eventos como novas contratações e acionando o provisionamento automático via Terraform.

### Padronização de Configurações

Cada servidor tinha configurações únicas, o que dificultava a automação.

**Solução:** Utilizei o **Ansible** para criar playbooks que padronizavam as configurações de rede, segurança e aplicações. Isso garantiu que todos os servidores fossem idênticos e prontos para uso.

### Monitoramento em Tempo Real

O sistema de monitoramento existente era manual e pouco eficiente.

**Solução:** Implementei o **Prometheus** para coletar métricas dos servidores e o **Grafana** para visualização em dashboards. Criei alertas automáticos para problemas como alta utilização de CPU, memória ou falhas de serviço.

### Orquestração de Contêineres

Parte das aplicações precisava ser containerizada para garantir escalabilidade.

**Solução:** Utilizei **Docker** para criar contêineres das aplicações e **Kubernetes** para orquestração. Isso permitiu que as aplicações fossem escaladas automaticamente conforme a demanda.

### Resistência à Mudança

A equipe de operações estava acostumada aos processos manuais e tinha receio de adotar a automação.

**Solução:** Realizei treinamentos e demonstrações práticas, mostrando como a automação poderia reduzir a carga de trabalho e minimizar erros. Além disso, criei documentação detalhada para facilitar a adoção.

## O Resultado

Após meses de trabalho, o sistema de automação foi implementado com sucesso. Os resultados foram impressionantes:

- **Redução de 80% no tempo de provisionamento:** Servidores que antes levavam horas para ficarem prontos agora eram provisionados em minutos.
- **Padronização completa:** Todos os servidores seguiam as mesmas configurações, reduzindo erros e inconsistências.
- **Monitoramento proativo:** Problemas eram detectados e resolvidos antes de impactar os clientes.
- **Escalabilidade:** A infraestrutura agora podia escalar automaticamente para atender a picos de demanda.

## Lições Aprendidas

- **Automação é um investimento:** Apesar do esforço inicial, a automação trouxe ganhos significativos em eficiência e confiabilidade.
- **Comunicação é chave:** Envolver a equipe desde o início e mostrar os benefícios da automação foi crucial para o sucesso do projeto.
- **Ferramentas certas fazem a diferença:** **Terraform**, **Ansible**, **Kubernetes** e **Prometheus** foram essenciais para resolver os desafios técnicos.

---

