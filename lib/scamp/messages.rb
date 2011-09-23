class Scamp
  module Messages
    
    def say(message, room_id_or_name)
      send_message(room_id_or_name, message, "Textmessage")
    end
    
    def play(sound, room_id_or_name)
      send_message(room_id_or_name, sound, "SoundMessage")
    end
    
    private
    
    #  curl -vvv -H 'Content-Type: application/json' -d '{"message":{"body":"Yeeeeeaaaaaahh", "type":"Textmessage"}}' -u API_KEY:X https://37s.campfirenow.com/room/293788/speak.json
    def send_message(room_id_or_name, payload, type)
      # post 'speak', :body => {:message => {:body => message, :type => type}}.to_json
      url = "https://#{subdomain}.campfirenow.com/room/#{room_id(room_id_or_name)}/speak.json"
      http = EventMachine::HttpRequest.new(url).post :head => {'Content-Type' => 'application/json', 'authorization' => [api_key, 'X']}, :body => Yajl::Encoder.encode({:message => {:body => payload, :type => type}})
      http.errback { logger.error "Error speaking: '#{message}' to #{room_id(room_id_or_name)}" } 
    end
      
  end
end