<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
 <%
 	Date date = new Date();
    SimpleDateFormat fo = new SimpleDateFormat("yyyyMMdd");
    String now = fo.format(date); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="./css/common.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="./js/jquery-ui-1.10.3/themes/base/jquery.ui.all.css" />
<script src="./js/jquery-ui-1.10.3/jquery-1.9.1.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.core.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.widget.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.datepicker.js"></script>

<script>
function loding(){
	top.lodingdis();
}
$(function() {
	$( "#datepicker" ).datepicker({
		showOn: "button",
		dateFormat: 'yymmdd', 
		buttonImage: "./images/common/calendar.gif",
		buttonImageOnly: true
	});
});
$(function() {
	$( "#datepicker2" ).datepicker({
		showOn: "button",
		dateFormat: 'yymmdd', 
		buttonImage: "./images/common/calendar.gif",
		buttonImageOnly: true
	});
});

function setValue(){
	$( "#datepicker" ).val();
	$( "#datepicker2" ).val();
	if($( "#datepicker" ).val() > $( "#datepicker2" ).val() && $( "#datepicker2" ).val() != ""){
		alert("검색 마지막 날짜가 시작날짜보다 빠를수 없습니다.");
		$( "#datepicker2" ).val('');
	}
}

function searchgo(){
	$( "#datepicker" ).val();
	$( "#datepicker2" ).val();
	if($( "#datepicker" ).val() == ""){
		alert("시작날짜를입력해주세요 ");
		return false;
	}
	if($( "#datepicker2" ).val() == ""){
		alert("종료날짜를입력해주세요 ");
		return false;
	}
	var frm = document.getElementById("frm");
	frm.action = "${contextPath}/objectList.do";
	frm.target = "objectList";
	frm.submit();
}

</script>
</head>

<body style="background:url(./images/common/bg.gif)">
<form id="frm" action="" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td width="296" height="4" valign="top"><img src="./images/situation/top_head.gif" alt="" width="297" height="59" /></td>
  </tr>
  <tr>
    <td height="1" valign="top"><table width="297" border="0" cellpadding="0" cellspacing="0" style="background:url(./images/search/sub_menu_bg.gif)">
      <tr>
        <td ><a href="${contextPath}/situationUp.do"><img src="./images/situation/sub_menu01_off.gif" alt="상황도저장" width="150" height="34" /></a></td>
        <td ><a href="${contextPath}/situationDown.do"><img src="./images/situation/sub_menu02_on.gif" alt="상황도불러오기" width="147" height="34" /></a></td>
      </tr>
      <tr>
        <td colspan="2"><table width="270" border="10" cellpadding="0" cellspacing="2" style="margin:5px 0 5px 20px">
          <tr>
            <td width="100" class="f_whit"><label>
              <input type="text" id="datepicker"  name="datepicker" value="<%=now %>" style="width:60px; cursor: pointer" onchange="setValue()"/>
            </label></td>
            
            <td width="35" class="f_whit">~</td>
            <td width="100"><input type="text" id="datepicker2" value="<%=now %>" name="datepicker2" style="width:60px; cursor: pointer" onchange="setValue()"/></td>
            
            <td width="45"><img src="./images/search/btn_search.gif" alt="검색" style="cursor: pointer" width="48" height="20" onclick="searchgo();" /></td>
            </tr>
          </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
	<td><iframe id="objectList" name="objectList" src="${contextPath}/blinksituation.do" frameborder="0" width="297" style="height:640px" scrolling="no" /></td>
  </tr>
  <tr>
    <td height="10"  valign="bottom"><img src="./images/search/contents_bottom.gif" alt="" width="297" height="10" /></td>
  </tr>
</table>
</form>
</body>
</html>
