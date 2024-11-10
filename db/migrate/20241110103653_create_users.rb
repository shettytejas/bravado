class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name

      t.string :username, null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
