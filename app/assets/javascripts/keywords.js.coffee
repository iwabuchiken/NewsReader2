# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Refer => 黒田・佐藤: 317
#$(document).ready(function() {
$(document).ready ->
    
    msg = "YES";
    # url = "/keywords/ajax"
    url = "/keywords_ajax"
    # url = "/keywords/show/1"
    
    # Refer => http://www.yuyak.com/1438
    
    # $('#send').click(function() {
    $('#send_button').click ->
        # Ref => http://ja.wikipedia.org/wiki/CoffeeScript
        # $.get(url, ((txt) -> $("#ajax_test").text("info = #{txt}")), "text")
        
        # Ref => http://www.oiax.jp/rails/coffee_script/coffee04.html
        $.get(url, 
                ((txt) ->
                    block =  $("<b>" + "#{txt}" + "</b>")
                    # $("#ajax_test").append(block)))
                    $("#ajax_test").html(txt)))
                    # $("#ajax_test").html(txt))).show()
                    # $("#ajax_test").text(txt.class)))
                    # $("#ajax_test").append(txt)))
                    # $("#ajax_test").text("#{txt}" + " " + "xyz")), "text"
               # )
      
      
        # alert(url)
        # $.post(
              # url, msg
            # ).success(
              # # (c) =>
                # (c) ->
                  # alert(c)
            # ).fail( ->
                  # alert(msg)
            # )
      # alert("Send!");
      # alert(msg);
    # });#$('#send').click(function()
    
# });#$(document).ready(function()
