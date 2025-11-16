class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
