FROM ubuntu:20.04 AS cgo_build
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update 
RUN apt-get -y install build-essential golang

WORKDIR /tmp/app/
COPY ./app/ /tmp/app/
RUN pwd
RUN ls
RUN go mod download
RUN CGO_ENABLED=1 go build -o app

FROM ubuntu:20.04 AS cgo_prod
WORKDIR /app/
COPY --from=cgo_build /tmp/app/app .

CMD ["./app"]
