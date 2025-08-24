 # Use uma imagem base oficial do Python
 FROM python:3.10-slim
 
 # Defina a variável de ambiente para garantir que a saída do Python seja enviada diretamente para o terminal
 ENV PYTHONUNBUFFERED 1
 
 # Defina o diretório de trabalho dentro do contêiner
 WORKDIR /app
 
 # Copie o arquivo de dependências para o diretório de trabalho
 COPY requirements.txt .
 
 # Instale as dependências
 RUN pip install --no-cache-dir --upgrade -r requirements.txt
 
 # Copie todo o código da aplicação para o diretório de trabalho
 COPY . .
 
 # Comando para executar a aplicação quando o contêiner iniciar
 # O Cloud Run injeta a variável de ambiente $PORT, que o Uvicorn usará.
 CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
