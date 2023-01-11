FROM fukamachi/qlot:latest

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install build-essential -y
RUN qlot install

ENV PATH $PATH:/app/.qlot/bin

EXPOSE 3000

ENTRYPOINT ["qlot", "exec", "clackup", "-s", "jingle-app", "--address", "0.0.0.0", "--port", "3000", "./src/app.lisp"]
