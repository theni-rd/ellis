FROM python:3.11-slim

# Define variáveis de ambiente para otimizar a execução em contêineres
# PYTHONDONTWRITEBYTECODE: Impede o Python de criar arquivos .pyc
# PYTHONUNBUFFERED: Garante que os logs sejam enviados diretamente para o terminal
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências e as instala
# Fazer isso em um passo separado aproveita o cache do Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que a aplicação irá rodar
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
