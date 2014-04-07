class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :user_id,:published_at
  validates :name,  :presence => true
  validates :user_id,  :presence => true
  validates :title, :presence => true,:length => { :minimum => 5 }
  has_many :comments, :dependent => :destroy
  belongs_to :user

  #Solr search engine

  searchable do
  	text :name,:title
  	integer :user_id 
  	time :published_at
    time :created_at	
    text :comments do
      comments.map { |comment| comment.body }
    end
    integer :user_id
  end	
end
