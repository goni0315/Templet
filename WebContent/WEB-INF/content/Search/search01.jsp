<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="./css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="./js/jsUtil.js"></script>
</head>
<script type="text/javascript" language="javascript">
	function embSearch(ename){//나라 검색
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
		$("#embNm").append("<option value='0'>-----읍면동-----</option>");
		$.each(arr, function() {
			$("#embNm").append("<option value='"+this.emd_cd+"'>"+this.emd_nm+"</option>");
			});
	}
	
	// 검색 조건 추가 20130703 dialog 추가
	function jibunSearch(){
		var frm = document.getElementById("frm");
		var SggNm = $("#SggNm option:selected").val();
		var embNm = $("#embNm option:selected").val();
		var bonbun = $("input[name='bonbun']").val();
		var bubun = $("input[name='bubun']").val();
		var sanChk = $("#sanChk").is(":checked") ? '000' : '001';
		var pnuCode = embNm + sanChk + punChange(bonbun) + punChange(bubun);
		if(SggNm == 0){
			alert("검색되는 데이터량이 많습니다. 시/군/구를 선택해주세요");
			return false;
		}
		if(embNm == 0){
			alert("검색되는 데이터량이 많습니다. 읍/면/동를 선택해주세요");
			return false;
		}		
		$("input[name='pnuCode']").val(pnuCode);
		frm.action = 'jibunList.do';
		frm.target = 'searchList';
		frm.submit();	
	}
	function fnc_input_number(){
		   var e = event.keyCode;
		   window.status = e;
		   if (e>=48 && e<=57) return;
		   if (e>=96 && e<=105) return;
		   if (e>=37 && e<=40) return;
		   if (e==8 || e==9 || e==13 || e==46) return;
		   event.returnValue = false;
	} 
	
</script>
<body style="background:url(./images/common/bg.gif)">
<form id="frm" action="" method="post">
<input type="hidden" id="pnuCode" name="pnuCode" value="" />
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td width="296" height="4" valign="top"><img src="./images/search/top_head.gif" width="297" height="59" /></td>
  </tr>
  <tr>
    <td height="1" valign="top"><table width="297" border="0" cellpadding="0" cellspacing="0" style="background:url(./images/search/sub_menu_bg.gif)">
      <tr>
        <td ><a href="${contextPath}/searchJibun.do"><img src="./images/search/sub_menu01_on.gif" alt="" width="102" height="34" /></a></td>
        <td ><a href="${contextPath}/searchbuild.do"><img src="./images/search/sub_menu02_off.gif" alt="" width="96" height="34" /></a></td>
        <td ><a href="${contextPath}/searchCctv.do"><img src="./images/search/sub_menu03_off.gif" alt="" width="99" height="34" /></a></td>
      </tr>
      <tr>
        <td colspan="3"><table border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td class="f_whit">시/군 :</td>
            <td>
            
			<select id="SggNm" onchange="embSearch(this.value)" style="width:150px;">
				<option value="0">-----시군구-----</option>
				<option value="41117">영통구</option>
				<option value="41113">권선구</option>
				<option value="41111">장안구</option>
				<option value="41115">팔달구</option>
			</select>
            </td>
          </tr>
          <tr>
            <td class="f_whit">읍/면/동 :</td>
            <td><select id="embNm" style="width:150px;">
			<option value="0">-----읍면동-----</option>
			</select></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="3"><img src="./images/search/sub_menu_side.gif" alt="" width="297" height="5" /></td>
      </tr>
      <tr>
        <td colspan="3" >
        <table width="209" border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td width="46" class="f_whit"><label>
              <input type="checkbox" name="sanChk" id="sanChk" />
            </label>
              산</td>
            <td width="96"><label>
              <input type="text" name="bonbun" id="bonbun" style="width:30px" onkeydown="fnc_input_number()"  maxlength="4"/>
              -
              <input type="text" name="bubun" id="bubun" style="width:30px" onkeydown="fnc_input_number()"  maxlength="4"/>
            </label></td>
            <td width="67"><img src="./images/search/btn_search.gif" alt="" width="48" height="20" onclick="jibunSearch();" style="cursor: pointer"/></td>
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
