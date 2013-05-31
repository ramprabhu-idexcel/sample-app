class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :user_id, :comments_count, :tags_attributes
  validates :name,  :presence => true
  validates :title, :presence => true,:length => { :minimum => 5 },:uniqueness => true 
  has_many :comments, :dependent => :destroy
  has_many :tags
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }  
  belongs_to :user
  scope :recent, limit(10).order('posts.created_at DESC')
  scope :uncommented, where(:comments_count => 0)
  default_scope includes(:comments).order('created_at ASC')  
end
