
function handle_response(response) {
   console.log(response);
}

function search_for_book (query) {
    query = query.replace(" ","+");
    $.ajax({
        url: "https://www.googleapis.com/books/v1/volumes?q="+query+"&callback=handle_response",
        dataType: "jsonp"
    });
}
