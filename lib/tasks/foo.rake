namespace :foo do
  desc "Import bar data"
  task(:bar => :environment) do
    import_data = []
    require 'csv' 

    csv_text = CSV.parse(File.read('/home/nramprabu/Desktop/ar_detail_052012.csv'))
    puts "csssssssssss"
    puts csv_text.inspect
    csv_text.slice!(0)
    csv_text.each do |row|
    csv_content = Receivable.new(:account_no=>row[0],:name=>row[1],
                      :invoice =>row[2],:invoice_date=>row[3],
                      :amount=>row[4])
  
    raise csv_content.errors.full_messages.join(", ") unless csv_content.valid?
    import_data << csv_content
    end
    Receivable.import(import_data,{:timestamp => false, :validate => false})     
  end
end