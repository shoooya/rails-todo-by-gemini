FROM ruby:3.2.2

# Node.js, Yarn, PostgreSQL clientのインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# 作業ディレクトリの作成
WORKDIR /todo-app

# Gemfileをコンテナにコピー
COPY Gemfile /todo-app/Gemfile
# Gemfile.lockがまだないので、COPYは後でrails newの後にbuildする際に有効になる
# COPY Gemfile.lock /todo-app/Gemfile.lock

# bundle installの実行
# 初回はGemfile.lockがないので、rails newの後に実行する
# RUN bundle install

# entrypoint.shをコンテナにコピー
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# コンテナ起動時に実行されるコマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
