/* This is specific to product modules */
  $(document).ready(function() {
  	var count = 0;
	    /* Multiple record selction through checkbox */
    $("#selectall").click(function () {
    $('.case').attr('checked', this.checked);
    });
    $(".case").click(function(){
      if($(".case").length == $(".case:checked").length) {
        $("#selectall").attr("checked", "checked");
      } else {
        $("#selectall").removeAttr("checked");
      }
    });

    /* Searching functionality */
    $('.search_link').live("keyup", function(e) {  
      var sea_data = $(this).val();
      var sea_column = $(this).attr('name');
      $.ajax({  
        url: "/products/search",
        data: { search : { search_data : sea_data,
        search_column : sea_column }},  
        headers: {
          'X-CSRF-Token': '<%= form_authenticity_token.to_s %>'
         }
        }); 
    });

    /* Sorting functionality */ 
    $('.sort_link').live("click", function() {   
      var name = $(this).data('name');
      var direction =  $(this).data('direction'); 
        $.ajax({
          url : "/products/sorting",
          data : { sort : name,
          direction : direction },
          headers: {
            'X-CSRF-Token': '<%= form_authenticity_token.to_s %>'
          }
        }); 
    });

    /*Activating Best In Place */
    $(".best_in_place").best_in_place();  
    /*Delete selected elements */
    $("#delete_selected_items").click(function(){
      var sel_checkbox = [];   
      $(':checkbox:checked').each(function(i){   
      // val[i] = $(this).val();
      sel_checkbox.push($(this).val()); 
      }); 
    $("#delete_selected_items").data('value',sel_checkbox)

    $("#delete_selected_items").attr("href", function(i, href) {
      return href+'&ids='+sel_checkbox;
    });
    });

    /* Creating new record, Onclick new button */
    $("#new_product").live('click',function(){
      count = count + 1; 
      pro_name='pro_name_'+count;
      pro_description='pro_description_'+count;
      pro_country='pro_country_'+count;
      pro_price='pro_price_'+count;  
      $('table tbody').prepend("<tr><td><input type='checkbox' name='check_box'></td><td><input type='name' class='text_field' id="+pro_name+"></td><td><input type='description' class='text_field' id="+pro_description+"></td><td><input type='country' class='text_field' id="+pro_country+"></td><td><input type='price' class='text_field' id="+pro_price+"></td></tr>");
      return false;
    });

  /* Saving a record, Onclick save button */
    $('#prod_save').click(function(){
      var product = [];
      var prodObj = new Object();
      for ( var i = 1; i <= count ; i++ ) {
        prodObj.name=$('#pro_name_'+i).val();
        prodObj.description=$('#pro_description_'+i).val();
        prodObj.country=$('#pro_country_'+i).val();
        prodObj.price=$('#pro_price_'+i).val();
        var myString = JSON.stringify(prodObj);
        product.push(myString);  
       }  
      count = 0; 
      $.ajax({
        url : "/products",
        type: 'post',
        data : { product : product },
        headers: {
          'X-CSRF-Token': '<%= form_authenticity_token.to_s %>'
        }   
      }); 
     return false;
    });
});