# Utiliza una imagen base oficial de Python
FROM python:3.10-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo de requerimientos y el código de la aplicación
COPY frontend/requirements.txt .
COPY frontend/app.py .

# Instalar las dependencias de la aplicación
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto en el que correrá Streamlit
EXPOSE 8501

# Definir la variable de entorno para evitar problemas en Docker
ENV PYTHONUNBUFFERED=1

# Comando para ejecutar la aplicación Streamlit
CMD ["streamlit", "run", "function_app.py", "--server.enableCORS", "false", "--server.port", "8501"]
