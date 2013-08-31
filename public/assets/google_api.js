
function handle_response(response) {
   console.log(response);
    $("#results_list").html("");
   for (var i = 0; i < response.items.length; i++) {
       var item = response.items[i];
       console.log(item);
//       alert("<tr><td> <img src='"+item.volumeInfo.imageLinks.smallThumbnail+"'/></td><td>"+item.volumeInfo.title+"</td></tr>");
       var tr = $("#results_list").append("<tr><td> <img src='"+item.volumeInfo.imageLinks.smallThumbnail+"'/></td><td>"+item.volumeInfo.title+"</td></tr>");

   }
    $("#results_list tr").click(function (e) {$("#results_list tr").removeClass("success");$(e.currentTarget).addClass("success")});
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
    $('#search_modal').on('hide', function() {
        var selected_title = $("#results_list tr.success:nth-child(1)").text();
        $("#title").val(selected_title);
    })
});
