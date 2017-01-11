class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :token, limit: 32, null: false
      t.string :image
      t.timestamps

      t.index :token, unique: true
    end
  end
end
