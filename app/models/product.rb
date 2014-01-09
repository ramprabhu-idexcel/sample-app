class Product < ActiveRecord::Base
  attr_accessible :name, :price ,:country, :description
  #default_scope order('created_at DESC')
  
 def self.search(search)
    search_condition = "%" + search['search_data'] + "%"
    #find(:all, :conditions => ['name LIKE ? OR category LIKE ? OR price LIKE ? OR releasedate LIKE ?' , search_condition,search_condition,search_condition,search_condition])    
    where("#{search['search_column']} LIKE ?", "#{search_condition}")
 end

end
