
function handle_response(response) {
   console.log(response);
    $("#results_list").html("");
   for (var i = 0; i < response.items.length; i++) {
       var item = response.items[i];
       console.log(item);
//       alert("<tr><td> <img src='"+item.volumeInfo.imageLinks.smallThumbnail+"'/></td><td>"+item.volumeInfo.title+"</td></tr>");
       var tr = $("#results_list").append("<tr><td> <img src='"+item.volumeInfo.imageLinks.smallThumbnail+"'/></td><td>"+item.volumeInfo.title+"</td></tr>");

   }
}

function search_for_book (query) {
    query = query.replace(" ","+");
    $.ajax({
        url: "https://www.googleapis.com/books/v1/volumes?q="+query+"&callback=handle_response",
        dataType: "jsonp"
    });
}

$(document).ready(function() {
    $('#search_modal').on('shown', function() {
        search_for_book($("#title").val());
    })
});
