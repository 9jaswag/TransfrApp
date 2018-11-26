class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :uploads, :name, unique: true
  end
end
