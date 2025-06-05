FROM debian:latest AS build
WORKDIR /app

RUN apt update && apt install -y git curl
RUN git clone https://github.com/acmesh-official/acme.sh.git
WORKDIR /app/acme.sh
RUN ./acme.sh --install --force


FROM nginx:latest

COPY --from=build /root/.acme.sh /root/.acme.sh
COPY --from=build /root/.profile /root/.profile
WORKDIR /root/.acme.sh
RUN mkdir certificates

EXPOSE 80
