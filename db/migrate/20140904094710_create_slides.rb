class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.boolean :showcasable

      t.timestamps
    end
  end
end
