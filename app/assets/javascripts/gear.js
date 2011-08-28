$(document).ready(function() {
  $('.gear').tablesorter();
});

// $('#sort_by_name').click(function() {
//    if ($("#by_name").attr("src") == "<%= asset_path 'stock_navigate-prev.png' %>") {
//      $('#by_name').attr("src", "<%= asset_path 'stock_navigate-next.png' %>");
//    } else {
//      $('#by_name').attr("src", "<%= asset_path 'stock_navigate-prev.png' %>");
//    }
//    var sorting = [[0,0]];
//    $(".gear").trigger("sorton", [sorting]);
//    return false;
// });
