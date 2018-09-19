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
<script type="text/javascript" language="javascript">
	function classnowSearch(ename){//나라 검색
		$.ajax({
			type:"POST",
			url:"${contextPath}/classSearch.do",
			data :"&ename="+ename ,
			dataType:"json",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     //통신 에러 발생시 처리
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : classList
		});
		
	}
	function classList(arr){
		$("#classnow").find("option").remove();
		$("#classnow").append("<option value=''>-----소분류-----</option>");
		$.each(arr, function() {
			$("#classnow").append("<option value='"+this.kind_m+"'>"+this.kind_m+"</option>");
			});
	}
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
	
	function buildSearchGo(){
		var frm = document.getElementById("frm");
		var classnew = $("#classnew option:selected").val();
		var classnow = $("#classnow option:selected").val();
		var embNm = $("#embNm option:selected").val();
		var buildSearch = $("input[name='buildSearch']").val();
		//alert(classnew+","+classnow+","+embNm+","+buildSearch);
		
		
		
		if(classnew == "" && classnow == "" && embNm == "" && buildSearch == ""){
			alert("검색데이터량이 너무 많습니다. 최소한가시지의 검색조건을 선택해주세요");
			return false;
		}
		
		frm.action = 'buildList.do';
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
        <td ><a href="${contextPath}/searchbuild.do"><img src="./images/search/sub_menu02_on.gif" alt="" width="96" height="34" /></a></td>
        <td ><a href="${contextPath}/searchCctv.do"><img src="./images/search/sub_menu03_off.gif" alt="" width="99" height="34" /></a></td>
      </tr>
      <tr>
        <td colspan="3"><table border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td class="f_whit">대분류 :</td>
            <td><label>
              <select name="classnew" id="classnew" onchange="classnowSearch(this.value)" style="width:150px;">
				<option value="">-----대분류-----</option>
				<option value="POI_PUBLIC">공공시설</option>
				<option value="POI_EDUCATION">교육시설</option>
				<option value="POI_TRAFFIC">교통시설</option>
				<option value="POI_ETC">기타시설</option>
				<option value="POI_CULTURESPORTS">문화및체육시설</option>
				<option value="POI_INDUSTRY">산업시설</option>
				<option value="POI_SERVICE">서비스시설</option>
				<option value="POI_MEDICALWELFARE">의료및복지시설</option>
				<option value="POI_RELIGION">종교시설</option>
				<option value="POI_HOUSING">주거시설</option>
              </select>
            </label></td>
          </tr>
          <tr>
            <td class="f_whit">소분류 :</td>
            <td><select name="classnow" id="classnow" style="width:150px;">
            	<option value="">-----소분류-----</option>
            </select></td>
          </tr>
          <tr>
            <td class="f_whit">면 / 동 :</td>
            <td><select name="embNm" id="embNm" style="width:150px;">
            	<option value="">-----읍면동-----</option>
            </select></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="3"><img src="./images/search/sub_menu_side.gif" alt="" width="297" height="5" /></td>
      </tr>
      <tr>
        <td colspan="3" >
        <table width="246" border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td width="32" class="f_whit"><label>
              명칭</label></td>
            <td width="161"><label>
              <input type="text" value="" name="buildSearch" id="buildSearch" style="width:150px"/>
            </label></td>
            <td width="53"><img src="./images/search/btn_search.gif" alt="" width="48" height="20" style="cursor:pointer"  onclick="buildSearchGo();" /></td>
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
