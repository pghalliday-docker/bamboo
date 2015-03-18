# bamboo

To build

```
docker build --rm --tag=pghalliday/bamboo .
```

To run

```
docker run -p 0.0.0.0:8085:8085 -i -t pghalliday/bamboo
```

Mounts the following volume for persistent data

```
/var/atlassian/application-data/bamboo 
```

Set the following environment variables to configure the server

```
BAMBOO_PROXY_NAME - the host name if using a reverse proxy
BAMBOO_PROXY_PORT - the port if using a reverse proxy
```
