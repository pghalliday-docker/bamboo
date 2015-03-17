# bamboo

To build

```
docker build --rm --tag=pghalliday/bamboo .
```

To run

```
docker run -p 0.0.0.0:8085:8085 -i -t pghalliday/bamboo
```

Map the following volume to persist bamboo data

```
/var/atlassian/application-data/bamboo 
```
