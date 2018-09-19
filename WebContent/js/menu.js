// 탭메뉴
function showHistory(viewObj,chkNum,onImg) {//보일Obj ID/Obj 갯수/
	if(viewObj!=null) {//선택 레이어 보임
		document.getElementById(viewObj).style.display="block";
		if((chkNum!=null) && (!isNaN(chkNum))) {//대신 숨길 레이어가 있다면 숨김
			var hideObj = new String;
			var selObjNum = parseInt(viewObj.substring(viewObj.length-1,viewObj.length));
			hideObj = viewObj.substr(0,viewObj.length-1);

			for(var i=1;i<=chkNum;i++)	{
				if(i!=selObjNum)	{
					hideObj = hideObj.concat(i);
					document.getElementById(hideObj).style.display="none";
					hideObj = viewObj.substr(0,viewObj.length-1);
				}
			}
			
			if (onImg!=null) {//마우스over/out시 이미지on/of 수정
				document.getElementById(onImg).src = document.getElementById(onImg).src.replace("off.gif", "on.gif");
				var offImg	= new String;
				var selImgNum = parseInt(onImg.substring(onImg.length-1,onImg.length));
				offImg = onImg.substr(0,onImg.length-1);

				for(var i=1;i<=chkNum;i++)	{
					if(i!=selImgNum)	{
						offImg = offImg.concat(i);
						document.getElementById(offImg).src = document.getElementById(offImg).src.replace("on.gif", "off.gif");
						offImg = onImg.substr(0,onImg.length-1);
					}
				}
			}
		}
	}
}