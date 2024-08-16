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

Para construir a imagem Docker, execute o seguinte comando no terminal, no diretório onde o `Dockerfile` está localizado:

```sh
docker build -t <your_image_name> .
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

3. Instale as dependências:
   ```sh
   pip install -r requirements.txt
   ```

4. Execute a aplicação:
   ```sh
   python app.py
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