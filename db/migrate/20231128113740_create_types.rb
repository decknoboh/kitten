class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|

      t.string :name,  null: false
      t.string :body_length,  null: false
      t.string :country,  null: false
      t.text :detail,  null: false

      t.timestamps
    end
  end
end
