# README

* Database
task
|     物理名     | データ型  |
| ------------- | -------- |
|      id       |  integer |
|   task_name   |  string  |
|     detail    |  text    |
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
