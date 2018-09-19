/**
 * 클라이언트(테스트시스템)의 공통함수모음
 */
/**
 * 설명 : 버튼을 만드는 함수. 
 * 파라미터 : btnId, btnValue, clickEventFunction,... 
 */
function makeButton(){
		for (var i = 0; i < arguments.length; i = i + 3) {
		var btn = document.createElement("input");
		btn.type = "button";
		if(typeof(arguments[i+1]) == 'string'){
			btn.value = arguments[i+1];	
		}else{
			alert(arguments[i+1]+","+arguments[i+2]+","+arguments[i]);
			alert('value에 string을 입력하시오.');
			continue;
		}
		if(typeof(arguments[i+2])=='function'){
			btn.onclick = arguments[i+2];
		}else{
			alert(typeof(arguments[i+2]));
			alert("onclick이벤트에 함수를 입력하시오.");
			continue;
		}
		if(typeof(arguments[i])=='string'){
			btn.id = arguments[i];
			btn.name = arguments[i];
		}else{
			alert('id에 string을 입력하시오.');
			continue;
		}
		document.getElementById("bottom_menu").appendChild(btn);
	}
}
//60진법 -> 10진법
function convertLonLat(degree, min, sec){
	var cord;
	cord=new Number(degree)+(new Number(min)/60)+(new Number(sec)/3600);
	return cord;
}
function makeOption(selectBox,value,name){
	var select=selectBox;
	var optCount=select.options.length;
	select.options[optCount]=new Option(name,value);
}
function mapDivHandle(){
	var mapDiv = document.getElementById("maparea");
	mapDiv.style.width = document.documentElement.clientWidth;
	mapDiv.style.height = document.documentElement.clientHeight;
}


//페이지내에 html 생성
function infoInit(val){
	var map = document.getElementById("bottom_menu");
	map.innerHTML = val;
}


function jsonCallBack(){
	var jarr = json.parse("./js/statics.json");
	alert(jarr);
}


// 중복제거 함수
Array.prototype.unique=function() {
     var a={};
     for(var h=0;h<this.length;h++){
      if(typeof a[this[h]] == "undefined") a[this[h]] = 1;
     }
     this.length = 0;
     for(var i in a)
      this[this.length] = i;
     return this;
}


/**
 * 천단위 콤마 생성
 *
 * @param value
 * @return
 */
function comma(value, sosu) {
	var point = "";
	var returnValue = "";

	value = value.toString();

	if (value.indexOf(".") > 0) {
		point = value.substring(value.indexOf("."), sosu ? value.indexOf(".") + sosu + 1 : value.length);
		value = value.substring(0,value.indexOf("."));
	}

	if (value.length > 3) {
		for (z = 0; z <= value.length; z++) {
			if( ((z) % 3 == 0) && (z) != value.length &&  z != 0 ) {
				returnValue =  ","+ value.charAt( value.length - (z) )+ returnValue;
			} else {
				returnValue =  value.charAt( value.length - (z) ) + returnValue;
			}
		}
		return returnValue + point;
	}

	return value + point;
}