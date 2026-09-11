FROM golang:1.21-alpine

WORKDIR /expressappdir

RUN addgroup -S express && adduser -S express -G express

COPY . .
RUN go build -o app .

RUN chown -R express:express /expressappdir
USER express

EXPOSE 8080

CMD ["./app"]
