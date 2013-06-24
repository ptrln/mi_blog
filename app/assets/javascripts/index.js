$(function() {
  var latestPost = null;
  var refresh = function() {
    $(".refresh-btn").hide();
    $.get(
      "/p", 
      {last: latestPost}, 
      function(json){
        $("#posts-list").prepend(json.html);
        latestPost = json.last;
        $(".refresh-btn").show();
    });
  };

  var loadMore = function() {
    $(".more-btn").hide();
    $.get(
      "/p", 
      {offset: $("#posts-list blockquote").length}, 
      function(json){
        $("#posts-list").append(json.html);
        if (json.more) $(".more-btn").show();
    });
  };

  $(".refresh-btn").on('click', refresh);
  $(".more-btn").on('click', loadMore);
  refresh();
  setInterval(refresh, 30 * 1000);
});