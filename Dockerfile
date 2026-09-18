# Start from a small Linux image that already has Go 1.21 installed
FROM golang:1.21-alpine          

# Set /expenseappdir  as the folder where all following commands run. 
WORKDIR /expenseappdir                     

# Copy just the dependency list into the image. 
COPY go.mod ./     

# Download the dependencies from go.mod into the module cache (not compiled yet) - cached, so it only reruns if go.mod changes
RUN go mod download              

# Copy the rest of your source code into /expenseappdir  
COPY . .                         

# Compile the code into a single executable named "devscale-bank"
RUN go build -o devscale-bank .  

# Create a non-root user and group called "express_user" and "express_group" respectively for safety
RUN addgroup -S express_group && adduser -S express_user -G express_group

# Set an environment variable the app can read to know which port to use
ENV PORT=8080                    

# Document that the container listens on port 8080
EXPOSE 8080                      

# Switch to the non-root user, so the app doesn't run with admin rights
USER express_user                         

# The command that runs when the container starts
CMD ["./devscale-bank"]          