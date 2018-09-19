<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="./css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./js/jquery-1.7.1.js"></script>
</head>
<script>
	window.onload = function(){
		var ename = "";
		$.ajax({
			type:"POST",
			url:"${contextPath}/jibunSearch.do",
			data :"&ename="+ename ,
			dataType:"json",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     //통신 에러 발생시 처리
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : embList
		});
	
	}
	
	function embList(arr){
	$("#embNm").find("option").remove();
	$("#embNm").append("<option value=''>-----읍면동-----</option>");
	$.each(arr, function() {
		$("#embNm").append("<option value='"+this.emd_cd+"'>"+this.emd_nm+"</option>");
		});
	}
	
	function cctvSearchGo(){
		frm.action = 'cctvList.do';
		frm.target = 'searchList';
		frm.submit();
		
	}
	
	
</script>
<body style="background:url(./images/common/bg.gif)">
<form id="frm" action="" method="post">
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td width="296" height="4" valign="top"><img src="./images/search/top_head.gif" width="297" height="59" /></td>
  </tr>
  <tr>
    <td height="1" valign="top"><table width="297" border="0" cellpadding="0" cellspacing="0" style="background:url(./images/search/sub_menu_bg.gif)">
      <tr>
       <td ><a href="${contextPath}/searchJibun.do"><img src="./images/search/sub_menu01_off.gif" alt="" width="102" height="34" /></a></td>
        <td ><a href="${contextPath}/searchbuild.do"><img src="./images/search/sub_menu02_off.gif" alt="" width="96" height="34" /></a></td>
        <td ><a href="${contextPath}/searchCctv.do"><img src="./images/search/sub_menu03_on.gif" alt="" width="99" height="34" /></a></td>
      </tr>
      <tr>
        <td colspan="3"><table width="226" border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td class="f_whit">면 / 동</td>
            <td><label>
              <select name="embNm" id="embNm" style="width:150px;">
              <option value=''>-----읍면동-----</option>
              </select>
            </label></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="3"><img src="./images/search/sub_menu_side.gif" alt="" width="297" height="5" /></td>
      </tr>
      <tr>
        <td colspan="3" >
        <table width="253" border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td class="f_whit"><label>
              명칭 :</label></td>
            <td><label>
              <input type="text" name="addrName" id="addrName" style="width:150px"/>
            </label></td>
            <td><img src="./images/search/btn_search.gif" alt="" width="48" height="20" style="cursor: pointer;" onclick="cctvSearchGo();" /></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" valign="bottom" style="background:url(./images/search/sub_menu_bg.gif)"><img src="./images/search/sub_menu_end.gif" alt="" width="297" height="11" /></td>
  </tr>


</table>
<iframe id="searchList" name="searchList" src="${contextPath}/blinkList.do" frameborder="0" width="297" style="height:430px" scrolling="no" />
</form>
</body>
</html>
