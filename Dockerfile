FROM golang:latest as builder

WORKDIR /app
COPY . .
RUN go get -d -v .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o dyndns-netcup-go .

FROM alpine:latest  

RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/dyndns-netcup-go .
CMD ["./dyndns-netcup-go"] 