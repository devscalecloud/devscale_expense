FROM golang:1.21-alpine
WORKDIR /expressappdir
# Create group and user named "express"
RUN addgroup -S express && adduser -S express -G express
# Copy source code and build the application
COPY . .
RUN go build -o devscale_expense_app .
EXPOSE 8080
# Run the application as the express user, not root
USER express
CMD ["./devscale_expense_app"]
