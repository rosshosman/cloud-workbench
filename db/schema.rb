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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140627112533) do

  create_table "benchmark_definitions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "vagrantfile"
    t.integer "running_timeout"
    t.string "provider_name"
    t.index ["name"], name: "index_benchmark_definitions_on_name", unique: true
  end

  create_table "benchmark_executions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "benchmark_definition_id"
    t.boolean "keep_alive", default: false
    t.index ["benchmark_definition_id"], name: "index_benchmark_executions_on_benchmark_definition_id"
  end

  create_table "benchmark_schedules", force: :cascade do |t|
    t.string "cron_expression"
    t.boolean "active", default: true
    t.integer "benchmark_definition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "consecutive_failure_count", default: 0
    t.index ["benchmark_definition_id"], name: "index_benchmark_schedules_on_benchmark_definition_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", force: :cascade do |t|
    t.integer "name"
    t.datetime "happened_at"
    t.integer "traceable_id"
    t.string "traceable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "message"
  end

  create_table "metric_definitions", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "benchmark_definition_id"
    t.string "scale_type"
    t.index ["name", "benchmark_definition_id"], name: "index_metric_definitions_on_name_and_benchmark_definition_id", unique: true
  end

  create_table "nominal_metric_observations", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "time", limit: 8
    t.integer "virtual_machine_instance_id"
    t.integer "metric_definition_id"
    t.index ["metric_definition_id"], name: "index_nominal_metric_observations_on_metric_definition_id"
    t.index ["virtual_machine_instance_id"], name: "index_nominal_metric_observations_on_vm_instance_id "
  end

  create_table "ordered_metric_observations", force: :cascade do |t|
    t.integer "metric_definition_id"
    t.integer "virtual_machine_instance_id"
    t.integer "time", limit: 8
    t.float "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["metric_definition_id"], name: "index_ordered_metric_observations_on_metric_definition_id"
    t.index ["virtual_machine_instance_id"], name: "index_ordered_metric_observations_on_vm_instance_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "virtual_machine_instances", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "benchmark_execution_id"
    t.string "provider_name"
    t.string "provider_instance_id"
    t.string "role"
    t.index ["benchmark_execution_id"], name: "index_virtual_machine_instances_on_benchmark_execution_id"
    t.index ["provider_instance_id", "provider_name"], name: "index_vm_instances_on_provider_instance_id_and_provider_name"
  end

end
