# el_app
DICカリキュラム就職タームの万葉課題です。
タスクを管理するアプリを作成します。
# 概要
- 自分のタスクを簡単に登録したい
- タスクに終了期限を設定できるようにしたい
- タスクに優先順位をつけたい
- ステータス（未着手・着手・完了）を管理したい
- ステータスでタスクを絞り込みたい
- タスク名などで指定のタスクを検索したい
- タスクを一覧したい。一覧画面で（優先順位、終了期限などを元にして）ソートしたい
- タスクにラベルなどをつけて分類したい
- ユーザ登録し、自分が登録したタスクだけを見られるようにしたい

これらの要件を満たすアプリを作ります。

# 環境
- ruby 2.6.5
- Rails 5.2.4.3
- PostgreSQL 12.2

# テーブル
## taskテーブル
- title : string
- content : text

# herokuにデプロイする
- herokuにログインする  
`$heroku login`

- アセットプリコンパイルをする  
`$ rails assets:precompile RAILS_ENV=production`

- コミットする  
`$ git add .`  
`$ git commit -m "<コミットメッセージ>"`

- Herokuにアプリケーションを作成  
`$heroku create`

- Herokuにデプロイをする  
`$ git push heroku master`

- データベースの移行  
`$heroku run rails db:migrate`

- アプリケーションにアクセスする  
Herokuアプリのアドレスはhttps://アプリ名.herokuapp.com/のように設定されている。なお、
`$ heroku config` で一行目にアプリ名が表示される。
