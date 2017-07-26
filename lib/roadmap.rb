module Roadmap

    def get_roadmap(roadmap_id)
        response = self.class.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @authorization_token }, body: { "id" => "#{roadmap_id}"} )
        @roadmap = JSON.parse(response.body).to_a
    end

    def get_checkpoint(checkpoint_id)
        response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @authorization_token })
        @checkpoint = JSON.parse(response.body)
    end
    
end