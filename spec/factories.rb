Factory.define :user do |u| 
      u.first_name   "Test"
      u.last_name  "User"
      u.phoneno "9866666"
      u.age "25"      
      u.email      "TestUser@gmail.com"
      u.password   "aoeuaoeu"
      u.password_confirmation   "aoeuaoeu"
      #u.password_confirmation {|u| u.password}
end

Factory.define :post do |u| 
      u.name   "Test post"
      u.title  "Idexcel tech"
      u.content "product based organization"
end

Factory.define :comment do |u| 
      u.commenter   "ramprabhu"
      u.body  "Looking good"      
end

Factory.define :idea do |u| 
      u.name   "cucumber vs rspec"
      u.description  "comes under the BDD & TDD"      
end

