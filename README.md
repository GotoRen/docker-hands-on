# docker-hands-on

## ![#FF0000](https://via.placeholder.com/15/ff0000/000000?text=+) __Builder pattern (single-stage build)__
## 🚀 実行
```
### Dockerfileのビルド（ShellScriptを実行）
$ sh build.sh
  
### Dockerfileの実行
$ docker run -d -p 8081:8081 --name test01 ren1007/single

### 確認
=== * 起動するDockerコンテナ * ===
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
90536aac534f        ren1007/single      "./app"             9 seconds ago       Up 8 seconds        0.0.0.0:8081->8081/tcp   test01

=== * 作成されるDockerイメージ * ===
$ docker images
ren1007/single              latest              c524533c2160        About a minute ago   11.7MB
ren1007/single              build               3c842df2a673        About a minute ago   693MB
      
### コンテナに入る & ディレクトリの確認
$ docker exec -it test01 sh
~ # pwd
/root
~ # ls
app

### ローカルホスト8081番ポートにcurlを投げる
$ curl localhost:8081 -i
HTTP/1.1 200 OK
Date: Wed, 09 Dec 2020 19:27:07 GMT
Content-Length: 13
Content-Type: text/plain; charset=utf-8
    
Hello, World!    
```

## ⚡ 動作
- `Dockerfile.build`
  - `FROM`：goのイメージを取得
  - `WORKDIR`：コンテナ内作業ディレクトリを設定
  - `COPY`：`Dockerfile.build`と同階層に存在する`app.go`を`WORKDIR`に配置
  - `RUN`：コマンドを実行（`app.go`の実行ファイルを作成）
- `Dockerfile`
  - `FROM`：alpineのイメージを取得
  - `RUN`：alpineに証明書を付与
  - `WORKDIR`：コンテナ内作業ディレクトリを設定
  - `COPY`：`Dockerfile`と同階層に存在するapp.goを`WORKDIR`に配置
  - `CMD`：コマンドを実行（`app.go`を実行）
- `build.sh` 
  - スクリプトを実行すると`Dockerfile.build`イメージがビルドされる
  - そこからコンテナを生成してイメージ内容をコピーし、`Dockerfile`イメージがビルドされる
  - 良くないところ
    - 2つのイメージはそれなりの容量をとる
      - `build`（`Dockerfile.build`）：693MB
      - `latest`（`Dockerfile`）：11.7MB
    - 実行形式ファイル`app`も残ったまま