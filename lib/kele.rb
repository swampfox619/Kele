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
        @availability = JSON.parse(response.body).to_a
    end
    
end
