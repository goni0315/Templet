<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
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
</script>
</head>

<body style="background:url(./images/common/bg.gif)">
<form id="frm" action="" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td height="1" valign="bottom" style="background:url(./images/search/sub_menu_bg.gif)"><img src="./images/search/sub_menu_end.gif" alt="" width="297" height="11" /></td>
  </tr>
  <tr>
    <td height="30" valign="top" ><img src="./images/situation/list_title1.gif" alt="" width="297" height="33" /></td>
  </tr>
  <tr>
    <td  valign="top" height="432px;" style="background-image:url(./images/search/contents_bg.gif); ">
    <div class="bbsCont" style="margin:5px 0px 10px 10px; width:282px;">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" summary="목록" >
        <col class="w_40"/>
        <col />
        <col class="w_40"/>
        <thead>
          <tr>
            <th>No</th>
            <th>상황도</th>
            <th>이동</th>
            </tr>
          </thead>
          <tr><td colspan="3">상황도의 날짜를 검색해주세요</td></tr>
      </table>
      </div>
    </td>
  </tr>
  <tr>
    <td height="10"  valign="bottom"><img src="./images/search/contents_bottom.gif" alt="" width="297" height="10" /></td>
  </tr>
</table>
</form>
</body>
</html>
