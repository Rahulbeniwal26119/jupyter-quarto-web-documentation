FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    pandoc \
    sudo \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    dpkg -i quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

EXPOSE 8000

RUN quarto render .

CMD ["python", "-m", "http.server", "8000", "--directory", "_site"]

# docker run -p 8000:8000 covid