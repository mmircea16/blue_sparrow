var table_row_partial = "<tr>" +
    "<td> <img class='cover' src=''/></td>" +
    "<td>" +
    " <div class='title'></div>" +
    " <div class='authors'></div>" +
    " </td>" +
    "</tr>";


function handle_response(response) {
   console.log(response);
    $("#results_list").html("");
   for (var i = 0; i < response.items.length; i++) {
       var item = response.items[i];
       console.log(item);
//       alert("<tr><td> <img src='"+item.volumeInfo.imageLinks.smallThumbnail+"'/></td><td>"+item.volumeInfo.title+"</td></tr>");
       var tr = $(table_row_partial);// $("<tr><td> <img src='"+item.volumeInfo.imageLinks.smallThumbnail+"'/></td><td>"+item.volumeInfo.title+"</td></tr>");
       tr.find(".cover").attr('src',item.volumeInfo.imageLinks.smallThumbnail);
       tr.find(".title").text(item.volumeInfo.title);
       tr.find(".authors").text(get_authors(item));
       $("#results_list").append(tr);
       tr.data("item",item);
   }
    $("#results_list tr").click(function (e) {$("#results_list tr").removeClass("success");$(e.currentTarget).addClass("success")});
    $("#results_list tr").css("cursor","pointer");
}

function search_for_book (query) {
    query = query.replace(" ","+");
    call_books_api_with_query_and_callback(query,"handle_response");
}



function call_books_api_with_query_and_callback(query, callback) {
    $.ajax({
        url: "https://www.googleapis.com/books/v1/volumes?q="+query+"&callback="+callback,
        dataType: "jsonp"
    });
}


function get_authors(data) {
     if (data.volumeInfo.authors != undefined)
      return data.volumeInfo.authors.join(", ");
     else "";
}

function get_isbn_13(data) {
    for (var i in data.volumeInfo.industryIdentifiers) {
        if (data.volumeInfo.industryIdentifiers[i].type == "ISBN_13") return data.volumeInfo.industryIdentifiers[i].identifier;
    }
    return "";
}

function select_book(){
    var selected_element = $("#results_list tr.success");
    var data = selected_element.data("item");
    var selected_title = data.volumeInfo.title;
    var isbn_13 = get_isbn_13(data);

    $("#title").val(selected_title);
    $("#isbn").val(isbn_13);
    console.log("select book");
}

$(document).ready(function() {
    $('#search_modal').on('shown', function() {
        search_for_book($("#title").val());
    })

});
