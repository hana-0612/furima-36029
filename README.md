# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false, unique: true |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| kana_first_name    | string  | null: false               |
| kana_last_name     | string  | null: false               |
| date_of_birth      | integer | null: false               |

### Association

- has_many : products
- has_many : purchase_records

## products テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| title                | string     | null: false                    |
| product_description  | text       | null: false                    |
| category_id          | integer    | null: false                    |
| product_condition_id | integer    | null: false                    |
| shipping_charges_id  | integer    | null: false                    |
| shipping_area_id     | integer    | null: false                    |
| shipping_ship_id     | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belong_to : user
- has_one   : purchase_record

## purchase_records テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one    :address

## addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| house_number     | string     | null: false                    |
| building_name    | string     |                                |
| telephone_number | string     | null: falise                   | 
| purchase_record  | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record