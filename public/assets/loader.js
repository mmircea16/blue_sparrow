/**
 * Created with JetBrains RubyMine.
 * User: mmoise
 * Date: 15/08/2013
 * Time: 00:10
 * To change this template use File | Settings | File Templates.
 */

function post_book( title, owner){
  xhr = $.post("/books",{title: title, owner: owner},function(){console.log("fine");window.location.href = '/books.html'});
}
