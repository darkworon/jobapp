# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120406163809) do

  create_table "activations", :force => true do |t|
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "banking_details", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "bank_name"
    t.string   "city"
    t.string   "current_account"
    t.string   "correspondent_account"
    t.string   "bik"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "short_name",    :limit => 256
    t.string   "official_name", :limit => 256
    t.string   "address"
    t.string   "legal_address"
    t.string   "phone_1",       :limit => 20
    t.string   "phone_2",       :limit => 20
    t.string   "email_1",       :limit => 128
    t.string   "email_2",       :limit => 128
    t.string   "inn",           :limit => 14
    t.string   "kpp",           :limit => 14
    t.string   "ogrn",          :limit => 30
    t.string   "website",       :limit => 256
    t.text     "description"
    t.integer  "owner_id",      :limit => 8
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "career"
    t.string   "city"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "salary"
    t.date     "birthdate"
    t.integer  "experience_period"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.integer  "type_of_job"
    t.integer  "education"
    t.integer  "sex"
    t.integer  "min_age",                         :default => 22
    t.integer  "max_age",                         :default => 50
    t.string   "type"
    t.integer  "user_id"
    t.datetime "list_date",                                         :null => false
    t.integer  "company_id"
    t.string   "uin",               :limit => 36
    t.integer  "status",                          :default => 0
    t.integer  "priority",                        :default => 1
    t.boolean  "delta",                           :default => true, :null => false
  end

  add_index "jobs", ["title", "description", "career", "city"], :name => "fulltext_jobs"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pricelist_id"
    t.decimal  "sum",                 :precision => 8, :scale => 2, :default => 0.0
    t.integer  "payment_provider_id"
    t.integer  "transaction_id"
    t.datetime "transaction_date"
    t.datetime "due_date"
    t.datetime "date_start"
    t.integer  "quantity_remained"
    t.integer  "status",                                            :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.datetime "date_end"
  end

  create_table "password_recovers", :force => true do |t|
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_providers", :force => true do |t|
    t.string   "name"
    t.string   "payment_url"
    t.string   "website"
    t.boolean  "is_online_payment", :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "pricelists", :force => true do |t|
    t.string   "name"
    t.decimal  "price",                   :precision => 8, :scale => 2, :default => 0.0
    t.integer  "period",                                                :default => 10
    t.boolean  "available_for_companies",                               :default => false
    t.integer  "status",                                                :default => 0
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
    t.integer  "entry_type"
    t.integer  "quantity"
    t.boolean  "auto_activate",                                         :default => false
  end

  create_table "purchase_actions", :force => true do |t|
    t.integer  "order_id",     :limit => 8
    t.datetime "shedule_date"
    t.string   "entry_uin"
    t.integer  "status",                    :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "resume_responses", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "vacancy_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "status",              :default => 0
    t.boolean  "viewed_by_recipient", :default => false
    t.boolean  "viewed_by_sender",    :default => true
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "city"
    t.string   "phone"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "status",          :default => 0
    t.string   "time_zone",       :default => "Moscow"
    t.date     "birthdate"
  end

  create_table "vacancy_responses", :force => true do |t|
    t.integer  "vacancy_id"
    t.integer  "resume_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "status",              :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "viewed_by_recipient", :default => false
    t.boolean  "viewed_by_sender",    :default => true
  end

end
