module ApplicationHelper

  def product_columns
    [
    { :name => 'name',:display_name => 'Name',:editable => true,:type => :input,:sortable => true },
    { :name => 'description',:display_name => 'Description',:editable => true,:type => :input,:sortable => true },
    { :name => 'country', :display_name => 'Country',:type => :input,:editable => true,:sortable => true},
    { :name => 'price', :display_name => 'Price',:type => :input,:editable => true,:sortable => true}
    ]
  end

  def grid_widget(columns, collection = {}, search_cols = {}, options = {})
    txt_head = content_tag :thead do
    content_tag :tr do
    concat content_tag(:th)
    columns.collect { |column| concat search_cols[:searchable].include?(column[:name]) ? content_tag(:th,
      text_field_tag(column[:name], '', :class => 'search_link')) : content_tag(:th)
    }
    end	
    end 
    concat content_tag(:div, content_tag(:table, txt_head,:class => "tab-txt_box"), :class => "search_box")
    ajax_div = content_tag :div, :id => "ajax_div" do
      results(columns,collection)	
    end
    if options[:paginate]
      paginate = content_tag :div,:id=>"paginator" do
        paginate(collection, :remote => true)         
      end
      ajax_div.concat(paginate)
    else
      return ajax_div
    end
  end
 
  def results(columns,collection)	  
    thead = content_tag :thead do		
    chk_bx=content_tag(:th,check_box_tag('selectall',''))
    content_tag :tr do		
    concat chk_bx 
    columns.collect {|column| concat content_tag(:th,
      column[:sortable] ? (link_to(column[:display_name],"#",:data => {:name => column[:name], :direction => "desc"},
      :class =>"sort_link")) : column[:display_name])}.join().html_safe
    end
    end		
    tbody = content_tag :tbody do
      collection.collect { |elem|
      content_tag :tr do
      concat content_tag(:td,check_box_tag('case', elem.id, false, :class => 'case'))		
      columns.collect { |column|      
      concat content_tag(:td, column[:editable] ? check_best_in_place(elem,column[:name],:type=>column[:type],:collection => column[:data]) : elem.attributes[column[:name]] )
      }.to_s.html_safe
      end
      }.join().html_safe
    end			
    content_tag :table, thead.concat(tbody),:class => "table table-striped"	    
  end

  def check_best_in_place(elem,column_name,input = {},collection = nil)     
    case       
      when input[:type] == :input
        best_in_place(elem,column_name,input)      
      when input[:type] == :select
        best_in_place(elem,column_name,input)
      when input[:type] == :textarea

        best_in_place(elem,column_name,input)
      when input[:type] == :date
        
      else
        
      end
  end	
end
