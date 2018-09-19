<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link href="./css/common.css" rel="stylesheet" type="text/css" />
	<script src="./js/treeview/lib/jquery.js" type="text/javascript"></script>
	<script src="./js/treeview/lib/jquery.cookie.js" type="text/javascript"></script>
	<script src="./js/treeview/jquery.treeview.js" type="text/javascript"></script>
	<script src="./js/treeview/jquery.treeview.edit.js" type="text/javascript"></script>
	<script src="./js/treeview/jquery.treeview.async.js" type="text/javascript"></script>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<style type="text/css">
<!--
.treeview, .treeview ul { 
	padding: 0;
	margin: 0;
	list-style: none;
}

.treeview ul {
	background-color: white;
	margin-top: 4px;
}

.treeview .hitarea {
	background: url(./images/treeview-default.gif) -64px -25px no-repeat;
	height: 16px;
	width: 16px;
	margin-left: -16px;
	float: left;
	cursor: pointer;
}
/* fix for IE6 */
* html .hitarea {
	display: inline;
	float:none;
}

.treeview li { 
	margin: 0;
	padding: 3px 0pt 3px 16px;
}

.treeview a.selected {
	background-color: #eee;
}

.treeview .selected{
	background-color: #c4c4c4;
}

#treecontrol { margin: 1em 0; display: none; }

.treeview .hover { color: red; cursor: pointer; }

.treeview li { background: url(./images/treeview-default-line.gif) 0 0 no-repeat; }
.treeview li.collapsable, .treeview li.expandable { background-position: 0 -176px; }

.treeview .expandable-hitarea { background-position: -80px -3px; }

.treeview li.last { background-position: 0 -1766px }
.treeview li.lastCollapsable, .treeview li.lastExpandable { background-image: url(./images/treeview-default.gif); }  
.treeview li.lastCollapsable { background-position: 0 -111px }
.treeview li.lastExpandable { background-position: -32px -67px }

.treeview div.lastCollapsable-hitarea, .treeview div.lastExpandable-hitarea { background-position: 0; }

.treeview-red li { background-image: url(./images/treeview-red-line.gif); }
.treeview-red .hitarea, .treeview-red li.lastCollapsable, .treeview-red li.lastExpandable { background-image: url(./images/treeview-red.gif); } 

.treeview-black li { background-image: url(./images/treeview-black-line.gif); }
.treeview-black .hitarea, .treeview-black li.lastCollapsable, .treeview-black li.lastExpandable { background-image: url(./images/treeview-black.gif); }  

.treeview-gray li { background-image: url(./images/treeview-gray-line.gif); }
.treeview-gray .hitarea, .treeview-gray li.lastCollapsable, .treeview-gray li.lastExpandable { background-image: url(./images/treeview-gray.gif); } 

.treeview-famfamfam li { background-image: url(./images/treeview-famfamfam-line.gif); }
.treeview-famfamfam .hitarea, .treeview-famfamfam li.lastCollapsable, .treeview-famfamfam li.lastExpandable { background-image: url(./images/treeview-famfamfam.gif); } 


.filetree li { padding: 3px 0 2px 16px; }
.filetree span.folder, .filetree span.file { padding: 1px 0 1px 16px; display: block; }
.filetree span.folder { background: url(./images/folder.gif) 0 0 no-repeat; }
.filetree li.expandable span.folder { background: url(./images/folder-closed.gif) 0 0 no-repeat; }
.filetree span.file { background: url(./images/file.gif) 0 0 no-repeat; }

-->
</style>

	<script type="text/javascript">

	
	$(function() {
		$(function() {
			$("#browser").treeview({
				animated: "fast",
				collapsed: true,
				unique: true,
				persist: "cookie",
				toggle: function() {
					window.console && console.log("%o was toggled", this);
				}
			});
		});
		
		var list_group = top.getLayerClassList();
		
		$.each(list_group, function(){
			var group = this;
			var group_id = group['gru_kor'];
			
			//if(group_id.indexOf('(') != -1){
			//	group_id = group_id.substring(0, group_id.indexOf('('));
			//}
			
			//테이블구조
//	 		$('#layer_panel').append($(
//	 			'<table width="230" border="0" cellpadding="0" cellspacing="0"  style="background-image:url(../images/left/layer_title.gif); cursor:hand;" onClick="setVisibleGroup(\''+group_id+'\')">'+
//	 			'	<tr>'+
//	 			'		<td height="28" style="padding-left:10px"><strong>'+group['lary_cls']+'</strong></td>'+
//	 			'	</tr>'+
//	 			'</table>'+
				     
//	 			'<table id="'+group_id+'" class="group_id" width="95%" border="0" cellpadding="0" cellspacing="0" style="margin-left:8px; display: none;"></table>'
//	 		));
			
			//트리구조
		$('#browser').append($(
				'<li>'+
				'	<span><strong>'+group['gru_kor']+'</strong></span>'+
				'	<ul id="'+group_id+'"></ul>'+
				'</li>'
			));		
			
		});
		$('#browser').append($(
				'<li>'+
				'	<span><strong>상황도</strong></span>'+
				'	<ul id="상황도"></ul>'+
				'</li>'
		));	
		
		var list_layer = top.getLayerInfo();
		
		$.each(list_layer, function(){
			var group_id = this['gru_kor'];
			var lary_enm = this['lay_eng'];
			//alert(lary_enm);
			//if(group_id.indexOf('(') != -1){
			//	group_id = group_id.substring(0, group_id.indexOf('('))
			//}
			
			var isVisible = top.XDOCX.XDLayGetVisible(lary_enm);
			var isEditable = top.XDOCX.XDLayGetEditable() == lary_enm;
			
			//테이블구조	
//	 		$('#'+group_id).append($(
//	 			'<tr layer="'+this['lary_enm']+'" onclick="selectLayer(\''+this['lary_enm']+'\')" class="layer">'+
//	 			'	<td width="18">&nbsp;</td>'+
//	 			'	<td width="140">'+this['lary_nm']+'</td>'+
//	 			'	<td width="16"><img src="../images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16" onclick="setLayerVisible(this, \''+this['lary_enm']+'\');"></td>'+
	// // 			'	<td width="18"><input type="radio" name="layer_editable" '+(isEditable ? 'checked="checked"' : '')+' onclick="setLayerEditable(\''+this['lary_enm']+'\')" /></td>'+
//	 			'	<td width="16"><img src="../images/icon_opacity_'+(this.isAlpha ? 'on' : 'off')+'.gif" width="16" height="16" isAlpha="false" onclick="setLayerAlpha(this, \''+this['lary_enm']+'\');"></td>'+
//	 			'</tr>'
//	 		));
			
			//트리구조
//	 		$('#'+group_id).append($(
//	 			'	<li style="width: 100%;" layer="'+this['lary_enm']+'" onclick="selectLayer(\''+this['lary_enm']+'\')" class="layer">'+
//	 			'		<span style="float: left;">'+this['lary_nm']+'</span>' +
//	 			'		<span style="float: right;">' +
//	 			'			<img src="../images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16" onclick="setLayerVisible(this, \''+this['lary_enm']+'\');">'+
	// // 			'<input type="radio" name="layer_editable" layer="'+this['lary_enm']+'" '+(isEditable ? 'checked="checked"' : '')+' onclick="setLayerEditable(\''+this['lary_enm']+'\')" />' +
//	 			'			<img src="../images/icon_opacity_'+(this.isAlpha ? 'on' : 'off')+'.gif" width="16" height="16" isAlpha="false" onclick="setLayerAlpha(this, \''+this['lary_enm']+'\');">'+
//	 			'		</span>'+
//	 			'	</li>'
//	 		));
			
			$('#'+group_id).append($(
					'	<li  style="width: 80%;" layer="'+this['lay_eng']+'" onclick="selectLayer(\''+this['lay_eng']+'\')" style="cursor:pointer">'+
		 			'		<span style="width: 150px;">'+this['lay_kor']+'</span>' +
		 			'		<span>' +
					'			<img src="./images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16" onclick="setLayerVisible(this, \''+this['lay_eng']+'\');">'+
//		 			'<input type="radio" name="layer_editable" layer="'+this['lary_enm']+'" '+(isEditable ? 'checked="checked"' : '')+' onclick="setLayerEditable(\''+this['lary_enm']+'\')" />' +
					'			<img src="./images/icon_opacity_'+(this.isAlpha ? 'on' : 'off')+'.gif" width="16" height="16" isAlpha="false" onclick="setLayerAlpha(this, \''+this['lay_eng']+'\');">'+
					'		</span>'+
					'	</li>'
				));
		});
				
		//트리구조

		

	});

	function setLayerVisible(obj, layer_name){
		//alert(layer_name);
		obj = $(obj);
		
		var src = obj.attr('src');
		
		if(src.indexOf('_on') != -1){
			top.XDOCX.XDLaySetVisible(layer_name, false);
			$(obj).attr('src', './images/icon_light_off.gif');
		}else{
			top.XDOCX.XDLaySetVisible(layer_name, true);
			$(obj).attr('src', './images/icon_light_on.gif');
		}
		
		top.XDOCX.XDMapResetRTT();
		top.XDOCX.XDMapRender();
	}
	
	function setLayerAlpha(obj, layer_name){
		obj = $(obj);
		var color = "0,0,0,0";
		
		if(top.XDOCX.XDLayGetType(layer_name) == 8) {
			color = top.XDOCX.XDLayGetColor(layer_name);
		} else {
			color = top.XDOCX.XDLayGetInstColor(layer_name);
		}

		if (color == "0,0,0,0") {
			color = "0,255,255,255";
		}
		tmpColor = color.split(",");
		
		if (tmpColor[0] > 0 & tmpColor[0] < 255) {
			obj.attr('src', './images/icon_opacity_off.gif');
			//obj.attr('isAlpha', 'true');
			top.TmpRefColor(0, color[1], color[2], color[3]);
			if(top.XDOCX.XDLayGetType(layer_name) == 8) {
//	 			top.XDOCX.XDLaySetColor(layer_name);
				top.XDOCX.XDLaySetAlpha(layer_name, 255);
		 		
			} else {
				top.XDOCX.XDLaySetInstColor(layer_name);
			}
			top.GetRefColor();
		} else {	
			obj.attr('src', './images/icon_opacity_on.gif');
			//obj.attr('isAlpha', 'false');
			top.TmpRefColor(150, tmpColor[1], tmpColor[2], tmpColor[3]);
			if(top.XDOCX.XDLayGetType(layer_name) == 8) {
//	 			top.XDOCX.XDLaySetColor(layer_name);
				top.XDOCX.XDLaySetAlpha(layer_name, 100);
			} else {
				top.XDOCX.XDLaySetInstColor(layer_name);
			}
			top.GetRefColor();
			top.XDOCX.XDLaySetVisible(layer_name, true);
		}
		top.XDOCX.XDMapRender();
	}
	
	var layer_check = "";
	function selectLayer(layer_name){
		layer_check = layer_name;
		$('.layer').removeClass('selected');
		$('[layer='+layer_name+']').addClass('selected');
		
		var hValue = top.XDOCX.XDLayGetHiddenValue(layer_name).split(',');
		
		if(hValue.length == 2){
			$('#vis_min').val(Math.round(hValue[0]));
			$('#vis_max').val(Math.round(hValue[1]));
		}
	}
	

	function setLayerHiddenValue(){
		var layer = layer_check;
		
		if (layer == "") {
			alert("적용할 레이어를 선택하세요");
			return;
		}
		if ($('#vis_min').val() == '') {
			alert("최소고도를 입력하세요");
			return;
		}
		if ($('#vis_max').val() == '') {
			alert("최대고도를 입력하세요");
			return;
		}
		
		top.XDOCX.XDLaySetHiddenValue(layer, $('#vis_min').val(), $('#vis_max').val());
	}
	
	function layRemove() {	//레이어 제거
		//divOpen();
		var layer = layer_check;
		
		if (layer == "") {
			alert("삭제할 레이어를 선택하세요");
			return;
		}
		
		if(layer == 'Temporary'){
			alert("임시 레이어는 삭제할 수 없습니다.");
			return;
		}
		
		if(confirm("해당 레이어를 삭제하시겠습니까?")){
			top.XDOCX.XDLaySetVisible(layer, false);
			top.XDOCX.XDLayRemove(layer);
			top.XDOCX.XDMapRender();
			$('#'+layer_check).remove();
			top.deleteLayerListPu(layer);
			
			
		}
	}
	
	function layExport() {	//레이어 내보내기
		var layer = layer_check;
		if (layer == "") {
			alert("저장할 레이어를 선택하세요");
			return;
		}
		
		var tmpFile = top.XDOCX.XDUIOpenFileDlg(false, "xdl");
		
		if (tmpFile == "") return; 
		
		if (top.XDOCX.XDLaySaveFile(layer, tmpFile)){
			alert(" 레이어 저장에 성공하였습니다. ");
		}else{
			alert(" 레이어 저장에 실패하였습니다. ");
		}
		
	}
	function layCreate(){
//	 	var display = $('#inc_create_layer').css('display').toUpperCase();
		
//	 	if(display == 'NONE'){
//	 		$('#inc_create_layer').show();
//	 	}else{
//	 		$('#inc_create_layer').hide();
//	 	}
		top.XDOCX.XDLaySetVisible("Present1", false);
		top.XDOCX.XDLayRemove("Present1");
		top.XDOCX.XDMapRender();
		$('#Present1').remove();
		top.deleteLayerListPu("Present1");
		
		top.XDOCX.XDLayCreateEX( 14, "Present1", 0, 10000000090); //14
		top.XDOCX.XDLaySetEditable ("Present1");
		top.XDOCX.XDSetCurrentColor(100, 255, 0, 0);
		$('#drowList').append($(
				'<li id=Present1 onclick="selectLayer(Present1)" class="layer" style="cursor:pointer">'+
				'	<span >생성된레이어</span>'+
				'	<img src="./images/icon_light_on.gif" width="16" height="16" onclick="setLayerVisible(this,Present1);" style="cursor: pointer;" />'+
				'</li>'

			));	
		alert("레이어가 생성되었습니다.");

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
	
	

</head>

<body style="background:url(./images/common/bg.gif)">
<table width="297" border="0" cellpadding="0" cellspacing="0" style="height:100%;">
	<tr>
		<td height="1"><img src="./images/layer/top_head.gif" alt="" width="297" height="59" /></td>
	</tr>
	<tr>
	  <td height="1"><table width="297" border="0" cellpadding="0" cellspacing="0" style="background:url(./images/search/sub_menu_bg.gif)">
	    <tr>
	      <td><table border="0" cellpadding="0" cellspacing="0">

	        </table></td>
        </tr>
	    <tr>
	      <td align="center" ><table width="253" border="0" cellpadding="0" cellspacing="0">
	        <tr>
	          <td width="64" height="25" class="f_whit">최대고도</td>
	          <td width="124"><input name="vis_max" type="text" id="vis_max" onkeydown="fnc_input_number()" maxlength="7" style="width:100px;" /></td>
	          <td width="65" rowspan="2" align="center"><a href="javascript:setLayerHiddenValue();"><img src="./images/common/btn_set.gif" width="65" height="43" alt="적용" /></a></td>
	          </tr>
	        <tr>
	          <td height="25" class="f_whit">최소고도</td>
	          <td><input name="vis_min" type="text" id="vis_min" onkeydown="fnc_input_number()"  maxlength="7" style="width:100px;" /></td>
	          </tr>
          </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="1" valign="bottom" style="background:url(./images/search/sub_menu_bg.gif)"><img src="./images/search/sub_menu_end.gif" alt="" width="297" height="11" /></td>
  </tr>
	<tr>
	  <td height="4"><img src="./images/layer/list_title.gif" alt="" width="297" height="33" /></td>
  </tr>
  <tr>
    <td valign="top" style="background-image:url(./images/search/contents_bg.gif)">
     	<div id="layer_panel"  style="width:282px; height:400px; overflow-y:scroll;">
	    	<ul id="browser">
	    	</ul>
    	</div>
    </td>
  </tr>
  <tr>
    <td height="10" valign="top" style="background-image:url(./images/search/contents_bg.gif)"><img src="./images/search/contents_bottom.gif" alt="" width="297" height="10" /></td>
  </tr>
</table>
</body>
</html>
