FROM golang:alpine3.20 AS builder

WORKDIR /src

COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN GOOS=linux GOARCH=amd64 go build -o app .

FROM alpine:3.20
WORKDIR /usr/local/bin

COPY --from=builder /src/app .

EXPOSE 4500

CMD app