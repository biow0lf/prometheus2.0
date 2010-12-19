$(document).ready(function() {
  $('#topMain').toggle(function() {
    $('#topMain').attr("src", "/images/restore.gif");
    $('#topMain').attr("title", "розгорнути вікно");
    $('#topMainDiv').hide();
  }, function() {
    $('#topMain').attr("src", "/images/collapse.gif");
    $('#topMain').attr("title", "згорнути вікно");
    $('#topMainDiv').show();
  });

  $("#topRPM").toggle(function() {
    $('#topRPM').attr("src", "/images/restore.gif");
    $('#topRPM').attr("title", "розгорнути вікно");
    $('#topRPMDiv').hide();
  }, function() {
    $('#topRPM').attr("src", "/images/collapse.gif");
    $('#topRPM').attr("title", "згорнути вікно");
    $('#topRPMDiv').show();
  });

  $("#topTips").toggle(function() {
    $('#topTips').attr("src", "/images/restore.gif");
    $('#topTips').attr("title", "розгорнути вікно");
    $('#topTipsDiv').hide();
  }, function() {
    $('#topTips').attr("src", "/images/collapse.gif");
    $('#topTips').attr("title", "згорнути вікно");
    $('#topTipsDiv').show();
  });

  $("#topBranches").toggle(function() {
    $('#topBranches').attr("src", "/images/restore.gif");
    $('#topBranches').attr("title", "розгорнути вікно");
    $('#topBranchesDiv').hide();
  }, function() {
    $('#topBranches').attr("src", "/images/collapse.gif");
    $('#topBranches').attr("title", "згорнути вікно");
    $('#topBranchesDiv').show();
  });
});
