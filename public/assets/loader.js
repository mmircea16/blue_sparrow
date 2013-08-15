/**
 * Created with JetBrains RubyMine.
 * User: mmoise
 * Date: 15/08/2013
 * Time: 00:10
 * To change this template use File | Settings | File Templates.
 */

function post_book(title, owner){
  xhr = $.post("/books",{title: title, owner: owner},function(){window.location.href = '/books.html'});
}

function transform_json_to_table(data){
//    data = jQuery.parseJSON(json);

    table_html_content = "";
    for (i=0;i<data.length;i++){
        table_html_content += "<tr><td>"+data[i].title+"</td><td>"+data[i].owner+"</td></tr>";

    }


    header = "<thead><td>Title</td><td>Owner</td></thead>";
    $('#books').html(header+table_html_content);


}


xhr = $.getJSON("/books","",function(data){transform_json_to_table(data.books);});
//transform_json_to_table(json);