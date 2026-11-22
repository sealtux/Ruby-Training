# Each day uses its own persistent database. This also runs against temporary test databases.
connection = ActiveRecord::Base.connection
unless connection.table_exists?(:users)
  ActiveRecord::Schema.define do
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :completed, null: false, default: false
      t.references :user, foreign_key: true, null: ENV.fetch("TRAINING_DAY", "6").to_i < 9
      t.timestamps
    end
    create_table :comments do |t|
      t.text :body, null: false
      t.references :task, foreign_key: true, null: false
      t.timestamps
    end
  end
end

if ENV.fetch("TRAINING_DAY", "6").to_i >= 10 && !connection.table_exists?(:events)
  ActiveRecord::Schema.define do
    create_table :events do |t|
      t.string :title, null: false
      t.string :location, null: false
      t.text :description
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end

    create_table :guests do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :event, foreign_key: true, null: false
      t.timestamps
    end
  end
end
