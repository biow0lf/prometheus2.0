$(document).ready(function() {
  $('#topMain').toggle(function() {
    $('#topMain').attr("src", "/images/restore.gif");
    $('#topMain').attr("title", "show window");
    $('#topMainDiv').hide();
  }, function() {
    $('#topMain').attr("src", "/images/collapse.gif");
    $('#topMain').attr("title", "hide window");
    $('#topMainDiv').show();
  });

  $("#topRPM").toggle(function() {
    $('#topRPM').attr("src", "/images/restore.gif");
    $('#topRPM').attr("title", "show window");
    $('#topRPMDiv').hide();
  }, function() {
    $('#topRPM').attr("src", "/images/collapse.gif");
    $('#topRPM').attr("title", "hide window");
    $('#topRPMDiv').show();
  });

  $("#topTips").toggle(function() {
    $('#topTips').attr("src", "/images/restore.gif");
    $('#topTips').attr("title", "show window");
    $('#topTipsDiv').hide();
  }, function() {
    $('#topTips').attr("src", "/images/collapse.gif");
    $('#topTips').attr("title", "hide window");
    $('#topTipsDiv').show();
  });

  $("#topBranches").toggle(function() {
    $('#topBranches').attr("src", "/images/restore.gif");
    $('#topBranches').attr("title", "show window");
    $('#topBranchesDiv').hide();
  }, function() {
    $('#topBranches').attr("src", "/images/collapse.gif");
    $('#topBranches').attr("title", "hide window");
    $('#topBranchesDiv').show();
  });
});
