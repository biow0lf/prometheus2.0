Event.observe(window, 'load', function() {
  Event.observe('topTips', 'click', function(){
    $('topTipsDiv').toggle();
    if($('topTipsDiv').visible()) {
      $('topTips').writeAttribute('src', '/images/collapse.gif')
    } else {
      $('topTips').writeAttribute('src', '/images/restore.gif')
    }
  });

  Event.observe('topRPM', 'click', function(){
    $('topRPMDiv').toggle();
    if($('topRPMDiv').visible()) {
      $('topRPM').writeAttribute('src', '/images/collapse.gif')
    } else {
      $('topRPM').writeAttribute('src', '/images/restore.gif')
    }
  });

  Event.observe('topMain', 'click', function(){
    $('topMainDiv').toggle();
    if($('topMainDiv').visible()) {
      $('topMain').writeAttribute('src', '/images/collapse.gif')
    } else {
      $('topMain').writeAttribute('src', '/images/restore.gif')
    }
  });

});

