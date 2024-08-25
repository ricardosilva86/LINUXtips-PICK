# Desafio 1 LINUXtips-PICK 🚀

Repositório para o desafio do PICK 2024 🏆

## Descrição 📄

Este projeto é um gerador de senhas desenvolvido com Python e JavaScript. Ele permite gerar senhas seguras com diferentes opções de personalização.

## Tecnologias Utilizadas 🛠️

- **Python** 🐍
- **JavaScript** 🌐
- **Pip** 📦
- **Docker** 🐳

## Funcionalidades da Aplicação ✨

- Gerar senhas com comprimento personalizado 🔢
- Incluir números nas senhas 🔢
- Incluir caracteres especiais nas senhas 🔡
- Visualizar e copiar senhas geradas 📋
- Listar as últimas senhas geradas 📜

## Pré Requisitos ✅

Algumas ferramentas são necessárias para executar o projeto. São elas:
- `Golang`:
  - [Instalação do Golang](https://golang.org/doc/install)
- `Docker`:
  - [Instalação do Docker](https://docs.docker.com/get-docker/)
  - Ou simplesmente execute o comando abaixo:
    ```sh
    curl -fsSL https://get.docker.com | sh
    ```
- `Docker Compose`:
  - Se o Docker estiver instalado, o Compose já estará disponível.
- `Taskfile`:
    - [Instalação do Taskfile](https://taskfile.dev/installation/)
    - Ou usando o `Homebrew`:
      ```sh
      brew install go-task
      ```
- `Git`:
  - [Instalação do Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- `melange`:
  - o `melange` será usado como container, portanto basta fazer o pull da imagem:
    ```sh
    docker pull cgr.dev/chainguard/melange:latest
    ```
- `apko`:
  - o `apko` será usado como container, portanto basta fazer o pull da imagem:
    ```sh
    docker pull cgr.dev/chainguard/apko:latest
    ```
- `cosign`:
  - [Instalação do Cosign](https://docs.sigstore.dev/system_config/installation/)
  - a forma mais fácil de instalar o cosign é através do `go`:
    ```sh
    go install sigstore.dev/cosign/cmd/cosign@latest
    ```
- `helm`:
  - [Instalação do Helm](https://helm.sh/docs/intro/install/)
- `kubectl`:
  - [Instalação do Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### Usando o Homebrew (macOS e Linux)
O Homebrew é um gerenciador de pacotes que pode ser usado tanto no macOS quanto no Linux. Para instalar o Homebrew, execute o seguinte comando:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Assim que o Homebrew estiver instalado, você pode instalar o `Taskfile` com o seguinte comando:

```sh
brew install go-task/tap/go-task
```

Assim como a maioria das ferramentas listadas no pré-requisitos, pode-se usar o Homebrew para instalar cada uma delas. Para instalar o `go`, basta executar o seguinte comando:

```sh
brew install go
```
Caso você deseje uma versão específica (como a versão 1.20), pode instalá-la com o seguinte comando:

```sh
brew install go@1.20
```

### Usando a automaćão de instalação dos pré-requisitos

Para facilitar o processo, eu deixei uma task pronta para instalar todas as ferramentas necessárias, basta executar o seguinte comando:

```sh
task pre-reqs
```

> DISCLAIMER 0: O `Homebrew` precisa estar instalado no seu sistema para que a task `pre-reqs` funcione.  

> DISCLAIMER 1: A task `pre-reqs` foi testada apenas no macOS, mas deve funcionar no Linux também.

## Dockerfile

Este `Dockerfile` é utilizado para criar uma imagem Docker para o projeto de gerador de senhas. A imagem é baseada em Python e utiliza o Flask para servir a aplicação.

### Estrutura do Dockerfile

1. **Imagem Base para Build**:
   - Utiliza a imagem `cgr.dev/chainguard/python:latest-dev` como base para o estágio de build.
   - Define o diretório de trabalho como `/app`.
   - Copia o arquivo `requirements.txt` para o diretório de trabalho.
   - Instala as dependências do Python listadas em `requirements.txt`.

2. **Imagem Base para Execução da Aplicação**:
   - Utiliza a imagem `cgr.dev/chainguard/python:latest` como base para o estágio final. Usamos uma imagem da chainguard (distroless) para garantir a segurança e a eficiência da imagem.  
   - Copia as dependências instaladas do estágio de build para a imagem final.
   - Copia a aplicacão (código-fonte) do projeto para o diretório de trabalho.

3. **Configurações de Ambiente**:
   - Define a variável de ambiente `REDIS_HOST` como `redisdb`.
   - Define a variável de ambiente `FLASK_APP` como `/app/app.py`.

4. **Exposição de Porta**:
   - Expõe a porta `5000` para acesso à aplicação Flask.

5. **Ponto de Entrada**:
   - Define o ponto de entrada para iniciar a aplicação Flask.

### Como Construir a Imagem

Para construir a imagem Docker, execute a seguinte `task` do `Taskfile`:

```sh
task build-docker-image:<tag>
```
Esse comando irá fazer o build da imagem Docker com a tag especificada. Ex:

```sh
task build-docker-image:1.0
```

## Como Executar 🚀

1. Clone o repositório:
   ```sh
   git clone https://github.com/ricardosilva86/LINUXtips-PICK.git
   ```

2. Navegue até o diretório do projeto:
   ```sh
   cd LINUXtips-PICK
   ```

3. Execute a task de execução do projeto (com Docker Compose):
    ```sh
    task executar
    ```

## Como Contribuir 🤝

1. Faça um fork do projeto.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`).
4. Faça um push para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

## Licença 📄

Este projeto está licenciado sob a Licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

Feito com 💙 por [LinuxTips](https://linuxtips.io)