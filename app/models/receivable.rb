class Receivable < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :account_no,:name,:invoice,:original_date,:amount,:due_date
end
