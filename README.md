# README

* Database  

task  
|     物理名     | データ型  |
| ------------- | -------- |
|      id       |  integer |
|     title     |  string  |
|     contet    |  text    |
|   deadline    |  date    |
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

label  
|    物理名      | データ型  |
| ------------- | -------- |
|      id       |  integer |
|  label_name   |  string  |

labeling  
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