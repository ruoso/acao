jQuery.fn.select_autocomplete = function() {
  return this.each(function(){
		if (this.tagName.toLowerCase() != 'select') { return; }
	
    //stick each of it's options in to an items array of objects with name and value attributes 
    var select = this;
    var items = [];    
    $(select).children('option').each(function(){
      var item = $(this);
      if (item.val() != '') //ignore empty value options
      {
        var name = item.html();
        var value = item.val();
        items.push( {'name':name, 'value':value} );
      }
    });

    //make a new input box next to the select list
    var input = $("<input type='text' />").appendTo('body');
    $(select).after(input);

    //make the input box into an autocomplete for the select items
    $(input).autocomplete(items, {      
      data: items,  
      minChars: 0,
      width: 310,
      matchContains: false,
      autoFill: false,
      formatItem: function(row, i, max) {
        return row.name;
      },
      formatMatch: function(row, i, max) {
        return row.name;
      },
      formatResult: function(row) {
        return row.name;
      }
    });

    //make the result handler set the selected item in the select list
    $(input).result(function(event, selected_item, formatted) { 
      var to_be_selected = $(select).find("option[value=" + selected_item.value + "]")[0];
      $(to_be_selected).attr('selected', 'selected');
    });

    //set the initial text value of the autocomplete input box to the text node of the selected item in the select control
    $(input).val($(select).find(':selected').text());

    //normally, you'd hide the select list but we won't for this demo
    $(select).hide();
  });
};