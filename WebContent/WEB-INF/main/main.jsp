<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>활용시스템</title>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="./css/common.css" rel="stylesheet" type="text/css"/>
<script src="./js/jquery.js" type="text/javascript"></script>
<script src="./js/jquery-ui-1.10.3/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./js/json2.js"></script>
<script type="text/javascript" src="./js/xdk.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript" src="./js/XDControl.js"></script>

<style type="text/css">
<!--
#left_base {
	position:absolute;
	width:100%;
	height:100%;
	z-index:1;
	left:0px;
}
#tool_bar {
	position:absolute;
	width:220px;
	height:105px;
	right: 0;
	bottom:0;
	z-index:9;
}

#tool_barClose {
	position:absolute;
	width:40px;
	height:105px;
	right:0;
	bottom:0;
	z-index:7;
}
#Load{
	position:absolute;
	bottom:340px;
	right:420px;
	background-color:#ffffff;
	z-index:11;
}
-->
</style>

<script type="text/javascript" language="javascript">
$(window).bind("resize", jsWResize);

var tmp_size_height = document.documentElement.clientHeight;//size.height;
var tmp_left_height = document.documentElement.clientHeight;//size.height;
var tmp_size_width = document.documentElement.clientWidth;//size.width;
var winWidthNum = 327;
var libWidthNum = tmp_size_width/100*80;

window.onload = function(){

	setLayerInfo(${ list_layer });
// 	setTest(${ test });
	setSecondLevel(${ second_level });
	$("#maparea").width(tmp_size_width-winWidthNum);
	$("#maparea").width(tmp_size_width-winWidthNum);
	
	xdServerConnect('58.138.253.23', 9830, '', 0, 0);//테스트 서버 
	//xdServerConnect('192.168.10.8', 9830, 'SWDEFFECE', 0, 0);//실서버
	//xdServerConnect('127.0.0.1', 9830, '', 0, 0);//실서버
	//jsonCallBack();
	directxPopup();
	$("#maparea").width(tmp_size_width-winWidthNum);
	//alert(libWidthNum);
	
	top.XDOCX.XDLayCreateEX( 14, "Present", 0, 10000000090); //14
	top.XDOCX.XDLaySetEditable ("Present");
	top.XDOCX.XDSetCurrentColor(100, 255, 0, 0);
	
	top.XDOCX.XDSetTextInfo("X", "", tmp_size_width-500, tmp_size_height-490, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("Y", "", tmp_size_width-500, tmp_size_height-475, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("Z", "", tmp_size_width-500, tmp_size_height-460, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("LON", "", tmp_size_width-500, tmp_size_height-445, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("LAT", "", tmp_size_width-500, tmp_size_height-430, 15, 1, 0, 255, 166, 166, 166);
	//- 보이게 될 텍스트를 설정한다.
	//- strKey	: 텍스트를 관리 할 수 있는 키 값
	//- strText	: 보이게 될 텍스트 내용
	//- nPositionX	: 텍스트의 X 좌표
	//- nPositionY	: 텍스트의 Y 좌표
	//- nTextSize	: 텍스트 크기
	//- clrInColorR	: 텍스트의 Red 색생값 0~255
	//- clrInColorG	: 텍스트의 Green 색생값 0~255
	//- clrInColorB	: 텍스트의 Blue 색생값 0~255
	//- clrOutColorR	: 텍스트 테두리의 Red 색생값 0~255
	//- clrOutColorG	: 텍스트 테두리의 Green 색생값 0~255
	//- clrOutColorB	: 텍스트 테두리의 Blue 색생값 0~255	
	
	
}

function jsWResize(){
	
	tmp_size_width = document.documentElement.clientWidth;
	libWidthNum = tmp_size_width/100*80;
	top.XDOCX.XDRemoveAllTextInfo();
	$("#maparea").width(tmp_size_width-winWidthNum);
	top.XDOCX.XDSetTextInfo("X", "", tmp_size_width-500, tmp_size_height-490, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("Y", "", tmp_size_width-500, tmp_size_height-475, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("Z", "", tmp_size_width-500, tmp_size_height-460, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("LON", "", tmp_size_width-500, tmp_size_height-445, 15, 1, 0, 255, 166, 166, 166);
	top.XDOCX.XDSetTextInfo("LAT", "", tmp_size_width-500, tmp_size_height-430, 15, 1, 0, 255, 166, 166, 166);
	
}

function dbclickController(){
	   //alert(1);
	   $('#maparea').dblclick(function() {
	        top.XDOCX.XDMapRender();
	        top.XDOCX.XDUIClearInputPoint();
	        top.XDOCX.XDSetMouseState(1);
	        $('#maparea').unbind('dblclick');
	   });
}



function dbClickCancel(){
	$('#maparea').unbind('dblclick');
}

function textDbclick(objectId, pointText, pointfile){
	   $('#maparea').dblclick(function() {
		   
		   var xdpos = XDOCX.XDUIClickPos();
		   pos = xdpos.split(",");
	       top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
	       
	       XDOCX.XDObjCreateText(objectId, pointText, pointfile);
	        //텍스트 보기여부 ocx4.0에서 작동안함
	       top.XDOCX.XDUIClearInputPoint();
	       top.XDOCX.XDMapRender();		        
           top.XDOCX.XDSetMouseState(1);             
           // 이벤트 삭제
           $('#maparea').unbind('dblclick');
           
	   });
}



function getHeight(){
		top.setWorkMode('cal_hei');	
		top.XDOCX.XDUISetWorkMode(20);
		top.XDOCX.XDUIClearInputPoint();

}

function getVolume(){
		top.setWorkMode('cal_volume');	//setSimulMode(12);
		top.XDOCX.XDUISetWorkMode(6);		
		top.XDOCX.XDSelClear();
}

function mapClear(){
	top.XDOCX.XDMapClearTempLayer();
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDAnsClear();
	top.XDOCX.XDSelClear();
	top.XDOCX.XDLayClear('Present');
	top.XDOCX.XDUIDistanceClear();
	top.XDOCX.XDUIAreaClear();
	top.XDOCX.XDUIClearMemo();
	top.XDOCX.XDMapResetRTT();
	top.XDOCX.XDLayCreateEX( 14, "Present", 0, 10000000090); //14
	top.XDOCX.XDLaySetEditable ("Present");
	top.XDOCX.XDSetCurrentColor(100, 255, 0, 0);
}


function lodingdis(){
	if($('#Load').css("display") == 'none'){
		$('#Load').show();
	}else{
		setTimeout(function(){$('#Load').hide();}, 10000);
		
	}
	
}

function toolbarClose(){
	var size = $('#tool_bar').css("right");
	if(size == "0px"){
		$('#tool_bar').css("right", "-190px");
	}else{
		$('#tool_bar').css("right", "0px");
	}
	
}

function leftClose(){
	var size = $('#left_base').css("left");
	if(size == "0px"){
		$('#maparea').css("left", "29px");
		//$("#maparea").width(tmp_size_width-150);
		$('#maparea').css("width", "98%");
		$('#left_base').css("left", "-296px");

	}else{
		$('#maparea').css("left", "326px");
		$('#maparea').css("width", "76%");
		$('#left_base').css("left", "0px");
	}
	
}

function leftbarHide() {
	var left = document.getElementById("tool_bar");
	//var leftView = document.getElementById("leftView");
	
	if(parseInt(left.style.right) == 1) {
		left.style.right = -200;
		//leftView.style.left = 0;
	}
}

// 좌측 박스를 보이는 기능
function leftbarShow() {
	var left = document.getElementById("tool_bar");
	//var leftView = document.getElementById("leftView");
	
	if(parseInt(left.style.right) == -200) {
		left.style.right = 1;
		leftView.style.right = 200;
	}
}
/* function directxPopup(){
	 var winform = window.open("${contextPath}/pop/pop.jsp","DirectX Install", "width = 430, height = 330, resizable=no, scrollbars=no, status=no"); 
		//winform.moveTo(screen.availWidth/2-700/2,screen.availHeight/2 - 550/2);
	 } */
/* function directxPopup(){
	//location.replace("http://192.168.10.8:8080/data/Suwon3DSystem_UserManual.zip");
	window.open("${contextPath}/pop/pop.jsp","DirectX Install","width = 430, height = 330, resizable=no, scrollbars=no, status=no");
} */

</script>
<script type="text/javascript" for="XDOCX" event="MouseDown(Button, Shift, sx, sy)" >
	MouseDownEventHandler(Button, Shift, sx, sy);
	if(Button == 2){
		top.setWorkMode('');
	}
</script>
	
<script type="text/javascript" for="XDOCX" event="MouseUp(Button, Shift, sx, sy)" >
	
	MouseUpEventHandler(Button, Shift, sx, sy);
	
	var cam_pos = XDOCX.XDCamGetViewPos();
	var fAngle = XDOCX.XDCamGetAngle();
    var fdirect = XDOCX.XDCamGetDirect();
	if(cam_pos){
		cam_pos = cam_pos.split(',');
		
		if(cam_pos.length == 3){
			$('#g_cam_x').text(Math.round(cam_pos[0]));
			$('#g_cam_y').text(Math.round(cam_pos[1]));
			$('#g_cam_z').text(Math.round(cam_pos[2]));
			//$('#Angle').text(Math.round(fAngle));
			//$('#direct').text(fdirect);

			 XDOCX.XDChangeTextInfo("X", "X: "+cam_pos[0]);
			 XDOCX.XDChangeTextInfo("Y", "Y: "+cam_pos[1]);
			 XDOCX.XDChangeTextInfo("Z", "Z: "+cam_pos[2]);
			 var lonlat = XDOCX.XDConvertProjection(15, 13, Math.round(cam_pos[0]), Math.round(cam_pos[1]));
			 var data = lonlat.split(",");
			 XDOCX.XDChangeTextInfo("LON", "LON: "+data[0]);
			 XDOCX.XDChangeTextInfo("LAT", "LAT: "+data[1]);			 
		}
	}

</script>
</head>

<body style="overflow:hidden;" onkeydown="javascript:if(event.keyCode==46){return false;}">

<div id="left_base"><iframe id="base" name="base" frameborder="0" width="326px" height="100%" src="${contextPath}/base.do" scrolling="no"></iframe></div>
<div id="tool_bar"><iframe name="tool" frameborder="0" width="220px" height="105" src="${contextPath}/tool.do" scrolling="no"></iframe></div>
<div id="maparea" style="position:absolute;top:0px;left:326px;width:74%;height:100%;scrolling:no;z-index:2;">        
	<script type="text/javascript">
    		xdk();
    </script>
   
</div>

<div id="Load" style="display:none;">
<iframe name="load" allowTransparency='true'  marginwidth='0' marginheight='0' scrolling='no' frameborder='0' width="220px" height="105px" src="${contextPath}/progress.do" scrolling="no" />
</div> 
<div id="tool_barClose" style="display: block;"><img src="./images/tool/toolClose_off.gif" alt="닫기" name="Image7" width="32" height="105" border="0" onclick="top.toolbarClose();"></img></div>
</body>
</html>