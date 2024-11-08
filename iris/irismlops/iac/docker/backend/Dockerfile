FROM python:3.10-slim AS builder
WORKDIR /app
COPY backend/requirements.txt /app
RUN pip3 install -r requirements.txt
COPY data/models/price-house-v1.json /app
COPY backend/src /app/src
EXPOSE 8080
ENTRYPOINT ["python3"]
CMD ["src/app.py"]
