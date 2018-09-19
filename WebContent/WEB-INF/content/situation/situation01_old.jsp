<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.mouse.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.slider.js"></script>
<script src="./js/jquery-ui-1.10.3/external/jquery.mousewheel.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.button.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.spinner.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.position.js"></script>
<script src="./js/jquery-ui-1.10.3/ui/jquery.ui.tooltip.js"></script>
<script src='./js/spectrum/spectrum.js'></script>
<link rel='stylesheet' href='./js/spectrum/spectrum.css' />
 <%
 	Date date = new Date();
    SimpleDateFormat fo = new SimpleDateFormat("yyyyMMddHHmmss");
    String now = fo.format(date); 
%>
<script type="text/javascript" language="javascript">


$(function() {
	$( "#lineAlpha" ).slider({
		orientation: "horizontal",
		range: "min",
		min: 0,
		max: 255,
		value: 200,
		slide: function( event, ui ) {
			$( "#lineamount" ).val( ui.value );
		}
	});
	$( "#lineamount" ).val( $( "#lineAlpha" ).slider( "value" ) );
});
$(function() {
	$( "#modificationAlpha" ).slider({
		orientation: "horizontal",
		range: "min",
		min: 0,
		max: 255,
		value: 200,
		slide: function( event, ui ) {
			$( "#modificationamount" ).val( ui.value );
		}
	});
	$( "#modificationamount" ).val( $( "#modificationAlpha" ).slider( "value" ) );
});
$(function() {
	$( "#objectAlpha" ).slider({
		orientation: "horizontal",
		range: "min",
		min: 0,
		max: 255,
		value: 200,
		slide: function( event, ui ) {
			$( "#objectamount" ).val( ui.value );
		}
	});
	$( "#objectamount" ).val( $( "#lineAlpha" ).slider( "value" ) );
});



$(function() {
	$( "#pointSpinner" ).spinner({
		spin: function( event, ui ) {
			if ( ui.value > 50 ) {
				$( this ).spinner( "value", 7 );
				return false;
			} else if ( ui.value < 7) {
				$( this ).spinner( "value", 50 );
				return false;
			}
		}
	});
	
});
$(function() {
	$( "#lineSpinner" ).spinner({
		spin: function( event, ui ) {
			if ( ui.value > 20 ) {
				$( this ).spinner( "value", 1 );
				return false;
			} else if ( ui.value < 1) {
				$( this ).spinner( "value", 20 );
				return false;
			}
		}
	});
	
});
$(function() {
	$( "#modificationSpinner" ).spinner({
		spin: function( event, ui ) {
			if ( ui.value > 20 ) {
				$( this ).spinner( "value", 1 );
				return false;
			} else if ( ui.value < 1) {
				$( this ).spinner( "value", 20 );
				return false;
			}
		}
	});
	
});


$(function() {
	$( document ).tooltip({
		track: true
	});
});


$(function() {
	$("#lineColor").spectrum({
	    color: "#f00",
	    change: function(color) {
	    	//alert(color.toHexString());
	        $("#linelog").val(color.toHexString());
	        displayColor();
	    }
	});
});
$(function() {
	$("#modificationColor").spectrum({
	    color: "#f00",
	    change: function(color) {
	    	//alert(color.toHexString());
	        $("#modificationlog").val(color.toHexString());
	        displayColor();
	    }
	});
});
$(function() {
	$("#textColor").spectrum({
	    color: "#f00",
	    change: function(color) {
	    	//alert(color.toHexString());
	        $("#textlog").val(color.toHexString());
	        displayColor();
	    }
	});
});
$(function() {
	$("#objcetColor").spectrum({
	    color: "#f00",
	    change: function(color) {
	    	//alert(color.toHexString());
	        $("#objectlog").val(color.toHexString());
	        displayColor();
	    }
	});
});



function objectControler(value){
	var size = $("input[name='lineWidth']").val()
	   
	switch (value) {
	case 'Rect': top.XDOCX.XDSetMouseState(101); dispalyMode(2); break;
	case 'Ellipes': top.XDOCX.XDSetMouseState(102); dispalyMode(2);  break;
	case 'Arrow': top.XDOCX.XDSetMouseState(103); dispalyMode(2);  break;
	case 'Arrowduel': top.XDOCX.XDSetMouseState(104); dispalyMode(2);  break;
	case 'Convex': top.XDOCX.XDSetMouseState(105); dispalyMode(2);  break;
	case 'Concave': top.XDOCX.XDSetMouseState(106); dispalyMode(2);  break;
	case 'RoundRect': top.XDOCX.XDSetMouseState(107); dispalyMode(2);  break;
	case 'BearingArc': top.XDOCX.XDSetMouseState(108); dispalyMode(2);  break;
	case 'Star': top.XDOCX.XDSetMouseState(109); dispalyMode(2);  break;
	case 'Plus': top.XDOCX.XDSetMouseState(110); dispalyMode(2);  break;
	case 'SelectMode': top.XDOCX.XDSetMouseState(6); break;
	case 'LineInputMode': dispalyMode(1); Line_Set();   break;
	case 'DragInputMode': top.XDOCX.XDRefSetLineWidth(size);  dispalyMode(1); top.XDOCX.XDSetMouseState(26); break;
	case 'AreaInputMode': inputPoint();  dispalyMode(3);  break;

	
	default:
		break;
	}
	
	displayColor();
    
}

function displayColor(){
    var color = setColor().split(",");
    top.XDOCX.XDRefSetColor(objectAlpha, color[0], color[1], color[2]);
}

var displayObject = "";
var objectAlpha = "";
function dispalyMode(value){
	displayObject = value;
	
	$('#saveObject').show();
	$('#textValue, #objectValue, #lineValue').hide();
	if(value == '1'){
		$('#lineValue').show();
	}else if(value == '2'){
		$('#objectValue').show();
	}else{
		$('#textValue').show();	
	}
}

function setColor(){
	var h ="";
	if(displayObject == '1'){
		h = $("input[name='linelog']").val();
		objectAlpha = $("input[name='lineamount']").val();
	}else if(displayObject == '2'){
		h = $("input[name='objectlog']").val();
		objectAlpha = $("input[name='objectamount']").val();
	}else{
		h = $("input[name='textlog']").val();
		objectAlpha = 255;
	}
	var r = parseInt((cutHex(h)).substring(0,2),16);
	var g = parseInt((cutHex(h)).substring(2,4),16);
	var b = parseInt((cutHex(h)).substring(4,6),16);
	return r+","+g+","+b;
}

function cutHex(h) {
	return (h.charAt(0)=="#") ? h.substring(1,7) : h
}

function Line_Set(){
	   var alpha = $("input[id='amount']").val();
	   var size = $("input[name='lineWidth']").val()
	   top.XDOCX.XDRefSetLineWidth(size);  
	   top.dbclickController();
	   top.XDOCX.XDSetMouseState(21);       

	}

function Plane_Set(mode){
	   var alpha = $("input[name='alpha']").val();		     
	   var size = $("input[name='lineSize']").val();
	   top.XDOCX.XDSetMouseState(21);
	   top.dbclickController();
}
var inputCnt = 0;
function inputPoint(){
	
	top.XDOCX.XDSetMouseState(40);
    var pointText = $("input[name='pointName']").val();	
    var pointSize = $("input[name='pointSize']").val();
    var pointfile = $("input[name='pointfile']").val();
    var objectId = "point"+inputCnt;
    var iStyle = 0;
	    
	var OR = 0;
	var OG = 0;
	var OB = 0;
    
    if($("input:checked[id='textbox']").is(":checked")==true){
    	iStyle = 3;
    }else{
    	iStyle = 0;
    }

	var color = setColor().split(",");	    
    //top.XDOCX.XDLaySetEditable("createPoint");

    if (iStyle == 2)
    {
        OR = 90; OG = 90; OB = 90;
    }
    //istyle => 0: nomal 1: 테두리 2: 박스 3 : 투명 배경색 4: 테두리+박스

    top.XDOCX.XDSetMouseState(40);
    top.XDOCX.XDRefSetFontStyle("gulim", pointSize, true, true, iStyle, 0, 0, 0);    
    top.textDbclick(objectId, pointText, pointfile);
    inputCnt++;
}


function exportFile(){
	var name = $("input[name='drawName']").val();
	var now = '<%=now%>';
	var XDLfile =  'C://xdcashe//'+name+"_"+now+"작성자.xdl";
	var XDifile =  'C://xdcashe//'+name+"_"+now+"작성자.xdi";
	//var filePath =  'C:/xdcashe/'+name+"_"+now+"작성자.xdl";
	var XDLfileName = name+"_"+now+"작성자.xdl";
	var XDIfileName = name+"_"+now+"작성자.xdi";
	var layerfileName =  name+"_"+now+"작성자.xdl";
	var frm = document.getElementById("frm");
	top.XDOCX.XDLaySaveFile("Present", XDLfile);
	var filepath = "//egis//";
	//var filepath = "/was/tomcat/webapps/Templet/";
	
	//- sURL		 : FTP 주소
	//- nPor		 : port번호
	//- sUsername 	: 사용자 이름
	//- sPassword	 : 패스워드
	//var connect =  top.XDOCX.XDFTPSetConnect('192.168.10.5', '21', 'egis', 'egis2345');
	var connect =  top.XDOCX.XDFTPSetConnect('59.25.182.206', '21', 'egis', 'egis0700');
	//top.XDOCX.XDFTPIsDirExist(filepath);
	if(connect == true){
		var sale = top.XDOCX.XDFTPPutFile(XDLfile,filepath+XDLfileName);
		var sale2 = top.XDOCX.XDFTPPutFile(XDifile,filepath+XDIfileName);
		if(sale == true && sale2 == true){		
			$("input[name='ObjectFileName']").val(XDLfileName);
			//alert($("input[name='ObjectFileName']").val());
			top.XDOCX.XDFTPSetDisconnect();
			frm.action = "${contextPath}/writeObject.do";
			frm.submit();
		}else{
			alert("파일저장이 완료되지 않았습니다.");
			top.XDOCX.XDFTPSetDisconnect();
		}
	}else{
		alert("FTP연결이 끊어졌습니다. 다시연결해주세요");
		top.XDOCX.XDFTPSetDisconnect();
	}

}

function onSoild(){
	top.XDOCX.XDFigureCreateLineBuffer( "solid", true, 0, 100);
    top.XDOCX.XDUIClearInputPoint();
    top.XDOCX.XDMapRender();	
	top.XDOCX.XDSetMouseState(1); 
}

function onOpenSolid(){
	top.XDOCX.XDFigureCreateLineBuffer( "opensolid", false, 0, 100);
    top.XDOCX.XDUIClearInputPoint();
    top.XDOCX.XDMapRender();	
	top.XDOCX.XDSetMouseState(1); 
}

function onLineBuffer(){
	var radius = top.XDOCX.XDCameraGetDistance()/100;
	top.XDOCX.XDFigureCreateLineBuffer( "linebuffer", false, radius, 100);
    top.XDOCX.XDUIClearInputPoint();
    top.XDOCX.XDMapRender();	
	top.XDOCX.XDSetMouseState(1); 
}

function onPolyBuffer(){
	var radius = top.XDOCX.XDCameraGetDistance()/100;
	top.XDOCX.XDFigureCreateLineBuffer( "polybuffer", true, radius, 100);
    top.XDOCX.XDUIClearInputPoint();
    top.XDOCX.XDMapRender();	
	top.XDOCX.XDSetMouseState(1); 
}

</script>
</head>

<body style="background:url(./images/common/bg.gif)">
<form id="frm" action="" method="post" enctype="multipart/form-data">
<input type="hidden" id="fileName" name="ObjectFileName" value="" />
<input type="hidden" id="writeName" name="writeName" value="작성자" />
<input type="hidden" id="modiName" name="modiName" value="작성자" />
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td width="296" height="4" valign="top"><img src="./images/situation/top_head.gif" alt="" width="297" height="59" /></td>
  </tr>
  <tr>
    <td height="1" valign="top"><table width="297" border="0" cellpadding="0" cellspacing="0" style="background:url(./images/search/sub_menu_bg.gif)">
      <tr>
        <td ><a href="${contextPath}/situationUp.do"><img src="./images/situation/sub_menu01_on.gif" alt="상황도저장" width="150" height="34" /></a></td>
        <td ><a href="${contextPath}/situationDown.do"><img src="./images/situation/sub_menu02_off.gif" alt="상황도불러오기" width="147" height="34" /></a></td>
      </tr>
      <tr>
        <td colspan="2"><table width="244" border="0" cellpadding="0" cellspacing="0" style="margin:5px 0 5px 20px">
          <tr>
            <td class="f_whit">상황도제목</td>
            <td><input type="text" name="name" id="name" value="" style="width:150px"/></td>
            </tr>
          </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" valign="bottom" style="background:url(./images/search/sub_menu_bg.gif)"><img src="./images/search/sub_menu_end.gif" alt="" width="297" height="11" /></td>
  </tr>
  <tr>
    <td height="30" valign="top" ><img src="./images/situation/list_title.gif" alt="" width="297" height="33" /></td>
  </tr>
  <tr>
    <td align="left"  valign="top" style="background-image:url(./images/search/contents_bg.gif);"><img src="./images/situation/sub_title1.gif" width="294" height="28"/></td>
  </tr>
  <tr>
    <td align="left"  valign="top" style="background-image:url(./images/search/contents_bg.gif);"><table width="258" border="0" cellpadding="0" cellspacing="0" style="margin:5px 0px 10px 20px;">
      <tr>
        <td width="49"><a href="#" style="cursor: pointer;" onclick="objectControler('Rect');"><img src="./images/situation/figure_01.gif" title="사각형"></img></a></td>
        <td width="50"><a href="#" style="cursor: pointer;" onclick="objectControler('Ellipes');"><img src="./images/situation/figure_02.gif" alt="원형"></img></a></td>
        <td width="51"><a href="#" style="cursor: pointer;" onclick="objectControler('Arrow');"><img src="./images/situation/figure_03.gif" alt=""></img></a></td>
        <td width="61"><a href="#" style="cursor: pointer;" onclick="objectControler('Arrowduel');"><img src="./images/situation/figure_04.gif" alt=""></img></a></td>
        <td width="47"><a href="#" style="cursor: pointer;" onclick="objectControler('RoundRect');"><img src="./images/situation/figure_05.gif" alt=""></img></a></td>
      </tr>
      <tr>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('BearingArc');"><img src="./images/situation/figure_06.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('Star');"><img src="./images/situation/figure_07.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('Plus');"><img src="./images/situation/figure_08.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('Convex');"><img src="./images/situation/figure_09.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('Concave');"><img src="./images/situation/figure_10.gif" alt=""></img></a></td>
      </tr>
      <tr>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('LineInputMode');"><img src="./images/situation/figure_12.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('DragInputMode');"><img src="./images/situation/figure_13.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectControler('AreaInputMode');"><img src="./images/situation/figure_14.gif" alt=""></img></a></td>
        <td><a href="#" style="cursor: pointer;" onclick="objectSelectMode();"><img src="./images/situation/figure_14.gif" alt=""></img></a></td>
        <td>&nbsp;</td>
      </tr>
    </table>
        <div id="lineValue" style="margin:5px 0px 10px 10px; width:280px; display:none;" >
          <table width="276" border="0" cellpadding="0" cellspacing="0" class="type1">
            <tr>
              <th width="71">라인색상 : </th>
              <td width="205"><input type='text' id="lineColor" name="lineColor"/><input type="text" id="linelog" name="linelog" value="#f70202" onchange="setColor();" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
            <tr>
              <th>투명도 :</th>
              <td><div id="lineAlpha" name="lineAlpha" style="width:200px;"></div>투명도수치:<input type="text" id="lineamount" name="lineamount" value="200" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
            
            <tr>
              <th>선굵기</th>
              <td><input id="lineSpinner" name="lineWidth" onchange="setWith();" value="5"/></td>
            </tr>
          </table>
          <table border="0" align="center">
            <tr>
              <td><div style="cursor: pointer"><img src="./images/situation/btn_01.gif" alt="라인버퍼" onclick="onSoild();"/></div></td>
              <td><div style="cursor: pointer"><img src="./images/situation/btn_02.gif" alt="폴리곤버퍼" onclick="onOpenSolid();"/></div></td>
            </tr>
            <tr>
              <td><div style="cursor: pointer"><img src="./images/situation/btn_03.gif" alt="솔리드" onclick="onLineBuffer();"/></div></td>
              <td><div style="cursor: pointer"><img src="./images/situation/btn_04.gif" alt="오픈솔리드" onclick="onPolyBuffer();"/></div></td>
            </tr>
          </table>          
        </div>
        
        <div id="objectValue" style="margin:5px 0px 10px 10px; width:280px; display:none;" >
          <table width="276" border="0" cellpadding="0" cellspacing="0" class="type1">
            <tr>
              <th width="71">객체색상 : </th>
              <td width="205"><input type='text' id="objcetColor" name="objcetColor"/><input type="text" id="objectlog" name="objectlog"  value="#f70202" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
            <tr>
              <th>투명도 :</th>
              <td><div id="objectAlpha" name="objectAlpha" style="width:200px;"></div>투명도수치:<input type="text" id="objectamount" name="objectamount" value="200" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
          </table>
        </div>

        <div id="textValue" style="margin:5px 0px 10px 10px; width:280px; display:none;" >
          <table width="276" border="0" cellpadding="0" cellspacing="0" class="type1">
            <tr>
              <th width="71">포인트 명 : </th>
              <td width="205"><input type="text" name="pointName" id="pointName" style="width:130px"/></td>
            </tr>
          	<tr>
              <th>글자크기</th>
              <td><input id="pointSpinner" name="pointWidth" value="30"/></td>
            </tr>            
            <tr>
              <th>글자색상 :</th>
              <td><input type='text' id="textColor" name="textColor"/><input type="text" id="textlog" name="textlog" value="#f70202" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
            <tr>
              <th>포인트이미지 :</th>
              <td><input type="file" id="pointfile" name="pointfile" value="128" style="width:130px; border:1px solid #999999;"></input></td>
            </tr>
          </table>
          <table border="0" align="center">
          <tr><td><input type="checkbox" id="textbox" name="textbox" />텍스트박스</td></td>
          </tr>
          </table>
          
        </div>                
        <div id="saveObject" style="margin:5px 0px 10px 10px; width:280px; display:none; cursor: pointer;"><img src="./images/situation/save.gif" width="83" height="24" align="right" onclick="exportFile();" /></div>
    </td>
  </tr>
  <tr>
    <td align="left"  valign="top" style="background-image:url(./images/search/contents_bg.gif);"><img src="./images/situation/sub_title1.gif" width="294" height="28"/></td>
  </tr>
 
  <tr>
         <td align="left"  valign="top" style="background-image:url(./images/search/contents_bg.gif);"><div  style="margin:5px 0px 10px 10px; width:280px; " >
          <table width="276" border="0" cellpadding="0" cellspacing="0" class="type1">
            <tr>
              <th width="71">라인색상 : </th>
              <td width="205"><input type='text' id="modificationColor" name="modificationColor"/><input type="text" id="modificationlog" name="modificationlog" value="#f70202" onchange="setColor();" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
            <tr>
              <th>투명도 :</th>
              <td><div id="modificationAlpha" name="modificationAlpha" style="width:200px;"></div>투명도수치:<input type="text" id="modificationamount" name="modificationamount" value="200" style="border:0; color:#f6931f; font-weight:bold; font-size:12px;" /></td>
            </tr>
            
            <tr>
              <th>선굵기</th>
              <td><input id="modificationSpinner" name="modificationWidth" value="5"/></td>
            </tr>
          </table>         
        </div></td>
        
  </tr>
</table>
</form>
</body>
</html>
