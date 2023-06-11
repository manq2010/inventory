class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images, id: :uuid do |t|
      t.string :url
      t.string :slug, :null => false
      
      t.timestamps
    end

    add_index :images, :slug, unique: true
  end
end
