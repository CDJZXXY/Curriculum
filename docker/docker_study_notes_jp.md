
# Docker 学習メモ

## Dockerとは
Dockerは、開発者がアプリケーションのデプロイ、スケール、および管理をコンテナを使用して自動化するためのオープンプラットフォームです。コンテナは、軽量な仮想化環境を提供し、アプリケーションとその依存関係を一緒にパッケージ化して、さまざまな環境で一貫して動作させることができます。

## Docker-Composeとは
Docker-Composeは、複数のコンテナからなるアプリケーションを定義し、実行するためのDockerツールです。`docker-compose.yml` ファイルを使用して、関連する複数のコンテナを単一のコマンドで起動できます。

## コンテナとイメージの違いとは
- **イメージ（Image）**：アプリケーションやその依存関係の静的スナップショットであり、テンプレートのようなものです。直接実行はできません。
- **コンテナ（Container）**：イメージから作成された実行可能なインスタンスで、動的に動作し、読み書きが可能です。

## Docker Hubとは
Docker Hubは、Dockerイメージを検索、共有、保存するための公共のリポジトリです。公式のイメージや、コミュニティが作成したイメージ、そしてプライベートリポジトリが提供されています。

## Dockerfileとは
Dockerfileは、Dockerイメージを作成するための手順を定義したテキストファイルです。OS、依存ライブラリ、設定ファイルなどを定義し、ビルド時にこれらの指示が実行され、イメージが作成されます。

## dockerコマンドでコンテナにログインする方法は
実行中のDockerコンテナにログインするには、次のコマンドを使用します：
```
docker exec -it <container_id> /bin/bash
```

## docker composeコマンドでdockerコンテナにログインする方法は
Docker Composeで管理されているコンテナにログインするには、次のコマンドを使用します：
```
docker compose exec <service_name> /bin/bash
```

## `docker-compose` コマンドと `docker compose`（docker コマンドのサブコマンドの compose）の違いは
`docker-compose` は独立したCLIツールで、別途インストールが必要です。一方、`docker compose` はDocker CLIの一部であり、サブコマンドとして使用され、インストールは不要です。

## docker buildコマンドの役割は
`docker build` コマンドは、DockerfileをもとにDockerイメージを構築するためのコマンドです。

## 現在ローカル環境にあるdockerイメージの一覧を表示するコマンドは
```
docker images
```

## 現在ローカル環境にあるdockerコンテナの一覧を表示するコマンドは
```
docker ps -a
```

## `docker-compose up -d` の `-d` オプションの役割は
`-d` オプションは、コンテナをバックグラウンドで実行することを意味し、実行後に端末がブロックされません。

## dockerfileにおける「コマンド」とは
Dockerfileにおける「コマンド」とは、イメージ構築時の操作（`RUN`, `CMD`, `ENTRYPOINT` など）や、コンテナ起動時に実行する指示を指します。
