class CreateMediaFinders < ActiveRecord::Migration[7.0]
  def change
    create_table :media_finders do |t|
      t.string :url,               null: false
      t.string :search_class_name, null: false
      t.jsonb :search_params,      default: {}
      t.integer :view_count,       default: 0

      t.timestamps
    end
  end
end
