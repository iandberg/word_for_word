class CreateWordLinks < ActiveRecord::Migration
  def change
    create_table :word_links do |t|
      t.integer :subject_id
      t.integer :list_id
      t.text :subject_type

      t.timestamps
    end
  end
end
