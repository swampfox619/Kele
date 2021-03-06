require 'rubygems'
require 'httparty'
require 'json'
require_relative 'roadmap.rb'

class Kele
    include HTTParty
    include Roadmap

    base_uri 'https://www.bloc.io/api/v1'
    
    def initialize(username, password)
        response = self.class.post("/sessions", body: 
        { 
            "email": username, 
            "password": password 
        })
        @authorization_token = response["auth_token"]
        raise ArgumentError, 'You must input a proper username and password combination' if response["auth_token"] == nil
    end

    def get_me
        response = self.class.get("/users/me", headers: { "authorization" => @authorization_token })
        @current_user = JSON.parse(response.body)
    end

    def get_mentor_availability(id)
        response = self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @authorization_token }, body: { "id" => "#{id}" } )
        @availability = JSON.parse(response.body)
    end
    
    def get_messages(number)
        response = self.class.get("/message_threads", headers: { "authorization" => @authorization_token }, body: { "page" => "#{number}" } )
        @messages = JSON.parse(response.body)    
    end
    
    def create_message(subject, body)
        self.class.post("/messages", headers: { "authorization" => @authorization_token }, body: {
            "sender" => "lew.vine@gmail.com", "recipient_id" => 2364248, "subject" => "#{subject}", "body" => "#{body}" } )
    end
    
    def create_submission(checkpoint_id, comment)
        @enrollment_id = 27384
        self.class.post("/checkpoint_submissions", 
            headers: { "authorization" => @authorization_token}, 
            body: { "checkpoint_id" => checkpoint_id, "comment" => "#{comment}", "enrollment_id" => @enrollment_id }
        )
    end
end
