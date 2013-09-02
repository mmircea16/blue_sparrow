console.log($(document).ready);
$(document).ready( function() {
    var books_covers = $(".cover");
    for (var i in books_covers){
        if ($(books_covers[i]).attr("data-isbn")!=undefined &&$(books_covers[i]).attr("data-isbn")!="")
            call_books_api_with_query_and_callback($(books_covers[i]).attr("data-isbn"),"load_cover")
    }
})

function load_cover(response){
    var item = response.items[0];

    $(".cover[data-isbn='"+get_isbn_13(item)+"']").attr("src", item.volumeInfo.imageLinks.smallThumbnail);
}