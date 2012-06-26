class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :hl
      t.string :src
      t.string :link

      t.timestamps
    end
  end
end
