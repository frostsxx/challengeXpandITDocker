1 - Navigate to the directory containing the Dockerfile.\
2 - Build the Docker image using the following command:
```
docker build -t webapp .
```
3 - Run the Docker container:
```
docker run -d -p 4041:4041 webapp
```
4 - Open a web browser and navigate to the following URL:
```
https://localhost:4041/sample
```
