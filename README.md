# rockylinux_grafana

Rocky Linux based Grafana Docker image.

## Usage

```bash
$ make

  TARGETS
    build  ... Build docker image local/rockylinux_grafana
    clean  ... Clean docker image local/rockylinux_grafana
    run    ... Run docker container using image local/rockylinux_grafana
    attach ... Attach on docker container using image local/rockylinux_grafana
    stop   ... Stop docker container which was created by run target

```

### Build docker image

```bash
$ make build
```

### Run container

```bash
$ make run
```

### Attach on container

```bash
$ make attach
```

### Stop container

```bash
$ make stop
```

### Delete docker image

```bash
$ make clean
```
