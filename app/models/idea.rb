class Idea < ActiveRecord::Base
  attr_accessible :description, :name, :picture,:user_id
  mount_uploader :picture, PictureUploader
  has_many :comments,:dependent=>:destroy
  belongs_to :user
  scope :published, lambda { where("created_at <= ?", Time.zone.now) }
  scope :get_all, order("created_at DESC")
end
