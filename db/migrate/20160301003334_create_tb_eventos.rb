class CreateTbEventos < ActiveRecord::Migration
  def change
    create_table :tb_eventos do |t|
      t.string :nome
      t.datetime :data
      t.text :descricao
      t.text :local
      t.integer :limite_participantes

      t.timestamps null: false
    end
  end
end
