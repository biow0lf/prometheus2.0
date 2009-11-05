Event.observe(window, 'load', function() {
  Event.observe('topTips', 'click', function(){
    $('topTipsDiv').toggle();
    if($('topTipsDiv').visible()) {
      $('topTips').writeAttribute('src', '/images/collapse.gif')
      $('topTips').writeAttribute('title', 'свернуть окно')
    } else {
      $('topTips').writeAttribute('src', '/images/restore.gif')
      $('topTips').writeAttribute('title', 'развернуть окно')
    }
  });

  Event.observe('topRPM', 'click', function(){
    $('topRPMDiv').toggle();
    if($('topRPMDiv').visible()) {
      $('topRPM').writeAttribute('src', '/images/collapse.gif')
      $('topRPM').writeAttribute('title', 'свернуть окно')
    } else {
      $('topRPM').writeAttribute('src', '/images/restore.gif')
      $('topRPM').writeAttribute('title', 'развернуть окно')
    }
  });

  Event.observe('topMain', 'click', function(){
    $('topMainDiv').toggle();
    if($('topMainDiv').visible()) {
      $('topMain').writeAttribute('src', '/images/collapse.gif')
      $('topMain').writeAttribute('title', 'свернуть окно')
    } else {
      $('topMain').writeAttribute('src', '/images/restore.gif')
      $('topMain').writeAttribute('title', 'развернуть окно')
    }
  });

});

