# Etapa 1: "Builder" - Instalação de dependências
# Usamos uma imagem base específica e estável para garantir a reprodutibilidade.
# A tag 'slim' oferece um bom equilíbrio entre tamanho e ferramentas disponíveis.
FROM python:3.12-slim-bookworm as builder

# Define o diretório de trabalho
WORKDIR /app

# Define variáveis de ambiente para otimizar o Python no Docker
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Instala as dependências do sistema, se necessário (ex: para compilar pacotes).
# A imagem 'slim' já vem com o essencial, mas se precisar de algo, adicione aqui.
# RUN apt-get update && apt-get install -y --no-install-recommends build-essential

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Esta camada só será invalidada se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências do Python em um ambiente virtual dentro do builder.
# Isso isola as dependências e facilita a cópia para a próxima etapa.
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta em que a aplicação vai rodar.
EXPOSE 8000

# Comando para iniciar a aplicação.
# Usar 0.0.0.0 torna a aplicação acessível de fora do contêiner.
# O comando padrão não inclui --reload, que é mais adequado para o ambiente de desenvolvimento.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
