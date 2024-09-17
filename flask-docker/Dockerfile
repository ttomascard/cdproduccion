FROM python:3.10-alpine AS builder

WORKDIR /app

COPY requirements.txt /app
RUN pip3 install -r requirements.txt

COPY app.py /app

EXPOSE 8080
ENTRYPOINT ["python3"]
CMD ["app.py"]