class CreateImages < ActiveRecord::Migration[7.0]
  def self.up
    create_table :images, id: :uuid do |t|
      t.string :url
      
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
