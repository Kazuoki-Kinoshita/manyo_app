# README

* Database  

task  
|     物理名     | データ型  |
| ------------- | -------- |
|      id       |  integer |
|     title     |  string  |
|     contet    |  text    |
|  expired_at   |  date    |
|     status    |  string  |
|   priority    |  string  |
|    user_id    |  integer |

user  
|    物理名      | データ型  |
| ------------- | -------- |
|      id       |  integer |
|     name      |  string  |
|    email      |  string  |
|password_digest|  string  |
|    admin      |  boolean |

tag  
|    物理名      | データ型  |
| ------------- | -------- |
|      id       |  integer |
|     name      |  string  |

tagging  
|    物理名      | データ型  |
| ------------- | -------- |
|      id       |  integer |
|   label_id    |  integer |
|    task_id    |  integer |

* herokuのデプロイ方法

1. Gemfileに追加するGem
    1. gem 'net-smtp'
    1. gem 'net-imap'  
    1. gem 'net-pop'
2. デプロイ方法
    1. herokuにログイン：`heroku login`
    1. アプリをgitの管理下に置く：`git init`
    1. herokuにアプリを作成：`heroku create`
    1. 全てのフォルダやファイルを管理対象にすることを明示：`git add .`
    1. 現在の状態をコメント付きで保存：`git commit -m “メッセージ”`
    1. 現在の状態をherokuに送信：`git push heroku master`
    1. Heroku上にデータベース作成：`heroku run rails db:migrate`
    1. アプリを開く：`heroku open`

# README

## 開発言語
- Ruby 3.0.1
- Rails 6.1.6

## 就業Termの技術
- devise
- rails_admin
- cancancan
- carrierwave
- kaminari
- フォロー機能
- メッセージ機能

## カリキュラム外の技術
- Google map API
- geocoder
- ransack
- simple_calendar

## 実行手順
```
$git clone git@github.com:Kazuoki-Kinoshita/farm_link.git
$cd farm_link
$bundle install
$yarn install
$rails db:create && rails db:migrate
$rails s
```

## カタログ設計
https://docs.google.com/spreadsheets/d/148I2Z3vRf-EKBWjTOgoPCv3j0jTmryozKNh3qZ6jUsk/edit#gid=1338661474

## テーブル定義書
https://docs.google.com/spreadsheets/d/148I2Z3vRf-EKBWjTOgoPCv3j0jTmryozKNh3qZ6jUsk/edit#gid=2020033787

## ワイヤーフレーム
https://cacoo.com/diagrams/BuuQyis91N3eU0lV/47463

## ER図

## 画面遷移図

