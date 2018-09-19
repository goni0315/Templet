<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="./css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}
//-->
</script>
<style type="text/css">
<!--
#menu_search {
	position:absolute;
	width:66px;
	height:164px;
	z-index:1;
	left: 190px;
	top: 77px;
}
#menu_edit {
	position:absolute;
	width:102px;
	height:155px;
	z-index:1;
	left: 154px;
	top: 134px;
}
#menu_analysis {
	position:absolute;
	width:102px;
	height:129px;
	z-index:1;
	left: 154px;
	top: 267px;
}
-->
</style>
<script>
function searchXYGo(x_point, y_point)
{
	var url = 'c:\\xdcashe\\';
	top.XDOCX.XDLayClear("Temporary");
    top.XDOCX.XDCamSetAngle(51);
    top.XDOCX.XDCamMove(x_point, 100, y_point, 10);
    top.XDOCX.XDCamSet(x_point, y_point, 300, 51); // 300은 가시거리 설정 값 51은 틸트값
    top.XDOCX.XDLaySetEditable("Temporary");
    top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
    top.XDOCX.XDRefSetColor(0, 255, 0, 0);

	var hei = top.XDOCX.XDTerrGetHeight(x_point, y_point);
    top.XDOCX.XDRefSetPos(x_point, hei, y_point);
	top.XDOCX.XDObjCreateText("pos_poi", "", url+"pointer.png");	
	//top.XDOCX.XDLayerSetEditable(top.getTmpLayer());        
    
    top.XDOCX.XDCamSetMode(0);
	setTimeout(function(){
		top.XDOCX.XDRenderData();
		top.XDOCX.XDMapRender();
		top.XDOCX.XDMapLoad();
	}, 500);
}

var layerList = "";

function getLayerListPu(){
	return layerList;
}

function setLayerListPu(val){
	val = val+'#on#off';
	layerList = layerList+","+val;
	
}

function setLayerListExt(val){
	top.appendExtLayerInfo(val);
}

var layerSave = "";
function setEditSaveLayer(val){
	layerSave = val;
}

function getEditSaveLayer(){
	return layerSave;
}

function deleteLayerListPu(lyr_name){
	var temp_arr = "";
	var layerListPos = layerList.split(",");
	for(var i =1; i<layerListPos.length; i++){
		var pos = layerListPos[i].split("#");
		if(pos[1] != lyr_name){	
			temp_arr = temp_arr+","+layerListPos[i];
		}		
	}

	layerList = temp_arr;
	return layerList;
}


</script>
</head>

<body style="background:url(./images/common/bg.gif)" onLoad="MM_preloadImages('./images/menu/menu02_on.gif','./images/menu/menu03_on.gif','./images/menu/menu04_on.gif','./images/menu/menu05_on.gif','./images/menu/menu06_on.gif','./images/menu/menu07_on.gif','./images/menu/menu01_off.gif','./images/menu/menu01_on.gif')">
<table border="0" cellpadding="0" cellspacing="0" style="width:300px">
  <tr>
    <td height="50" colspan="2" valign="top"><img src="./images/common/top_ci.gif" alt="수원시통합방위시스템" width="326" height="49" onclick="top.leftClose();" style="cursor: pointer"/></td>
  </tr>
  <tr>
    <td width="297" valign="top"><iframe name="contents" src="${contextPath}/searchJibun.do" frameborder="0" width="297" style="height:640px" scrolling="no"></iframe></td>
    <td width="29" valign="top">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td><a href="${contextPath}/searchJibun.do" target="contents" onClick="MM_nbGroup('down','group1','menu01off','./images/menu/menu01_on.gif',1)" onMouseOver="MM_nbGroup('over','menu01off','./images/menu/menu01_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/menu/menu01_on.gif" alt="검색" name="menu01off" border="0" id="menu01off" onload="MM_nbGroup('init','group1','menu01off','./images/menu/menu01_off.gif',1)" /></a></td>
        </tr>
      <tr>
        <td><a href="${contextPath}/situationUp.do" target="contents" onClick="MM_nbGroup('down','group1','menu02off','./images/menu/menu02_on.gif',1)" onMouseOver="MM_nbGroup('over','menu02off','./images/menu/menu02_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/menu/menu02_off.gif" alt="상황도" name="menu02off"  border="0" id="menu02off" onload="" /></a></td>
      </tr>
      <tr>
        <td><a href="${contextPath}/layer.do" target="contents" onClick="MM_nbGroup('down','group1','menu03off','./images/menu/menu03_on.gif',1)" onMouseOver="MM_nbGroup('over','menu03off','./images/menu/menu03_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/menu/menu03_off.gif" alt="레이어" name="menu03off"border="0" id="menu03off" onload="" /></a></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
