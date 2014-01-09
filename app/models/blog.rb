class Blog < ActiveResource::Base
  self.site = "http://localhost:3000/"
  has_many :comments
end