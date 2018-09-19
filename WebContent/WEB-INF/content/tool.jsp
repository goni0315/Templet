<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="./css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./js/menu.js"></script>
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
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->


</script>
</head>

<body onLoad="MM_preloadImages('./images/tool/tool01_on.gif','./images/tool/tool02_on.gif','./images/tool/tool03_on.gif','./images/tool/tool05_on.gif','./images/tool/tool06_on.gif','./images/tool/toolClose_on.gif')">
<div id="border" style="display: block;">
<table width="220" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="32" rowspan="2"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','./images/tool/toolClose_on.gif',1)"><img src="./images/tool/toolClose_off.gif" alt="닫기" name="Image7" width="32" height="105" border="0" onclick="top.toolbarClose();"></a></td>
    <td width="63"><a href="javascript:;" target="_top" onClick="MM_nbGroup('down','group1','tool01off','./images/tool/tool01_on.gif',1)" onMouseOver="MM_nbGroup('over','tool01off','./images/tool/tool01_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/tool/tool01_off.gif" alt="거리측정" name="tool01off" width="63" height="53" border="0" onclick="top.XDOCX.XDSetMouseState(81);"></a></td>
    <td width="61"><a href="javascript:;" target="_top" onClick="MM_nbGroup('down','group1','tool02off','./images/tool/tool02_on.gif',1)" onMouseOver="MM_nbGroup('over','tool02off','./images/tool/tool02_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/tool/tool02_off.gif" alt="높이측정" name="tool02off" width="61" height="53" border="0" onclick="top.getHeight();"></a></td>
    <td width="64"><a href="javascript:;" target="_top" onClick="MM_nbGroup('down','group1','tool03off','./images/tool/tool03_on.gif',1)" onMouseOver="MM_nbGroup('over','tool03off','./images/tool/tool03_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/tool/tool03_off.gif" alt="손이동" name="tool03off" width="64" height="53" border="0" onclick="top.XDOCX.XDSetMouseState(1);"></a></td>
  </tr>
  <tr>
    <td><a href="javascript:;" target="_top" onClick="MM_nbGroup('down','group1','tool04off','./images/tool/tool04_on.gif',1)" onMouseOver="MM_nbGroup('over','tool04off','./images/tool/tool04_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/tool/tool04_off.gif" alt="면적측정" name="tool04off" width="63" height="52" border="0" onclick="top.XDOCX.XDSetMouseState(80);"></a></td>
    <td><a href="javascript:;" target="_top" onClick="MM_nbGroup('down','group1','tool05off','./images/tool/tool05_on.gif',1)" onMouseOver="MM_nbGroup('over','tool05off','./images/tool/tool05_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/tool/tool05_off.gif" alt="부피측정" name="tool05off" width="61" height="52" border="0" onclick="top.getVolume();"></a></td>
    <td><a href="javascript:;" target="_top" onClick="MM_nbGroup('down','group1','tool06off','./images/tool/tool06_on.gif',1)" onMouseOver="MM_nbGroup('over','tool06off','./images/tool/tool06_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img src="./images/tool/tool06_off.gif" alt="초기화" name="tool06off" width="64" height="52" border="0" onclick="top.mapClear();"></a></td>
  </tr>
</table>
</div>
<div id="border2" style="display: none;">
<table width="220" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="32" rowspan="2"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','./images/tool/toolClose_on.gif',1)"><img src="./images/tool/toolClose_off.gif" alt="닫기" name="Image7" width="32" height="105" border="0" onclick="top.toolbarClose();"></a></td>
  </tr>
  </table>
</div>
</body>
</html>
