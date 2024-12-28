# Osnovna slika, koristiš sliku sa Python-om ili Go-om, zavisno od aplikacije
FROM golang:1.20 AS builder

# Instalacija potrebnih paketa
RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Postavljanje radnog direktorijuma
WORKDIR /app

# Dodaj fajlove iz lokalnog direktorijuma u Docker kontejner
COPY . .

# Kompajliranje aplikacije
RUN GOOS=linux GOARCH=amd64 go build -v -o streammyaudio.exe

# Setovanje imena strima kao ENV varijabla
ENV STREAM_NAME=Galaksija

# Otvoreni portovi koje aplikacija koristi
EXPOSE 8000-10000

# Startovanje aplikacije
CMD ["./streammyaudio", "Galaksija", "--port", "10000"]
