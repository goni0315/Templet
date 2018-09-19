<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" info="2012. 3. 9. aaa EL의사용" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"
isELIgnored="false"%>
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
<script src='./js/mapConnect/mapConnect.js'></script>

<script>
var connect =  top.XDOCX.XDFTPSetConnect(ftpURL, ftpPORT, ftpUSER, ftpPWD);
var cnt = 0;
function showLayerListPu(lyr_name){
	var layerList = parent.parent.getLayerListPu();
	var layerListPos = layerList.split(",");
	for(var i =1; i<layerListPos.length; i++){
		var pos = layerListPos[i].split("#");
		if(pos[1] == lyr_name){	
			cnt++;
		}		
	}
	return cnt;
}

function MapControl(mode) {
	if (mode == "cam_total"){		// 전체보기
		top.XDOCX.XDCamSetDirect(0);	// 북쪽보기
		var ln = "";
		for (var i = 0; i < top.XDOCX.XDLayGetCount(); i++){
			ln = top.XDOCX.XDLayGetName(i);
			if (top.XDOCX.XDLayGetType(ln) == 8){
				var tmpRect = top.XDOCX.XDLayGetBox(ln); 
				if (tmpRect != ""){
					tmpRect = tmpRect.split(",");
					var cx = (parseInt(tmpRect[0])+parseInt(tmpRect[3])) / 2;
					var cz = (parseInt(tmpRect[2])+parseInt(tmpRect[5])) / 2;					
					top.XDOCX.XDCamLookAt(cx, 25000, cz - 10000, cx, 0, cz);
				}
				break;	
			}				
		}
	}
}

function mapInsert(val, name){
	
	var vals = val.split(".");
	var cont =  showLayerListPu(vals[0]);
	if(cont == 1){
		cnt = 0;
		alert("동일한 이름의 레이어가 존재합니다.");
		return false;
	}
	//var filePath = "/was/drowfile/";
	var filePath = "//egisSW//";
	var xdlfilepath = filePath+val;
	var xdifilepath = filePath+vals[0]+".xdi";
	//alert(top.XDOCX.XDFTPGetFile("C:\\xdcashe\\"+val, filepath));
	//alert(top.XDOCX.XDFTPGetFile("C:\\xdcashe\\undefined_20130710111206작성자.xdl", "//egis//undefined_20130710111206작성자.xdl"));
	//alert(top.XDOCX.XDUIFileExist("C:\\xdcashe\\"+val));
	if(connect == true){
		
		if(top.XDOCX.XDUIFileExist("C:\\xdcashe\\"+val) == false){
			
			parent.loding();
			var a = top.XDOCX.XDFTPGetFile("C:\\xdcashe\\"+vals[0]+".xdi", xdifilepath);
			if(top.XDOCX.XDFTPGetFile("C:\\xdcashe\\"+val, xdlfilepath) == true){
				
				//setTimeout(function(){top.XDOCX.XDFTPSetDisconnect()}, 7000);
				setTimeout(function(){top.XDOCX.XDFTPSetDisconnect();}, 20000);
				setTimeout(function(){top.XDOCX.XDReadLayerFile("C:\\xdcashe\\"+val); parent.parent.setLayerListPu(name+'#'+val); parent.parent.setLayerListExt(name+'#'+vals[0]);}, 10000);
				parent.loding();
				//top.XDOCX.XDFTPSetDisconnect();
				//top.XDOCX.XDReadLayerFile("C:\\xdcashe\\"+val);
			}else{
				parent.loding();
				alert("파일을 찾을 수 없습니다.");
				top.XDOCX.XDFTPSetDisconnect();
			}
		}else{
			//alert(2);
			top.XDOCX.XDReadLayerFile("C:\\xdcashe\\"+val);
			 parent.parent.setLayerListPu(name+'#'+vals[0]);
			 parent.parent.setLayerListExt(name+'#'+vals[0]);
			
		}

	}else{
		alert("FTP연결이 끊어졌습니다. 다시 연결해주세요.");
		top.XDOCX.XDFTPSetDisconnect();
	}

}

</script>
</head>

<body style="background:url(./images/common/bg.gif)">
<form id="frm" action="" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">

  <tr>
    <td height="30" valign="top" ><img src="./images/situation/list_title1.gif" alt="" width="297" height="33" /></td>
  </tr>
  <tr>
    <td  valign="top"  style="background-image:url(./images/search/contents_bg.gif)">
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
          <c:if test="${not empty boardList}">
    	<c:forEach var="board" items="${boardList}"  varStatus="status">
		<tr>
          <td align="center">${status.count}</td>
          <td><p>${board.name}</p></td>
          <td><img src="./images/btn_move.gif" width="41" style="cursor: pointer" height="15" onclick="mapInsert('<c:out value="${board.objectFileName}" />','<c:out value="${board.name}" />');MapControl('cam_total')" /></td>
          </tr>
		</c:forEach> 
		</c:if>        <c:out value="" />
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
    <td height="10"  valign="bottom"><img src="./images/search/contents_bottom.gif" alt="" width="297" height="10" /></td>
  </tr>
</table>
</form>
</body>
</html>
