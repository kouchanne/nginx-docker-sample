# ベースイメージを定義
FROM nginx:1.13.1-alpine AS production-stage

# 環境変数をセット
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# コンテナ内でmkdirコマンドを実行
RUN mkdir -p /var/log/nginx/log\
    && mkdir /home/www\
    && mkdir /home/www/document-root


# カレントディレクトリのindex.htmlを/home/www/document-root/へコピー
COPY ./index.html /home/www/document-root/
ADD ./work/app.conf /etc/nginx/conf.d/app.conf
ADD ./work/server.crt /etc/nginx/server.crt
ADD ./work/server.key /etc/nginx/server.key

RUN chmod 755 -R /var
RUN chmod 400 /etc/nginx/server.key

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]