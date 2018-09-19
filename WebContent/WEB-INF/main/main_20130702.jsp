<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" scope="request" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>수원</title>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link rel="stylesheet" href ="./csss.css" type = "text/css" />	
<link rel="stylesheet" href="./jquery.treeview.css" />
<link rel="stylesheet" href="./css/screen.css" />
<link rel="stylesheet" href="./js/colorpicker/css/colorpicker.css" type="text/css" />
<link rel="stylesheet" media="screen" type="text/css" href="../js/colorpicker/css/layout.css" />
<script src="./js/jquery.js" type="text/javascript"></script>
<script src="./js/jquery.cookie.js" type="text/javascript"></script>
<script src="./js/jquery.treeview.js" type="text/javascript"></script>
<script type="text/javascript" src="./js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="./pluginTest/layer.js"></script>
<script type="text/javascript" src="./js/json2.js"></script>
<script type="text/javascript" src="./js/xdk.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript" src="./js/XDControl.js"></script>
<script type="text/javascript" src="./js/colorpicker/js/colorpicker.js"></script>
<script type="text/javascript" src="./js/colorpicker/js/eye.js"></script>
<script type="text/javascript" src="./js/colorpicker/js/utils.js"></script>
<script type="text/javascript" src="./js/colorpicker/js/layout.js?ver=1.0.2"></script>
<script type="text/javascript" src="./js/farbtastic/farbtastic.js"></script>
 <link rel="stylesheet" href="./js/farbtastic/farbtastic.css" type="text/css" />
 <%
 	Date date = new Date();
    SimpleDateFormat fo = new SimpleDateFormat("yyyyMMddHHmmss");
    String now = fo.format(date); 
%>
<script type="text/javascript" language="javascript"><!--
	$(window).bind("resize", jsWResize);
	
    $(document).ready(function() {
	     //$('#colorpicker').farbtastic('#color');
	     $('#colorpicker2').farbtastic('#color2');
	});	
	// 트리구조
	function libView(){	
			top.TDS_VIEW.XDLayReadFile("c:\\xdcashe\\kopss\\BASE.xdl");
			TDS_VIEW.XDCtrlSetView(0);
			TDS_VIEW.XDMapRender();		
		
	}

	var tmp_size_height = document.documentElement.clientHeight;//size.height;
	var tmp_left_height = document.documentElement.clientHeight;//size.height;
	var tmp_size_width = document.documentElement.clientWidth;//size.width;
	var winWidthNum = 290;
	var libWidthNum = tmp_size_width/100*80;
	window.onload = function(){
		
		//$("#maparea").width(tmp_size_width-winWidthNum);
		//$("#mouseMode").val("1");// html select box 초기화
		//setLayerInfo();
		//xdServerConnect('59.25.182.44', 9860, '', 0, 0);//대전 테스트 서버
		//xdServerConnect('10.1.19.171', 9830, '', 0, 0);//대전 테스트 서버		
		//jsonCallBack();
		
		
		$("#maparea").width(tmp_size_width-winWidthNum);
		$("#maparea").height(tmp_size_height);
		//alert(libWidthNum);
		//top.XDOCX.XDLayCreateEX( 14, "Present", 0, 10000000090); //14
		//top.XDOCX.XDLaySetEditable ("Present");
		//top.XDOCX.XDSetCurrentColor(100, 255, 0, 0);
	}

	function jsWResize(){
		
		tmp_size_width = document.documentElement.clientWidth
		libWidthNum = tmp_size_width/100*80;
		
		$("#maparea").width(tmp_size_width-winWidthNum);	
		
	}	


//tr에 컬러 스타일 넣기
	function modifyInputSize()	{
		var inputOjb = $("input[type=button]"); //모든 인풋 버튼 객체
		inputOjb.each(function(i){ //인풋 객체 순환 함수
			inputOjb[i].style.width="120"; // 버튼 넓이
			inputOjb[i].style.height="25"; // 버튼 넓이
			inputOjb[i].style.align="left";//버튼 정렬
		});
	}	
	
/**
 * 스크립트 부르는 함수
 */
	function inputHover(){
		//$("#bottom_menu").find('input[type=button]').hover( // input 객체 버튼 타입에 후버 효과 주기
		$("#makingMenu > input[type=button]").hover( // input 객체 버튼 타입에 후버 효과 주기
				function() {
					$(this).addClass("inputb"); //마우스 올렸을때
				},
				function() {
					$(this).removeClass("inputb");//마우스 내렸을때
				}
			);
	}

	
	//document.onkeyup=eventHandler; // 이벤트 적용

	function writeHelpMsg(msg){
		$('#helpMessage').text(msg);
	}
	
	function setColor(){
		var h = "";
		if($('#line').css('display') == 'block'){
			 h = $("input[name='color']").val();
		}else{
			 h = $("input[name='color2']").val();
		}
		//alert(h);
		var r = parseInt((cutHex(h)).substring(0,2),16);
		var g = parseInt((cutHex(h)).substring(2,4),16);
		var b = parseInt((cutHex(h)).substring(4,6),16);
		return r+","+g+","+b;
	}

	function cutHex(h) {
		return (h.charAt(0)=="#") ? h.substring(1,7) : h
	}
	
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
	var inputCnt = 1;

	function Line_Set(mode){
		   //var layerType = $("#selectLayertype option:selected").val();
		   //var layerName = $("#selectLayertype option:selected").text();
		   var alpha = $("input[name='alpha']").val();
		   var objectId = "line"+inputCnt;
		   var lineText = $("input[name='lineText']").val();
		   if(lineText == ""){
			   lineText = objectId;
		   }
		   
		   //alert(layerType+","+layerName);
		   
		   var size = $("input[name='lineSize']").val();
		   	   
		   top.XDOCX.XDLaySetSelectable("createLine", true);
		   top.XDOCX.XDSetMouseState(21);
		   //top.setWorkMode(mode);
		   
		   $('#maparea').dblclick(function() {
			   var color = setColor().split(",");
			   top.XDOCX.XDLaySetEditable("createLine");
			   //alert(alpha+","+color[0]+","+color[1]+","+color[2]);
			   top.XDOCX.XDRefSetColor(alpha, color[0], color[1], color[2]);
			   //alert(objectId+","+size);
			   top.XDOCX.XDObjCreateLine(objectId, size, false);

               //bool rst = top.XDOCX.XDObjCreateBufferEx("1", 5, 1);
               top.XDOCX.XDUIClearInputPoint();
               top.XDOCX.XDMapRender();
               
               top.XDOCX.XDSetMouseState(1);
			   var vertex = top.XDOCX.XDObjGetVertex("createLine", objectId);
			   //alert(vertex);               

    		   $('#result').append($(
    				   '<tr onclick="goToObj(this)" id="'+objectId+'">'+   				   
    				   '	<td width="30" align="center">'+
		    	       '<input type="hidden" value="createLine" id="layerNameFind" name="layerNameFind"/>'+    				   
		    	       '<input type="hidden" value="'+vertex+'" id="'+objectId+'" name="'+objectId+'"/>'+   				   
		    	       +inputCnt+'</td>'+
    				   '	<td align="center">'+lineText+'</td>'+
    				   '</tr>'
		       ));             
    		   inputCnt++;
               $('#maparea').unbind('dblclick');
               $("input[name='lineText']").val("");
		   });
	}
	
	function Plane_Set(mode){
		   //var layerType = $("#selectLayertype option:selected").val();
		   //var layerName = $("#selectLayertype option:selected").text();
		   var alpha = $("input[name='alpha']").val();		   
		   var objectId = "plane"+inputCnt;
		   var lineText = $("input[name='lineText']").val();
		   if(lineText == ""){
			   lineText = objectId;
		   }		   
		   //alert(layerType+","+layerName);
		   
		   var size = $("input[name='lineSize']").val();
		   
		   top.XDOCX.XDLaySetSelectable("createPlane", true);
		   top.XDOCX.XDSetMouseState(21);
		   //top.setWorkMode(mode);
		   
		   $('#maparea').dblclick(function() {
			   var color = setColor().split(",");
			   alert(alpha+","+color[0]+","+color[1]+","+color[2]);
			   top.XDOCX.XDLaySetEditable("createPlane");
			   top.XDOCX.XDRefSetColor(alpha, color[0], color[1], color[2]);
			   top.XDOCX.XDObjCreatePolygon(objectId, "", 0, 0);
               //bool rst = top.XDOCX.XDObjCreateBufferEx("1", 5, 1);
               var vertex = top.XDOCX.XDObjGetVertex("createPlane", objectId);
               top.XDOCX.XDMapRender();
               top.XDOCX.XDUIClearInputPoint();
               top.XDOCX.XDSetMouseState(1);
    		   $('#result').append($(
    				   '<tr onclick="goToObj(this)" id="'+objectId+'">'+   				   
    				   '	<td width="30" align="center">'+
		    	       '<input type="hidden" value="createPlane" id="layerNameFind" name="layerNameFind"/>'+    				   
		    	       '<input type="hidden" value="'+vertex+'" id="'+objectId+'" name="'+objectId+'"/>'+
		    	       +inputCnt+'</td>'+
    				   '	<td align="center">'+lineText+'</td>'+
    				   '</tr>'
		       ));               
               inputCnt++;
               // 이벤트 삭제
               $('#maparea').unbind('dblclick');
               $("input[name='lineText']").val("");
		   });
	}
	
	function inputPoint(){
	
		top.XDOCX.XDSetMouseState(40);
	    var pointText = $("input[name='pointText']").val();	
	    var pointSize = $("input[name='pointSize']").val();
	    var pointfile = $("input[name='pointfile']").val();
	    var iStyle = 0;
	    
	    var objectId = "point"+inputCnt;
	    var lineText = $("input[name='lineText']").val();
	    if(lineText == ""){
		    lineText = objectId;
	    }		    
		var OR = 0;
		var OG = 0;
		var OB = 0;
	    
	    if($("input:checked[id='textbox']").is(":checked")==true){
	    	iStyle = 3;
	    }else{
	    	iStyle = 0;
	    }

		var color = setColor().split(",");	    
        top.XDOCX.XDLaySetEditable("createPoint");

        
        
        if (iStyle == 2)
        {
            OR = 90; OG = 90; OB = 90;
        }
        //istyle => 0: nomal 1: 테두리 2: 박스 3 : 투명 배경색 4: 테두리+박스

	    top.XDOCX.XDSetMouseState(40);
        
		   $('#maparea').dblclick(function() {
			   
		       top.XDOCX.XDRefSetFontStyle("gulim", pointSize, true, true, iStyle, 0, 0, 0);
		       top.XDOCX.XDRefSetColor(255, color[0], color[1], color[2]);			   
			   var xdpos = XDOCX.XDUIClickPos();
			   pos = xdpos.split(",");
		       top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
		       //alert(objectId+","+pointText+","+pointfile);
		       //result = top.XDOCX.XDObjCreateTextEX(objectId, pointText, "", 0, 0);
		       //alert(pointfile.replace(/\\/gi, '\\\\'));
		       
		       XDOCX.XDObjCreateText(objectId, pointText, pointfile);
		        //텍스트 보기여부 ocx4.0에서 작동안함
		       if ($("input:checked[id='textvisible']").is(":checked") == true)
		       {
		           //top.XDOCX.XDObjPointSetAlign(layerName, objectId, 0);
		       }
		       else
		       {
		           //top.XDOCX.XDObjPointSetAlign(layerName, objectId, 128);
		       }
		       top.XDOCX.XDUIClearInputPoint();
		       top.XDOCX.XDMapRender();
               var vertex = top.XDOCX.XDObjGetVertex("createPlane", objectId);
               alert(vertex);		        
               top.XDOCX.XDSetMouseState(1);
    		   $('#result').append($(
    				   '<tr onclick="goToObj(this)" id="'+objectId+'">'+   				   
    				   '	<td width="30" align="center">'+
		    	       '<input type="hidden" value="createPoint" id="layerNameFind" name="layerNameFind"/>'+
		    	       '<input type="hidden" value="'+pos[0]+","+pos[1]+","+pos[2]+'" id="'+objectId+'" name="'+objectId+'"/>'+
    				   +inputCnt+'</td>'+
    				   '	<td align="center">'+lineText+'</td>'+
    				   '</tr>'
		       ));               
               inputCnt++;
               // 이벤트 삭제
               $('#maparea').unbind('dblclick');
               $("input[name='pointText']").val("");
               $("input[name='lineText']").val("");
               
		   });
		
	}
	
	function colorDisplay(val){
		$('#colorpicker').css('display');
		if(val == 1){
			if($('#colorpicker').css('display') == 'block'){
				$('#colorpicker').css('display', 'none');
			}else{
				$('#colorpicker').css('display', 'block');
			}			
		}else{
			if($('#colorpicker2').css('display') == 'block'){
				$('#colorpicker2').css('display', 'none');
			}else{
				$('#colorpicker2').css('display', 'block');
			}			
		}
	}
	
	function radioDisplay(){
		 if($("input[name='mode2']:checked").val() == 1){
			 $('#line').show();
			 $('#point').hide();
			 $('#linebutton').show();
			 $('#planebutton').hide();
		 }else if ($("input[name='mode2']:checked").val() == 2){
			 $('#line').show();
			 $('#point').hide();
			 $('#linebutton').hide();
			 $('#planebutton').show();		 
		 }else{
			 $('#line').hide();
			 $('#point').show();
		 }
	} 
	
	function layerCreate(){
		   var layerName = $("input[name='layerName']").val();
		   var signMin = $("input[name='signMin']").val();
		   var signMax = $("input[name='signMax']").val();
		   var layerType = $("#layerType option:selected").val();
		   //var layerTypeName = $("#layerType option:selected").text();
		   //alert(layerTypeName+","+layerName+","+signMin+","+signMax+","+layerType);
	       top.XDOCX.XDMapRenderLock(true);
	       top.XDOCX.XDLayCreate(layerType, layerName);
	       top.XDOCX.XDMapRenderLock(false);
	       top.XDOCX.XDLaySetHiddenValue(layerName, signMin, signMax);
	       $("#selectLayertype").append("<option value='"+layerType+"'>"+layerName+"</option>");
	}
	
	function goToObj(obj){
		var	strCode = "";
		var	strLayer = "";
		
		$(obj).find('td').each(function(i){
			if(i == 1){
				strCode = $(this).text();
			}
			if(i == 0){
				strLayer = $(this).find('[name=layerNameFind]').val(); 
			}

		});	
		
        var objPos = top.XDOCX.XDObjGetPosition(strLayer, strCode);
        var posArr = objPos.split(',');

        var px, py, pz;
        px = posArr[0];
        py = posArr[1];
        pz = posArr[2];

        var fAngle = top.XDOCX.XDCamGetAngle();
        var fdirect = top.XDOCX.XDCamGetDirect();

        top.XDOCX.XDCamSetDirect(fdirect + 90);
        top.XDOCX.XDCarmeraMoveOval(px, py, pz, 8);
        top.XDOCX.XDCamSetDistance(500);
        top.XDOCX.XDCamSetAngle(45);
        top.XDOCX.XDMapDataLoad(); 
        
	}
	var leftValue;
	function delObj(){
		top.XDOCX.XDSetMouseState(6);
		top.setWorkMode("오브젝트 삭제");
		
	}
	
	function delTable(value){
		
		 $("input[name="+value+"]").each(function() {
		      $(this).parent().parent().remove();
		  });
	}
	
	function saveObj(){
		var objectList = "";
		 $("#result tr").each(function(index) {
	      //alert($('input:hidden', this).get(i).attr("name"));
	      $('input:hidden', this).each(function(i){
	    	  if(i%2 != 0){
	    		  //alert($(this).attr("name"));
	    	   //alert(document.getElementById('"'+$(this).attr("name")+'"').value);
	    		  objectList = objectList +"," + $(this).attr("name");
	    	  }
	    	  
	      });

	  });

	      $("input[name='objectList']").val(objectList);
	      //alert($("input[name='objectList']").val());
	}
	
	// 도형 draw 함수
	function figure(val){
		var alpha = $("input[name='layerName']").val();
		var color = setColor().split(",");
		top.XDOCX.XDRefSetColor(alpha, color[0], color[1], color[2]);
		top.XDOCX.XDSetMouseState(val);
	}
	
	var filePath = "";
	function exportFile(){
		var name = $("input[name='name']").val();
		var now = '<%=now%>';
		var file =  'C:/xdcashe/'+name+"_"+now+"작성자.xdl";
		filePath =  'C:/xdcashe/'+name+"_"+now+"작성자.xdl";
		var layerfileName =  name+"_"+now+"작성자.xdl";
		top.XDOCX.XDLaySaveFile("Present", file);
	
	}
	function fileSave(){
		
		//$("input[name='objectList']").val(objectlist);
		//$("input[name='layerfileName']").val(layerfileName);
		var frm = document.getElementById('frm');
		frm.action = "writeObject.do";
		frm.submit();
	}
	function XDNetUploadFile(){
		var WEB_SERVER_URL1 = 'http://10.1.19.171:8080/Templet';
		var m_workPath1 = "c:\\xdcashe\\";
		var url = WEB_SERVER_URL1 + "/symbols/";
		var a = top.XDOCX.XDNetUploadFile(url + "adsfasdfads_20130628175442작성자.xdl", m_workPath1 + "adsfasdfads_20130628175442작성자.xdl");
		alert(a);
	}

</script>


<script type="text/javascript" for="XDOCX" event="MouseDown(Button, Shift, sx, sy)" >
	MouseDownEventHandler(Button, Shift, sx, sy);
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

		}
	}
</script>


</head>

<body style="overflow: hidden;">
<form id="frm" action="" method="post" enctype="multipart/form-data">
<input type="hidden" value="" id="objectList" name="objectList"/>
<input type="file" value="" id="filePath" name="filePath" style="display:none;"/>
<input type="hidden" value="" id="layerfileName" name="layerfileName"/>
<div style="z-index:99;">

<table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:270px; border:1px solid #999999;">
<tr>
<td><select id="SggNm" onchange="embSearch(this.value)">
			<option value="0">-----시군구-----</option>
			<option value="41117">영통구</option>
			<option value="41113">권선구</option>
			<option value="41111">장안구</option>
			<option value="41115">팔달구</option>
			</select></td>             
</tr>
<tr>
<td><select id="embNm" onchange="embSearch(this.value)">
			<option value="0">-----읍면동-----</option>
			</select></td>             
</tr>
</table>
	
<table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:270px; border:1px solid #999999;">
			<tr>
				<td width="120px" align="center">오브젝트 생성</td>
			</tr>
			<tr>
				<td width="120px">도면명칭</td>
				<td><input type="text" id="name" name="name" value="" style="width:130px; border:1px solid #999999;"></input></td>
			</tr>			
			<tr>
				<td>명칭</td>
				<td><input type="text" id="lineText" name="lineText" value="" style="width:130px; border:1px solid #999999;"></input></td>
			</tr>			
			<tr>
				<td align="center"><input type="button" value="포인트입력" style="width:120px; border:1px solid #999999;" onclick="inputPoint();"></input></td>
				<td align="center"><input type="button" value="OnRect" style="width:120px; border:1px solid #999999;" onclick="figure(101);"></input></td>
			</tr>		
			<tr>
				<td>포인트명</td>
				<td><input type="text" value="" id="pointText" name="pointText" style="width:130px; border:1px solid #999999;"></input></td>
			</tr>
			<tr>
				<td>포인트 사이즈</td>
				<td><input type="text" value="15" id="pointSize" name="pointSize" style="width:130px; border:1px solid #999999;"></input></td>
			</tr>					
			
			<tr>
				<td>글자색상</td>
				<td><input type="text" id="color2" name="color2" readonly="readonly" value="#123456" onclick="colorDisplay(2);"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><div id="colorpicker2" style="align:center; display:none;"></div></td>
			</tr>		
			<tr>
				<td>포인트이미지</td>
				<td><input type="file" id="pointfile" name="pointfile" value="128" style="width:130px; border:1px solid #999999;"></input></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="checkbox" id="textvisible" name="textvisible" >테스트보이기</input><input type="checkbox" id="textbox" name="textbox" >텍스트박스</td>
			</tr>

			<tr>
				<td colspan="2" align="center"><input type="button" value="오브젝트 삭제" style="width:130px; border:1px solid #999999;" onclick="delObj();"></input></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="도면저장" style="width:130px; border:1px solid #999999;" onclick="exportFile();"></input></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="파일저장 테스트" style="width:130px; border:1px solid #999999;" onclick="XDNetUploadFile();"></input></td>
			</tr>			
										

</table>   	  
    	</div>
</form>    	
<div id="maparea" style="position:absolute;top:0px;left:280px;width:84%;height:100%;display:block;scrolling:no;z-index:1;display:block">        
	<script type="text/javascript">
    		xdk();
    	</script>
</div>
    <table width="268" border="0" cellpadding="0" cellspacing="0" style="margin-left:10px; font-weight:bold; color:#092061; text-align:center;">
      <tr>
        <td align="center">X :<span id="g_cam_x"></span></td>
        <td>Y :<span id="g_cam_y"></span></td>
        <td >Z :<span id="g_cam_z"></span></td>
        </tr>
    </table>
</body>
</html>

