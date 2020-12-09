# 基となるDockerイメージの指定
FROM golang:1.14-alpine AS builder

# go modulesの設定
ENV GO111MODULE on

# /goがWORKDIRになっているので変更
WORKDIR /go/src/app

# docker-hands-onのfileをWORKDIRに追加
COPY . .

# modulesのダウンロード
RUN go mod download

# ビルド
RUN go build -o main

# マルチステージビルド
FROM alpine:3.11.6

COPY --from=builder /go/src/app/main .

# ./mainを実行
CMD ["./main"]
