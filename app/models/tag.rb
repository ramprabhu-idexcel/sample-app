class Tag < ActiveRecord::Base
  belongs_to :post
  attr_accessible :name, :post_id
end
