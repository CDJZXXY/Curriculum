
# Docker 学习笔记

## Docker 是什么
Docker 是一个开源的平台，允许开发者通过容器来自动化应用程序的部署、扩展和管理。容器提供了轻量级的虚拟化环境，将应用及其依赖打包在一起，确保在各种环境中一致运行。

## Docker-Compose 是什么
Docker-Compose 是 Docker 的一个工具，用于定义和运行多容器的 Docker 应用程序。通过 `docker-compose.yml` 文件，可以使用单个命令来启动多个相互关联的容器。

## 容器和镜像的区别是什么
- **镜像（Image）**：是应用程序及其依赖的静态快照，类似于一个模板，不能直接运行。
- **容器（Container）**：是从镜像创建的一个运行实例，容器是动态的，允许读写操作。

## Docker Hub 是什么
Docker Hub 是一个公共的 Docker 镜像仓库，用户可以在上面查找、分享和存储镜像。它提供了官方镜像、社区贡献镜像以及私有仓库功能。

## Dockerfile 是什么
Dockerfile 是一个文本文件，其中包含构建 Docker 镜像的所有指令。这些指令可以定义操作系统、依赖库、配置文件等，构建时会逐条执行指令创建镜像。

## 通过 docker 命令登录容器的方法
使用以下命令登录正在运行的 Docker 容器：
```
docker exec -it <container_id> /bin/bash
```

## 通过 docker compose 命令登录容器的方法
通过 Docker Compose 管理的容器，可以使用以下命令登录：
```
docker compose exec <service_name> /bin/bash
```

## `docker-compose` 命令与 `docker compose`（Docker 命令的子命令 compose）的区别
`docker-compose` 是一个独立的命令行工具，需要单独安装。而 `docker compose` 是 Docker CLI 的一部分，作为子命令使用，无需单独安装。

## `docker build` 命令的作用是什么
`docker build` 命令用于从 Dockerfile 构建 Docker 镜像。

## 显示本地环境中所有 Docker 镜像的命令
```
docker images
```

## 显示本地环境中所有 Docker 容器的命令
```
docker ps -a
```

## `docker-compose up -d` 中 `-d` 选项的作用是什么
`-d` 选项表示以后台模式运行容器，启动后不占用当前终端。

## Dockerfile 中的「命令」是什么
Dockerfile 中的「命令」指的是 Dockerfile 中的指令（如 `RUN`, `CMD`, `ENTRYPOINT`），用于定义镜像构建时的操作或容器启动时要执行的命令。
