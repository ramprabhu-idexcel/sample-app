class Book < ActiveRecord::Base
  attr_accessible :name
  acts_as_list
end
