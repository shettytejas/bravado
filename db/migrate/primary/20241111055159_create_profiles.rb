class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.text :bio
      t.string :country_code, limit: 2
      t.integer :height_in_cm, limit: 3
      t.integer :weight_in_kg, limit: 3

      t.date :birth_date

      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.timestamps
    end
  end
end
