$(document).ready(function() {
  $('#topMain').toggle(function() {
    $('#topMain').attr("src", "/images/restore.gif");
    $('#topMain').attr("title", "развернуть окно");
    $('#topMainDiv').hide();
  }, function() {
    $('#topMain').attr("src", "/images/collapse.gif");
    $('#topMain').attr("title", "свернуть окно");
    $('#topMainDiv').show();
  });

  $("#topRPM").toggle(function() {
    $('#topRPM').attr("src", "/images/restore.gif");
    $('#topRPM').attr("title", "развернуть окно");
    $('#topRPMDiv').hide();
  }, function() {
    $('#topRPM').attr("src", "/images/collapse.gif");
    $('#topRPM').attr("title", "свернуть окно");
    $('#topRPMDiv').show();
  });

  $("#topTips").toggle(function() {
    $('#topTips').attr("src", "/images/restore.gif");
    $('#topTips').attr("title", "развернуть окно");
    $('#topTipsDiv').hide();
  }, function() {
    $('#topTips').attr("src", "/images/collapse.gif");
    $('#topTips').attr("title", "свернуть окно");
    $('#topTipsDiv').show();
  });

  $("#topBranches").toggle(function() {
    $('#topBranches').attr("src", "/images/restore.gif");
    $('#topBranches').attr("title", "развернуть окно");
    $('#topBranchesDiv').hide();
  }, function() {
    $('#topBranches').attr("src", "/images/collapse.gif");
    $('#topBranches').attr("title", "свернуть окно");
    $('#topBranchesDiv').show();
  });
});
