# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Refer => 黒田・佐藤: 317
$(document).ready ->
    
    # REF => http://api.jquery.com/selected-selector/
    
    # Get genre name and id --------------------------------
    # $('#send_genre').click ->
    $('select#keyword_genre_id').change ->
        msg = $('select#keyword_genre_id option:selected').text()
        value = $('select#keyword_genre_id option:selected').attr('value')
        
        alert(msg + "/" + value)
        # $('select#keyword_genre_id option:selected').each ->  
        # alert($(this).text())
    
    
    # --------------------------------
    $('#alert_test').click ->
        alert("Alert test")

    url = "/keywords_ajax"


    # --------------------------------
    # Refer => http://www.yuyak.com/1438
    $('#send_button').click ->
        # # Ref => http://ja.wikipedia.org/wiki/CoffeeScript
        # # Ref => http://www.oiax.jp/rails/coffee_script/coffee04.html
        $.get(url, 
                ((txt) ->
                    block =  $("<b>" + "#{txt}" + "</b>")
                    $("#ajax_test").html(txt)))

        # # $.post(
              # # url, msg
            # # ).success(
              # # # (c) =>
                # # (c) ->
                  # # alert(c)
            # # ).fail( ->
                  # # alert(msg)
            # # )
      # # alert("Send!");
      # # alert(msg);
