json.array!(@tb_eventos) do |tb_evento|
  json.extract! tb_evento, :id, :nome, :data, :descricao, :local, :limite_participantes
  json.url tb_evento_url(tb_evento, format: :json)
end
