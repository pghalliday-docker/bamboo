# bamboo

To build

```
docker build --rm --tag=pghalliday/bamboo .
```

To run

```
docker run -p 127.0.0.1:8085:8085 -t pghalliday/bamboo
```

Map the following volume to persist bamboo data

```
/var/atlassian/application-data/bamboo 

```
