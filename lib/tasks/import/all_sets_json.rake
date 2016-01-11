namespace :import do
  task :all_sets_json => [:environment] do
    json_file_path = File.join(Rails.root, 'tmp', 'AllSets.json')

    unless File.exists?(json_file_path)
      show_no_file_error
    end

    file_lines = File.readlines(json_file_path)

    sets = JSON.parse file_lines.join('')

    sets.each do |set_code, set_data|
      put_status "processing set: #{set_code}"
      series = Series.by_code(set_code).first

      if !series 
        put_status "adding set: #{set_code}"
        series = Series.create(data: set_data.select {|k,v| k != 'cards'})
      else
        put_status "using set: #{set_code}"
      end

      set_data['cards'].each do |card_data|
        put_status "processing card: #{card_data['id']}"
        card = Card.by_sha_id(card_data['id']).first

        if !card
          put_status "adding card: #{card_data['id']}"
          card = Card.create(data: card_data)
        else
          put_status "using card: #{card_data['id']}"
        end 
      end
    end
  end

end

def put_status(msg)
  puts Paint[msg, :green, :bright] 
end

def show_no_file_error
  raise <<-plaintext
    Please place the AllSets.json file in the application's tmp folder
    `wget -O tmp/AllSets.json.zip http://mtgjson.com/json/AllSets.json.zip ; cd tmp/; unzip AllSets.json.zip; ls; cd -`
  plaintext
end
