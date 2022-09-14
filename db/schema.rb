# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_220_913_131_145) do # rubocop:disable Metrics/BlockLength
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
  end

  create_table 'coupons', force: :cascade do |t|
    t.string 'name'
    t.integer 'value'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'title'
    t.integer 'price'
    t.text 'description'
    t.integer 'status'
    t.bigint 'category_id'
    t.bigint 'coupon_id'
    t.index ['category_id'], name: 'index_products_on_category_id'
    t.index ['coupon_id'], name: 'index_products_on_coupon_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'user_name'
    t.string 'first_name'
    t.string 'last_name'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'products', 'categories'
end
