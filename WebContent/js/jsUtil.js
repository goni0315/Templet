
function punChange(value){
	var i = value.length;
	if(i == 1){
		value = '000'+value;
	}else if(i == 2){
		value = '00'+value;
	}else if(i == 3){
		value = '0'+value;
	}else{
		
	}
	return value;
}