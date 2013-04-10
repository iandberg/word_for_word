class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :user_id
      t.text :subject
      t.integer :syllables
      t.references :word_link

      t.timestamps
    end
    add_index :words, :word_link_id
  end
end
