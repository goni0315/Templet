<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="stylesheet" href="./js/treeview/jquery.treeview.css" />
	<link href="./css/common.css" rel="stylesheet" type="text/css" />
	<script src="./js/treeview/lib/jquery.js" type="text/javascript"></script>
	<script src="./js/treeview/lib/jquery.cookie.js" type="text/javascript"></script>
	<script src="./js/treeview/jquery.treeview.js" type="text/javascript"></script>
	<script src="./js/treeview/jquery.treeview.edit.js" type="text/javascript"></script>
	<script src="./js/treeview/jquery.treeview.async.js" type="text/javascript"></script>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>

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
		var layerBasic = "기본도면레이어#Present";
		parent.setLayerListExt(layerBasic);
		$.each(list_group, function(){
			var group = this;
			var group_id = group['gru_kor'];
			

			//트리구조
		$('#browser').append($(
				'<li>'+
				'	<span onclick="visible(\''+group_id+'\')" style="cursor: pointer;"><strong>'+group['gru_kor']+'</strong></span>'+
				'	<ul id="'+group_id+'" style="display:none; cursor: pointer;"></ul>'+
				'</li>'
			));		
			
		});
		$('#browser').append($(
				'<li>'+
				'	<span style="cursor: pointer;"><strong>상황도</strong></span>'+
				'	<ul id="기타"></ul>'+
				'</li>'
		));	
		
		var list_layer = top.getLayerInfo();
		
		$.each(list_layer, function(){
			var group_id = this['gru_kor'];
			var lary_enm = this['lay_eng'];

			var isVisible = top.XDOCX.XDLayGetVisible(lary_enm);
			var isEditable = top.XDOCX.XDLayGetEditable() == lary_enm;
			

			
			$('#'+group_id).append($(
					'	<li  style="width: 80%;" layer="'+this['lay_eng']+'" onclick="selectLayer(\''+this['lay_eng']+'\')" style="cursor:pointer">'+
		 			'		<span style="width: 150px;" style="cursor: pointer;">'+this['lay_kor']+'</span>' +
		 			'		<span>' +
					'			<img src="./images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16" onclick="setLayerVisible(this, \''+this['lay_eng']+'\');">'+
					
					'		</span>'+
					'	</li>'
				));
		});
				
		//트리구조
		var arr_ext_layer = top.getExtLayerInfo();
		$.each(arr_ext_layer, function(){
			var layer =  this.split('#');
			var layerName = layer[0];
			var layerEng = layer[1];
			var isVisible = top.XDOCX.XDLayGetVisible(layerEng);
			var isEditable = top.XDOCX.XDLayGetEditable() == layerEng;

			//트리구조
			$('#기타').append($(
				'	<li style="width: 100%;" layer="'+layerEng+'" onclick="selectLayer(\''+layerEng+'\')" class="layer">'+
				'		<span style="width: 130px;" style="cursor: pointer;">'+ layerName +'</span>' +
				'		<span>'+
				'			<img src="./images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16" onclick="setLayerVisible(this, \''+layerEng+'\');" style="cursor: pointer;">' +
				//'			<input type="radio" name="layer_editable" '+(isEditable ? 'checked="checked"' : '')+' style="width: 16px; height: 16px;" style="cursor: pointer;" onclick="setLayerEditable(\''+layerEng+'\')" />' +
				'		</span>'+
				'	</li>'
			));
		});
		

	});
	function setLayerEditable(layer_name){
		parent.setEditSaveLayer(layer_name);
		top.setXDEditLayer(layer_name);
		top.setXDLayerSetEditable();
//	 	top.XDOCX.XDLaySetEditable(layer_name);
	}
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
	
	function visible(val){
		if($("#"+val).css("display") == "none"){
		    $("#"+val).show();
		} else {
		    $("#"+val).hide();
		}
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
     	<div id="layer_panel"  style="width:282px; height:400px; overflow-y:scroll; ">
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
