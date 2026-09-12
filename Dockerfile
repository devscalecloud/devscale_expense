FROM golang:1.21-alpine

WORKDIR /expressappdir

RUN addgroup -S express && adduser -S express -G express

COPY . .

RUN go build -o expenseapp .

EXPOSE 8080

USER express

CMD ["./expenseapp"]
