<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="./css/common.css" rel="stylesheet" type="text/css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body style="background:url(./images/common/bg.gif)">
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td height="30" valign="top" ><img src="./images/search/list_title.gif" alt="" width="297" height="33" /></td>
  </tr>
  <tr>
    <td  valign="top" style="background-image:url(./images/search/contents_bg.gif)">
    <div class="bbsCont" style="margin:5px 0px 10px 10px; width:282px;">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" summary="목록" >
        <col class="w_40"/>
        <col />
        <col class="w_40"/>
        <thead>
          <tr>
            <th>No</th>
            <th>주소지</th>
            <th>이동</th>
            </tr>
          </thead>
         <c:if test="${not empty boardList}">
   		<c:forEach var="board" items="${boardList}"  varStatus="status">
		<tr>
          <td align="center" style="font-size:12px; line-height: 1.0em;">${status.count}</td>
          <td style="font-size:12px; line-height: 1.0em;">수원시 ${board.sgg_nm} ${board.emd_nm} ${board.jibun}<br />
              ${board.trnm_nm}
          </td>
          <td style="font-size:12px; line-height: 1.0em;"><img src="./images/common/btn_move.gif" width="41" height="15" onclick="parent.parent.searchXYGo(${board.point_x}, ${board.point_y})" style="cursor: pointer"></td>	
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty boardList}">
   		 <tr class=descBorder_c>
       	 <td colspan=5>검색된 게시물이 없습니다.</td>
         </tr>	
		</c:if>			
      </table>
    
      </div>

		<c:if test="${total_dataCount != 0}">
	     <tr align="center">
	        <td style="background-image:url(./images/search/contents_bg.gif)" align="center" height="30">${pageIndexList}</td>
	     </tr>
		</c:if> 
    </td>
  </tr>
	
  <tr>
    <td height="10"  valign="bottom"><img src="./images/search/contents_bottom.gif" width="297" height="10" /></td>
  </tr>
</table>
</body>
</html>