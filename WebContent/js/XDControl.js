function loaddisplay(){
	loding();
}

function layerlist(){

		var listArray = new Array();


		
		$.getJSON("layer.json", function(data,status) {
			//$('#pnlDisplay').empty(); // 패널(div)의 내용 초기화
			 
			$.each(data, function(i, n) {
				listArray[i] = n.LARY_CLS;
			
			});
		});

		var grouplist = listArray.unique();
		 $.each(grouplist, function(i, n){
			$('#tree').append($(
				'<li><strong>'+grouplist[i]+'</strong><ul id="'+grouplist[i]+'"></ul></li>'
				
			));
			
		 });

			$('#tree').append($(
				'<li><strong>기타</strong><ul id="기타"></ul></li>'
				
			));
		 

		$.getJSON("layer.json", function(data,status) {
			//$('#pnlDisplay').empty(); // 패널(div)의 내용 초기화
			$.each(data, function(i, n) {
				var isVisible = XDOCX.XDLayGetVisible(n.LARY_ENM);
				var isEditable = XDOCX.XDLayGetEditable() == n.LARY_ENM;

				$('#'+n.LARY_CLS).append($(
					'<li class="layer" layer="'+n.LARY_ENM+'" ><span style="width:100px; cursor:pointer;" onclick="selectLayer(\''+n.LARY_ENM+'\')">'+n.LARY_NM
					+'</span><span><img src="./images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16"' 
					+'onclick="setLayerVisible(this, \''+n.LARY_ENM+'\');"/></span></li>'
				));
			
			});
		});

}



/**
 * 3D 엔진 프레임워크
 * 
 * 초기화 작업 및 이벤트 핸들러 작업 외 사용금지
 */

// var WEB_SERVER_URL = 'http://59.25.182.202:8080';
//var WEB_SERVER_URL = 'http://gis.suncheon.go.kr';
//var WEB_SERVER_URL = 'http://59.25.182.187:8080';
var WEB_SERVER_URL = 'http://localhost:8080/Templet/';

var m_tmpLayer = "Temporary"; // 임시 레이어명
var m_workPath = "c:\\xdcashe\\";
var m_layerPath = m_workPath + "kopss\\layer\\";

var m_simulMode = 0;          // 3D 시뮬레이션 종류 구분
var m_JomangSpeed = 300;      // 조망시뮬레이션 관련

var arrLayerInfo;	// 레이어 정보 배열

var _layer_info = []; // 레이어 정보
var _test = []; // 테스트 후 삭제
var _second_level = []; // 테스트 후 삭제

var _ext_layer_info = []; // 추가된 레이어 정보
var edit_layer;

var _map_type = '3D';
/**
 * extend 레이어 추가
 * 
 * @param lyr_name
 */
function appendExtLayerInfo(lyr_name){
	var isExist = false;
	
	$.each(_ext_layer_info, function(){
		if(this == lyr_name){
			isExist = true;
		}
	});
	
	if(!isExist){
		_ext_layer_info.push(lyr_name);
		return true;
	}else{
		return false;
	}
}



/**
 * extend 레이어 삭제
 * 
 * @param lyr_name
 */
function deleteExtLayerInfo(lyr_name){
	var temp_arr = [];
	
	$.each(_ext_layer_info, function(){
		if(this != lyr_name){
			temp_arr.push(this);
		}
	});
	
	_ext_layer_info = temp_arr;
	
	return _ext_layer_info;
}

/**
 * extend 레이어 목록 반환
 */
function getExtLayerInfo(){
	return _ext_layer_info;
}

/**
 * 레이어 정보 설정
 * @returns
 */
function setLayerInfo(info){
	_layer_info = info;
}

//function setTest(info){//테스트 후 삭제
//	_test = info;
//}

function setSecondLevel(info){
	_second_level = info;
}

function getSecondLevel(option){
	var list_second_level = null;
	
	if(option){
		if(option['lary_cls']){
			list_second_level = new Array();
			
			$.each(_second_level, function(){
				if(this['lary_cls'] == option['lary_cls']){
					list_second_level.push(this);
				}
			});
		}
	}else{
		list_second_level = _second_level;
	}
	
	return list_second_level;
}

/**
 * 레이어 영어 이름으로 레이어정보 찾기
 */
function getLayerInfoByEName(layer_name, option){
	if(layer_name){
		var layer_info = null;
		
		for(var i = 0; i < _layer_info.length; i++){
			var item = _layer_info[i];
			
			if(item['lary_enm'] == layer_name){
				if(option){
					if(option['lary_cls'] && option['lary_cls'] != item['lary_cls']){
						return null;
					}
				}
				
				layer_info = item;
				break;
			}
		}
		
		return layer_info;
	}else{
		return null;
	}
}

/**
 * 레이어 정보 반환
 * @returns
 */
function getLayerInfo(option){
	

	var list_layer = null;
	
	if(option){
		if(option['gru_kor']){ // 유형
			list_layer = new Array();
			
			$.each(_layer_info, function(){
				if(this['gru_kor'] == option['gru_kor']){
					list_layer.push(this);
				}
			});
		}
		

	}else{
		list_layer = _layer_info;
	}
	
	return list_layer;
}

/**
 * 레이어 유형 목록 반환
 */
function getLayerClassList(){
	var list_class = new Array();
	
	$.each(_layer_info, function(){
		var lary_cls = this['gru_kor'];
		
		var isExist = false;
		
		for(var i = 0; i < list_class.length; i++){
			var layer = list_class[i];
			
			if(layer['gru_kor'] == lary_cls){
				isExist = true;
				break;
			}
		}
		
		if(!isExist){
			list_class.push(this);
		}
	});
	
	return list_class;
}

// 3차원작업모드
var XDMouseState = {
	MML_NONE : 0, // 동작없음
	MML_MOVE_GRAB : 1, // 지도이동
	MML_ZOOMIN_RECT : 2, // 영역확대
	MML_ZOOMIN_POINT : 3, // 지점확대
	MML_ZOOMOUT_RECT : 4, // 영역축소
	MML_ZOOMOUT_POINT : 5, // 지점축소
	MML_SELECT_POINT : 6, // 지점선택
	MML_SELECT_FACE : 7, // 면선택
	MML_SCREEN_RECT : 8, // 화면영역
	MML_SELECT_RECT : 9, // 지도사각
	MML_SELECT_CIRCLE : 10, // 원영역 선택
	MML_SELECT_POLY : 11, // 폴리곤 영역 선택

	MML_INPUT_POINT : 20, // 입력점1개
	MML_INPUT_LINE : 21, // 라인 형식
	MML_INPUT_RECT : 22, // 사각형 형식
	MML_INPUT_CIRCLE : 23, // 원 형식 입력
	MML_INPUT_AREA : 24, // 영역 형태로 입력
	MML_INPUT_SPHERE : 25, // 구 형태로 입력

	MML_OBJECT_INSERT : 40, // 객체 삽입
	MML_OBJECT_MOVE_XZ : 41, // 수평 이동
	MML_OBJECT_MOVE_YZ : 42, // 수직 이동
	MML_OBJECT_ROTATE : 43, // 객체 회전
	MML_OBJECT_SCALE : 44, // 객체 크기
	MML_OBJECT_SCALE_Y : 45, // 높이 수정
	MML_OBJECT_SCALE_XZ : 46, // 수평 크기

	MML_DRAW_CUBE : 50, // 박스 입력
	MML_DRAW_CYLINDER : 51, // 원통 입력
	MML_DRAW_SPHERE : 52, // 구 입력
	MML_DRAW_CON : 53, // 꼬깔 입력
	MML_DRAW_PIPE : 54, // 파이프 입력
	MML_DRAW_DOME : 55, // 돔 입력
	MML_DRAW_POLYHEAD : 56, // 폴리헤드론
	MML_DRAW_ARROW : 57, // 화살표 입력

	MML_ANALYS_AREA : 80, // 면적 계산
	MML_ANALYS_DISTANCE : 81, // 거리 계산
	MML_ANALYS_VIEWSHED : 82, // 가시권 분석

	MML_UI_MEMO : 90, // 메모 기능
	ANALYS_JOMANGPOINT : 94 // 조망점입력
};// End of XDMouseState

/**
 * 3D 엔진
 */
function xdk() { 
	// 4.0
	document.write('<object id="XDOCX" width="100%" height="99%" classid="clsid:FFEF80F2-03D0-4F77-BB42-4D3CD0F3C9CB" codebase="./cab/xdworldv4.cab#version=4,0,0,69"><embed width="100%" height="100%"></embed></object>');
}

var NaviMode = {
	NAVI_FLY : 0,
	NAVI_WALK : 1
};

var m_jomangFlag = '';
setJomangFlag = function(pnu) {
	m_jomangFlag = pnu;
}

getJomangFlag = function() {
	return m_jomangFlag;
}

/** ******************** S 설정 관련 함수 *************************** */
var m_ref_alp = 255;
var m_ref_red = 255;
var m_ref_grn = 255;
var m_ref_blu = 255;	
TmpRefColor = function(pA, pR, pG, pB) {
	XDOCX.XDRefSetColor(pA, pR, pG, pB);
}
GetRefColor = function() {
	TmpRefColor(m_ref_alp, m_ref_red, m_ref_grn, m_ref_blu);
}
SetRefColor = function(pA, pR, pG, pB) {
	m_ref_alp = pA;
	m_ref_red = pR;
	m_ref_grn = pG;
	m_ref_blu = pB;
	
	TmpRefColor(m_ref_alp, m_ref_red, m_ref_grn, m_ref_blu);
}	
GetStrColor = function() {
	return m_ref_alp+","+m_ref_red+","+m_ref_grn+","+m_ref_blu;
}
/**
 * 칼라값 설정
 * 
 * @param pA
 * @param pR
 * @param pG
 * @param pB
 */
function setXDRefColor(pA, pR, pG, pB) {
	XDOCX.XDRefSetColor(pA, pR, pG, pB);
}

/**
 * 오브젝트 칼라 설정
 * 
 * @param layerName
 * @param id
 */
function setXDColor(layerName, id) {
	XDOCX.XDObjSetColor(layerName, id);
}

/**
 * 포인트 입력
 * 
 * @param x
 * @param y
 * @param z
 */
function setXDRefPos(x, y, z) {
	XDOCX.XDRefSetPos(x, y, z);
}

/**
 * 설정값 초기화
 */
function initXDRefValue() {
	XDOCX.XDRefSetColor(255, 0, 0, 0);
}
/** ******************** E 설정 관련 함수 *************************** */

/**
 * XDServer connect 프로그램 로드시 자동 실행됨.
 */
function xdServerConnect(ip, port, group, start_xpoint, start_ypoint) {
	var m_IsConnected = XDOCX.XDNetServerConnect(ip, port);
	switch (m_IsConnected) {
	case 0:
		alert("서버 연결에 실패하였습니다.\n관리자에게 문의하세요.");
		break;
	case 2:
		alert("이미 접속중입니다.");
		break;
	case 1:
		XDOCX.XDNetLayerListRequest("TEST", 0); // 맵 레이어 데이터 요청 (저해상도)
		//layerlist();
		XDOCX.XDMapRenderLock(true);
		XDOCX.XDCameraViewSetVisible(true);
		XDOCX.XDSetUnderGround(true);
		XDOCX.XDCtrlSetView(2); // 3D인덱스맵 종료
		XDOCX.XDMapRenderLock(false);
		XDOCX.XDWebFileDownload(WEB_SERVER_URL + "/images/pointer.png", m_workPath+"pointer.png");
		XDOCX.XDMapLoad();
		XDOCX.XDMapResetRTT();
		XDOCX.XDMapRender();
		
		break;
	}
}

function downSymbols(){
	var url = WEB_SERVER_URL + "/symbols/";
	
	var path = m_workPath + "kopss\\";
	
	XDOCX.XDWebFileDownload(url + "BASE.xdi", path + "BASE.xdi");
	XDOCX.XDWebFileDownload(url + "BASE.xdl", path + "BASE.xdl");
	XDOCX.XDWebFileDownload(url + "BASE.xdw", path + "BASE.xdw");
	
	XDOCX.XDWebFileDownload(url + "img/base.jpg", path + "base.jpg");
	XDOCX.XDWebFileDownload(url + "img/slop.jpg", path + "slop.jpg");
	
	XDOCX.XDWebFileDownload(url + "search.png", m_workPath+"search.png");
}

function downLib(){
	var url = WEB_SERVER_URL + "/symbol/lib/";
	var path = m_workPath + "/lib/";
	//XDOCX.XDWebFileDownload(url + "BASE.xdi", path + "BASE.xdi");
}

/**
 * 마우스 작업 모드 설정
 * 
 * @param mode
 * @param analysis_mode
 */
function setXDMouseMode(mode) {
	if (XDOCX.XDUIGetWorkMode() != mode) {
		XDOCX.XDUISetWorkMode(mode);

		//XDOCX.XDSelClear();
		//XDOCX.XDMapRender();
	}
}

/**
 * 맵 초기화
 */
function mapXDInit() {
	XDOCX.XDMapRenderLock(true);
	XDOCX.XDMapClearTempLayer();
	XDOCX.XDUIClearInputPoint();
	XDOCX.XDAnsClear();
	XDOCX.XDSelClear();
	XDOCX.XDUIDistanceClear();
	XDOCX.XDUIAreaClear();
	XDOCX.XDUIClearMemo();
	// XDOCX.XDObjDelete("search", "search");
	XDOCX.XDLayClear('RADIUS_SEARCH');

	// XDOCX.XDLayClear(top.getMLayer());
	// XDOCX.XDLayClear(top.getMLayer2());
	// initXDWorkMode(); //없음
	// initXDWorkMode();
	XDOCX.XDMapRenderLock(false);
	XDOCX.XDMapLoad();
	XDOCX.XDMapRender();
	XDOCX.XDMapResetRTT();
}

/**
 * 맵타입 설정
 * 
 * @param type
 */
function setMapType(type){
	_map_type = type;
}

/**
 * 맵타입 반환
 * 
 * @param type
 */
function getMapType(){
	return _map_type;
}

/**
 * 임시레이어 반환
 */
function getXDTmpLayer() {
	return m_tmpLayer;
}

/**
 * 편집레이어 변경
 * @param edit_layer
 */
function setXDEditLayer(edit_layer) {
	m_tmpLayer = edit_layer;
}

/**
 * 편집레이어 설정
 */
function setXDLayerSetEditable(){
	XDOCX.XDLayerSetEditable(m_tmpLayer);
	return m_tmpLayer;
}

/**
 * 작업 공간 경로 반환(클라이언트)
 */
function getXDWorkPath() {
	return m_workPath;
}

/**
 * 레이어 존재 여부 반환
 * 
 * @param value
 * @returns {Boolean}
 */
function existXDLayer(value) {
	var ex = true;
	if (XDOCX.XDLayGetType(value) < 0) {
		ex = false;
	}
	return ex;
}

/**
 * 객체 존재 여부 반환
 * 
 * @param value
 * @returns {Boolean}
 */
function existXDObject(layer, key) {
	for (var i = 0; i < XDOCX.XDLayGetObjectCount(layer); i++){
		if (XDOCX.XDLayGetObjectKey(layer, i) == key){
		    return true;
		}
	}
    return false;
}

/**
 * 레이어 생성
 * @param layer_name
 * @param type
 * @param hidden
 * @param isVisible
 * @param isSelectable
 * @returns
 */
function createXDLayer(layer_name, type, hidden, isVisible, isSelectable) {
	if (existXDLayer(layer_name)) {
		XDOCX.XDLayRemove(layer_name);
	}

	var rs = XDOCX.XDLayCreate(type, layer_name);
	XDOCX.XDLaySetVisible(layer_name, isVisible);
	XDOCX.XDLaySetSelectable(layer_name, isSelectable);
	XDOCX.XDLaySetHiddenValue(layer_name, 1, hidden);
	XDOCX.XDMapRender();

	return rs;
}

/**
 * 좌표로 위치 찾아가기
 * @param posX
 * @param posZ
 * @param symbol_height
 * @param name
 * @param viewLevel
 * @param angle
 */
function searchXDPointPosition(posX, posZ, symbol_height, name, viewLevel, angle, tmpLayer, clear) {
	// 3D 이동
	var posY = XDOCX.XDTerrGetPointHeight(posX, posZ);

	XDOCX.XDLaySetEditable(tmpLayer ? tmpLayer : getXDTmpLayer());
	if(clear ? !clear : true){
		XDOCX.XDLayClear(tmpLayer ? tmpLayer : getXDTmpLayer());
	}
	XDOCX.XDRefSetPos(posX, posY + (symbol_height ? symbol_height : 0), posZ);
	XDOCX.XDRefSetColor(255, 255, 0, 0);
	XDOCX.XDObjCreateText(tmpLayer ? tmpLayer : getXDTmpLayer(), name ? name : ' ', getXDWorkPath()
			+ "search.png");

	// XDOCX.XDCamNorthDirect(); //정북으로
	// [S] 순간이동 위치이동
	// XDOCX.XDCamSetLookAt(posX, posY, posZ, viewLevel ? viewLevel : 400, angle
	// ? angle : 25);
	// [E] 순간이동 위치이동

	// [S] 3차원 위치이동
	XDOCX.XDCarmeraSetYAngle(angle ? angle : 25);
	XDOCX.XDCarmeraMoveOval(posX, posY, posZ, 5);
	XDOCX.XDCamSetDistance(viewLevel ? viewLevel : 400);
	// [E] 3차원위치이동
	XDOCX.XDMapLoad();
	XDOCX.XDMapRender();
}

// GUBN_MID, ENGNAME, KORNAME, FIRSTVISIBLE, FIRSTSELECT, SHOWLAYERLIST, RED, GREEN, BLUE
// 중간구분자, 한글명, 영어명, 보기, 선택, 리스트보기
function setArrLayer() {
	var value = "건물,10단지_현재,10단지,1,1,1,-1,-1,-1|건물,12단지_현재,12단지,1,1,1,-1,-1,-1|건물,1단지_현재,1단지,1,1,1,-1,-1,-1|건물,2단지_현재,2단지,1,1,1,-1,-1,-1|건물,4단지_현재,4단지,1,1,1,-1,-1,-1|건물,5단지_현재,5단지,1,1,1,-1,-1,-1|건물,6단지_현재,6단지,1,1,1,-1,-1,-1|건물,7단지_현재,7단지,1,1,1,-1,-1,-1|건물,8단지_현재,8단지,1,1,1,-1,-1,-1|용도지역,LT_C_UD620,보금자리주택,0,0,1,-1,-1,-1|용도지역,LT_C_UD620_L,보금자리주택,0,0,0,-1,-1,-1|용도지역,LT_C_UD801,개발제한구역,0,0,1,-1,-1,-1|용도지역,LT_C_UD801_L,개발제한구역,0,0,0,-1,-1,-1|용도지역,LT_C_UD901,도시개발구역,0,0,1,-1,-1,-1|용도지역,LT_C_UD901_L,도시개발구역,0,0,0,-1,-1,-1|용도지역,LT_C_UM221,야생동식물보호구역,0,0,1,-1,-1,-1|용도지역,LT_C_UM221_L,야생동식물보호구역,0,0,0,-1,-1,-1|용도지역,LT_C_UN501,군사보호구역,0,0,1,-1,-1,-1|용도지역,LT_C_UN501_L,군사보호구역,0,0,0,-1,-1,-1|용도지역,LT_C_UO101_UOA110,절대정화구역,0,0,1,-1,-1,-1|용도지역,LT_C_UO101_UOA110_L,절대정화구역,0,0,1,-1,-1,-1|용도지역,LT_C_UO101_UOA120,상대정화구역,0,0,1,-1,-1,-1|용도지역,LT_C_UO101_UOA120_L,상대정화구역,0,0,1,-1,-1,-1|용도지역,LT_C_UO301,문화재보호구역,0,0,1,-1,-1,-1|용도지역,LT_C_UO301_L,문화재보호구역,0,0,0,-1,-1,-1|용도지역,LT_C_UO501,전통사찰보존구역,0,0,1,-1,-1,-1|용도지역,LT_C_UO501_L,전통사찰보존구역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ111_UQA111,제1종전용주거지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA111_L,제1종전용주거지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ111_UQA112,제2종전용주거지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA112_L,제2종전용주거지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ111_UQA121,제1종일반주거지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA121_L,제1종일반주거지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ111_UQA122,제2종일반주거지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA122_L,제2종일반주거지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ111_UQA123,제3종일반주거지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA123_L,제3종일반주거지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ111_UQA220,일반상업지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA220_L,일반상업지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA430,자연녹지지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ111_UQA430_L,자연녹지지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ122,미관지구,0,0,1,-1,-1,-1|용도지역,LT_C_UQ122_L,미관지구,0,0,0,-1,-1,-1|용도지역,LT_C_UQ123,고도지구,0,0,1,-1,-1,-1|용도지역,LT_C_UQ123_L,고도지구,0,0,0,-1,-1,-1|용도지역,LT_C_UQ128,취락지구,0,0,1,-1,-1,-1|용도지역,LT_C_UQ128_L,취락지구,0,0,0,-1,-1,-1|용도지역,LT_C_UQ141_UQQ310,제1종지구단위계획구역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ141_UQQ310_L,제1종지구단위계획구역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ141_UQQ600,토지거래계약에관한허가구역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ141_UQQ600_L,토지거래계약에관한허가구역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ141_UQQ900,개발행위허가제한지역,0,0,1,-1,-1,-1|용도지역,LT_C_UQ141_UQQ900_L,개발행위허가제한지역,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS100,도로,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS100_L,도로,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS106,지하도로,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS106_L,지하도로,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS111,광로1류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS111_L,광로1류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS112,광로2류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS112_L,광로2류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS115,대로2류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS115_L,대로2류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS116,대로3류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS116_L,대로3류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS117,중로1류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS117_L,중로1류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS118,중로2류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS118_L,중로2류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS119,중로3류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS119_L,중로3류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS120,소로1류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS120_L,소로1류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS121,소로2류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS121_L,소로2류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS122,소로3류,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS122_L,소로3류,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS200,주차장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS200_L,주차장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS210,노외주차장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS210_L,노외주차장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ161_UQS520,도시철도,0,0,1,-1,-1,-1|용도지역,LT_C_UQ161_UQS520_L,도시철도,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT110,교통광장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT110_L,교통광장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT111,교차점광장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT111_L,교차점광장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT120,일반광장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT120_L,일반광장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT130,경관광장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT130_L,경관광장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT200,공원,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT200_L,공원,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT210,어린이공원,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT210_L,어린이공원,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT220,근린공원,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT220_L,근린공원,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT230,도시자연공원,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT230_L,도시자연공원,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT250,체육공원,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT250_L,체육공원,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT290,기타공원시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT290_L,기타공원시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT310,완충녹지,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT310_L,완충녹지,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT320,경관녹지,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT320_L,경관녹지,0,0,0,-1,-1,-1|용도지역,LT_C_UQ162_UQT500,공공공지,0,0,1,-1,-1,-1|용도지역,LT_C_UQ162_UQT500_L,공공공지,0,0,0,-1,-1,-1|용도지역,LT_C_UQ163_UQU100,시장,0,0,1,-1,-1,-1|용도지역,LT_C_UQ163_UQU100_L,시장,0,0,0,-1,-1,-1|용도지역,LT_C_UQ163_UQU200,유통업무설비,0,0,1,-1,-1,-1|용도지역,LT_C_UQ163_UQU200_L,유통업무설비,0,0,0,-1,-1,-1|용도지역,LT_C_UQ163_UQU300,수도공급시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ163_UQU300_L,수도공급시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ163_UQU330,정수시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ163_UQU330_L,정수시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ163_UQU500,전기공급설비,0,0,1,-1,-1,-1|용도지역,LT_C_UQ163_UQU500_L,전기공급설비,0,0,0,-1,-1,-1|용도지역,LT_C_UQ163_UQU800,유류저장및송유설비,0,0,1,-1,-1,-1|용도지역,LT_C_UQ163_UQU800_L,유류저장및송유설비,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV200,공공청사,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV200_L,공공청사,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV300,학교,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV300_L,학교,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV320,초등학교,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV320_L,초등학교,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV330,중학교,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV330_L,중학교,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV340,고등학교,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV340_L,고등학교,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV400,도서관,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV400_L,도서관,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV500,연구시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV500_L,연구시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV600,문화시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV600_L,문화시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV660,과학관,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV660_L,과학관,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV700,사회복지시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV700_L,사회복지시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV800,체육시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV800_L,체육시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ164_UQV910,청소년수련시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ164_UQV910_L,청소년수련시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ165,하천,0,0,1,-1,-1,-1|용도지역,LT_C_UQ165_L,하천,0,0,0,-1,-1,-1|용도지역,LT_C_UQ167_UQY110,하수도,0,0,1,-1,-1,-1|용도지역,LT_C_UQ167_UQY110_L,하수도,0,0,0,-1,-1,-1|용도지역,LT_C_UQ167_UQY120,하수종말처리시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ167_UQY120_L,하수종말처리시설,0,0,0,-1,-1,-1|용도지역,LT_C_UQ167_UQY200,폐기물처리시설,0,0,1,-1,-1,-1|용도지역,LT_C_UQ167_UQY200_L,폐기물처리시설,0,0,0,-1,-1,-1|용도지역,LT_C_ZH002,문화재보존영향검토대상지역,0,0,1,-1,-1,-1|용도지역,LT_C_ZH002_L,문화재보존영향검토대상지역,0,0,0,-1,-1,-1|지형,terrain,지형_과천,1,0,1,-1,-1,-1|도로,가로등,가로등,1,0,1,-1,-1,-1|도로,가로수,가로수,0,0,1,-1,-1,-1|도로,교통신호등,교통신호등,1,0,1,-1,-1,-1|도로,도로표지판,도로표지판,1,0,1,-1,-1,-1|도로,방호벽,방호벽,1,0,1,-1,-1,-1|도로,송전탑,송전탑,1,0,1,-1,-1,-1|도로,전주,전주,1,0,1,-1,-1,-1|도로,택시정류장표지판,택시정류장,1,0,1,-1,-1,-1|도로,버스정류장표지판,버스정류장,1,0,1,-1,-1,-1|도로,보행자신호등,보행자신호등,1,0,1,-1,-1,-1|건물,공공기관,공공기관,1,1,1,-1,-1,-1|건물,공동주택,공동주택,1,1,1,-1,-1,-1|건물,교량최종,교량,1,1,1,-1,-1,-1|건물,교회건물,교회,1,1,1,-1,-1,-1|건물,기타시설,기타시설,1,1,1,-1,-1,-1|건물,문원2단지,문원,1,1,1,-1,-1,-1|건물,문화교육시설,문화교육시설,1,1,1,-1,-1,-1|건물,산업시설,산업시설,1,1,1,-1,-1,-1|건물,서비스시설,서비스시설,1,1,1,-1,-1,-1|건물,의료복지시설,의료복지시설,1,1,1,-1,-1,-1|건물,일반주택,일반주택,1,1,1,-1,-1,-1|건물,특수시설,특수시설,1,1,1,-1,-1,-1" 
	arrLayerInfo = value.split("|");
}

getLayerListArray = function() {
	return arrLayerInfo;
}

getArrLayerName = function(value, isEtoK) { // 변환레이어명 반환(영문명 --> 한글명)
	var i;
	var len;
	var tmplName;

	len = arrLayerInfo.length;

	for (i = 0; i < len; i++) {
		tmplName = (arrLayerInfo[i]).split(",");

		if (isEtoK == true) {
			if (tmplName[1] == value) {
				return tmplName[2];
			}
		} else {
			if (tmplName[2] == value) {
				return tmplName[1];
			}
		}
	}

	return value;
}

getArrLayerInfo = function(value, isEng) { // 변환레이어명 반환(영문명 --> 한글명)
	
	var i;
	var len;
	var tmplName;

	len = arrLayerInfo.length;
	
	for (i = 0; i < len; i++) {
		tmplName = (arrLayerInfo[i]).split(",");

		if (isEng == false) {
			if (tmplName[2] == value) {
				return arrLayerInfo[i];
			}
		} else {
			if (tmplName[1] == value) {
				return arrLayerInfo[i];
			}
		}
	}

	return "";
}

var m_workMode = "";

function setWorkMode(mode){
	m_workMode = mode;
}

function getWorkMode(){
	return m_workMode;
}

setWorkPath = function(value){
	m_workPath = value;
}
getWorkPath = function() {
    return m_workPath;
}

//시뮬모드
setSimulMode = function(value) {
	m_simulMode = value;
}

getSimulMode = function() {
    return m_simulMode;
}

//조망스피드 설정	
setJomangSpeed = function(value) {
	m_JomangSpeed = value;
}

getJomangSpeed = function() {
	return m_JomangSpeed;
}

var clickCnt = 0;   // 화면 클릭 횟수 (최단경로, 조망권, 가시권 분석에서 사용)

function bExistObjectInLayer(strLayName, strObjId)
{ 
    for (var i = 0; i < XDOCX.XDLayGetObjectCount(strLayName); i++)
    {
        if (XDOCX.XDLayGetObjectKey(strLayName, i) == strObjId)
        {
            return true;
        }
    }
    return false;
}

var m_objCopy = "";

function setObjCopy(objkey){
	m_objCopy = objkey;
}

function getObjCopy(){
	return m_objCopy;
}


/** ******************** S 이벤트 핸들러 *********************** */

/**
 * 마우스다운 이벤트 핸들러
 */
function MouseDownEventHandler(button, shift, posX, posY) {
	var wrkstate = XDOCX.XDUIGetWorkMode();
	var xdpos = XDOCX.XDUIClickPos();
	pos = xdpos.split(",");
	switch(wrkstate)
	{
		case XDMouseState.MML_NONE :				// 0
			break;
		case XDMouseState.MML_MOVE_GRAB :			// 1
			break;
		case XDMouseState.MML_ZOOMIN_RECT :		// 2
			break;
		case XDMouseState.MML_ZOOMIN_POINT :		// 3
			break;
		case XDMouseState.MML_ZOOMOUT_RECT :		// 4
			break;
		case XDMouseState.MML_ZOOMOUT_POINT :		// 5
			break;
		case XDMouseState.MML_SELECT_POINT :		// 6	단일선택모드
			break;
		case XDMouseState.MML_SELECT_FACE :		// 7
			break;
		case XDMouseState.MML_SCREEN_RECT :		// 8
			break;
		case XDMouseState.MML_SELECT_RECT :		// 9 
			break;
			
		case XDMouseState.MML_INPUT_POINT :		// 20
			break;
		case XDMouseState.MML_INPUT_LINE :		//21
			break;
		case XDMouseState.MML_INPUT_RECT : 		//22
			break;
		case XDMouseState.MML_INPUT_CIRCLE : 		//23
			break;
		case XDMouseState.MML_INPUT_AREA :		//24
		
			switch(m_workMode)
			{
			case "조망차폐율_대상지":
				if (XDOCX.XDUIInputPointCount() > 2)
                {
					
                    if (button == 2)
                    {
                    	XDOCX.XDObjectCreatePolygon("조망차폐율_대상지", 255, 255, 0, 80, 1);
                        XDOCX.XDUIClearInputPoint();
                        XDOCX.XDUISetWorkMode(1);
                        bCreateLay = true;
                        XDOCX.XDMapRender();
                    }
                }
			break;
			case "영역_대상지":
				left.document.getElementById('pos').value += '#'+pos;
//				for(var i = 0; i < XDOCX.XDUIInputPointCount(); i++){
//					left.document.getElementById('pos').value = pos+'#'; 
//				}
				if(button == 2){
					left.document.getElementById('pos').value = '';
				}
//				alert(pos)
				if (XDOCX.XDUIInputPointCount() > 2)
                {
//					for(var i = 0; i < XDOCX.XDUIInputPointCount(); i++){
//						alert(pos)
//					}
					
//                    if (button == 2)
//                    {
//                    	XDOCX.XDObjectCreatePolygon("영역_대상지", 255, 255, 0, 80, 1);
//                        XDOCX.XDUIClearInputPoint();
//                        XDOCX.XDUISetWorkMode(1);
//                        XDOCX.XDMapRender();
//                    }
                }
			break;
			
			}
			
			break;
		case XDMouseState.MML_INPUT_SPHERE :		//25 
			break;
			
		case XDMouseState.MML_OBJECT_INSERT :		//40
			break;
		case XDMouseState.MML_OBJECT_MOVE_XZ :	//41 
			break;
		case XDMouseState.MML_OBJECT_MOVE_YZ :	//42
			break;
		case XDMouseState.MML_OBJECT_ROTATE :		//43
			break;
		case XDMouseState.MML_OBJECT_SCALE :		//44
			break;
		case XDMouseState.MML_OBJECT_SCALE_Y :	//45
			break;
		case XDMouseState.MML_OBJECT_SCALE_XZ :	//46
			break;
			
		case XDMouseState.MML_DRAW_CUBE :			//50
			break;
		case XDMouseState.MML_DRAW_CYLINDER :		//51
			break;
		case XDMouseState.MML_DRAW_SPHERE :		//52
			break;
		case XDMouseState.MML_DRAW_CON :			//53
			break;
		case XDMouseState.MML_DRAW_PIPE :			//54
			break;
		case XDMouseState.MML_DRAW_DOME :			//55
			break;
		case XDMouseState.MML_DRAW_POLYHEAD :		//56
			break;
		case XDMouseState.MML_DRAW_ARROW :		//57
			break;
			
		case XDMouseState.MML_ANALYS_AREA :		//80
			break;
		case XDMouseState.MML_ANALYS_DISTANCE : 	//81
			break;
		case XDMouseState.MML_ANALYS_VIEWSHED :	//82
			break;
			
		case XDMouseState.MML_UI_MEMO :			//90
			break;
		case XDMouseState.ANALYS_JOMANGPOINT :	//94
			break;
			
		default:
			break;
	}
}

function jsDblclick(){
	var wrkstate = XDOCX.XDUIGetWorkMode(); //마우스 모드 가져오기
}

function MouseUpEventHandler(button, shift, posX, posY) {
	var wrkstate = XDOCX.XDUIGetWorkMode(); // XDSetMouseState함수로 설정한 워크모드 번호를 반환함
	var xdpos = XDOCX.XDUIClickPos();
	pos = xdpos.split(",");

	switch(wrkstate)
	{
		case XDMouseState.MML_NONE :	// 0
			switch(m_workMode)
			{
			
				case "Gs_Start_point":
					XDOCX.XDRefSetColor(255, 255, 0, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDLaySetEditable("Temporary");
//					top.XDOCX.XDLayClear("Temporary");
					Start_point0 = pos[0];
					Start_point1 = pos[1];
					Start_point2 = pos[2];
					if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","분석시점"+Pointcnt)==true){
							XDOCX.XDObjDelete("Temporary","분석시점"+Pointcnt);
						}
					}
					var objkey ="분석시점"+Pointcnt;
					XDOCX.XDObjCreateText(objkey, "분석시점", "");
					m_workMode = "";
					XDOCX.XDUISetWorkMode(1);
				break;
				case "Gs_End_point":
					XDOCX.XDRefSetColor(255, 255, 0, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDLaySetEditable("Temporary");
//					top.XDOCX.XDLayClear("Temporary");
					End_point0 = pos[0];
					End_point1 = pos[1];
					End_point2 = pos[2];
					if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","목표점"+Pointcnt)==true){
							XDOCX.XDObjDelete("Temporary","목표점"+Pointcnt);
						}
					}
					var objkey ="목표점"+Pointcnt;
					XDOCX.XDObjCreateText(objkey, "목표점", "");
					m_workMode = "";
					XDOCX.XDUISetWorkMode(1);
				break;
				case "Gs_Center_point":
					XDOCX.XDRefSetColor(255, 255, 0, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDLaySetEditable("Temporary");
					XDOCX.XDLayClear("Temporary");
					Center_point0 = pos[0];
					Center_point1 = pos[1];
					Center_point2 = pos[2];
					if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","가시권역_중심점"+Pointcnt2)==true){
							XDOCX.XDObjDelete("Temporary","가시권역_중심점"+Pointcnt2);
						}
					}
					var objkey ="가시권역_중심점"+Pointcnt2;
					XDOCX.XDObjCreateText(objkey, "가시권역_중심점","");
					m_workMode = "";
                    XDOCX.XDUISetWorkMode(1);
				break;
				case "WideStart":
					XDOCX.XDRefSetColor(255, 255, 0, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDLaySetEditable("Temporary");
					Start_point0 = pos[0];
					Start_point1 = pos[1];
					Start_point2 = pos[2];
					if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","분석시점")==true){
							XDOCX.XDObjDelete("Temporary","분석시점");
						}
					}
					var objkey ="분석시점";
					XDOCX.XDObjCreateText(objkey, "분석시점", "");
					m_workMode = "";
					XDOCX.XDUISetWorkMode(1);
				break;
				case "WideEnd":
					if ((Start_point0!=null) && (Start_point1!=null) && (Start_point2!=null)) {
				   		
					}else{
						alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
						XDOCX.XDUISetWorkMode(1);
					return;
					}
					XDOCX.XDRefSetColor(255, 255, 0, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDLaySetEditable("Temporary");
					End_point0 = pos[0];
					End_point1 = pos[1];
					End_point2 = pos[2];
					if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","목표점")==true){
							XDOCX.XDObjDelete("Temporary","목표점");
						}
					}
					var objkey ="목표점";
					XDOCX.XDObjCreateText(objkey, "목표점", "");
					m_workMode = "";
					XDOCX.XDUISetWorkMode(1);
				break;
					XDOCX.XDUIClearInputPoint();
		    		XDOCX.XDRefSetColor(255, 255, 0, 0);
		    		XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
		    		XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);	
		    		Start_point0 = pos[0];
		    		Start_point1 = pos[1];
		    		Start_point2 = pos[2];
		    		XDOCX.XDLaySetEditable("Temporary");
		    		if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","조망차폐율_분석시점")==true){
							XDOCX.XDObjDelete("Temporary","조망차폐율_분석시점");
						}
					}
		    		XDOCX.XDObjCreateText('조망차폐율_분석시점', '조망차폐율_분석시점', '');
		    		m_workMode = "";
					XDOCX.XDUISetWorkMode(1);
				break;	
				case "조망차폐율_목표점":
					XDOCX.XDUIClearInputPoint();
					XDOCX.XDRefSetColor(255, 255, 0, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);	
					End_point0 = pos[0];
					End_point1 = pos[1];
					End_point2 = pos[2];
					XDOCX.XDLaySetEditable("Temporary");
					if (XDOCX.XDLayGetObjectCount("Temporary")>0){
						if (bExistObjectInLayer("Temporary","조망차폐율_목표점")==true){
							XDOCX.XDObjDelete("Temporary","조망차폐율_목표점");
						}
					}
					XDOCX.XDObjCreateText('조망차폐율_목표점', '조망차폐율_목표점', '');
					var layer = '조망차폐율';
			        
			        if (XDOCX.XDLayGetHiddenValue(layer) == "") 
			        {
			            XDOCX.XDMapRenderLock(true);
			            XDOCX.XDLayCreate(5, layer);
			            XDOCX.XDMapRenderLock(false);
			            XDOCX.XDLaySetHiddenValue(layer, 1, 100000);
			            XDOCX.XDLaySetEditable(layer);
			        }
			        else 
			        {
				        XDOCX.XDLaySetEditable(layer);	
			        }
			        XDOCX.XDLaySetSelectable(layer, true);

			        XDOCX.XDRefSetColor(255, 255, 0, 0);
			        XDOCX.XDUIInput3DPoint(Start_point0, Start_point1+1, Start_point2);
			        XDOCX.XDUIInput3DPoint(pos[0], pos[1]+1, pos[2]);
			        XDOCX.XDMapRenderLock(true);
			        XDOCX.XDObjCreateLine(layer, 100, false);
			        XDOCX.XDUIClearInputPoint();
			        XDOCX.XDMapRenderLock(false);
					m_workMode = "";
					XDOCX.XDUISetWorkMode(1);
				break;
				case "대상지점":
				case "사업관리_지점_입력":
				case "측정지점입력":
				case "조망점입력_대상지":
				case "조망점입력_조망점":
					exeFunction(pos);
			}
			XDOCX.XDMapRender();
			break;
		case XDMouseState.MML_MOVE_GRAB :			// 1
			break;
		case XDMouseState.MML_ZOOMIN_RECT :		// 2
			break;
		case XDMouseState.MML_ZOOMIN_POINT :		// 3
			break;
		case XDMouseState.MML_ZOOMOUT_RECT :		// 4
			break;
		case XDMouseState.MML_ZOOMOUT_POINT :		// 5
			break;
		case XDMouseState.MML_SELECT_POINT :		// 6	단일선택모드

			if (XDOCX.XDSelGetCount() < 1) return;
            var info = XDOCX.XDSelGetCode(XDOCX.XDSelGetCount() - 1);
			info = info.split("#");
			if (m_workMode == "cal_volume"){
				if (button == 1) {
					var box = XDOCX.XDObjGetBox(info[0], info[1]);
					var xy = box.split(",");
					var volum = (xy[3]-xy[0])*(xy[4]-xy[1])*(xy[5]-xy[2]);
					volum = (Math.round(volum*100)) / 100;

					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDRefSetColor(255, 0, 255, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 128, 128, 128);
					XDOCX.XDObjCreateText(getCurrDate(), volum+" ㎥", "");
					XDOCX.XDSelClear();
					
				}else{

				}
			}else if (m_workMode == "객체선택"){ // 일조권분석 > 선택지점, 주변건물침해 : 객체선택(건물선택)
				setWorkMode('');
				exeFunction();
				return;
			}else if(m_workMode == "오브젝트 삭제"){
				
				if(confirm("정말로 삭제 하시겠습니까?") == true){
					XDOCX.XDObjDelete(info[0], info[1]);
					delTable(info[1]);
					top.XDOCX.XDSetMouseState(1);
				}else{
					top.XDOCX.XDSetMouseState(1);
				}
				
			}
			break;
		case XDMouseState.MML_SELECT_FACE :		// 7
			break;
		case XDMouseState.MML_SCREEN_RECT :		// 8
			break;
		case XDMouseState.MML_SELECT_RECT :		// 9 
			break;
							
		case XDMouseState.MML_INPUT_POINT :		// 20		
			if (m_workMode == "cal_hei"){
				if (button == 1) {
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
					XDOCX.XDRefSetColor(255, 255, 255, 0);
					XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 128, 128, 128);
					XDOCX.XDObjCreateText(getCurrDate(), addComma((Math.round(pos[1]*100)) / 100) + " m", "");
				}else{
					top.setWorkMode('');
				}				
		 	} else if (m_workMode == "obj_paste") {
				var objkey = top.getObjCopy();
				if (objkey != ""){
					var ln = top.XDOCX.XDLayGetEditable();					
					objkey += "_" + getCurrDate();					
					XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);					
					XDOCX.XDObjInsertXDO(objkey, getXDWorkPath() + "objCopy.xdo", 0);
				}
			} else if (m_workMode == "tree_input") {
				if (left.imgPath == null) {
					m_workMode == "";
					return;
				}
				if (left.imgPath == ""){
					alert('가로수를 선택하세요');
					return;
				}
				var objkey = getCurrDate();
				XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
				XDOCX.XDObjCreateBillBoard(objkey, left.tree_width.value, left.tree_hei.value, left.imgPath);
			} else if (m_workMode == "3ds_input") {
				if (left.tdsPath == null) {
					m_workMode == "";
					return;
				}
				if (left.tdsPath == ""){
					alert('라이브러리를 선택하세요');
					return;
				}
				var objkey = getCurrDate();
				XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
				XDOCX.XDObjInsert3DS(objkey, left.tdsPath, 0);
			}
			break;
		case XDMouseState.MML_INPUT_LINE :		//21
			switch(m_workMode)
			{
			case "sikok_size": //시곡면분석
				var m_Ax=0;
				var m_Ay=0;
				var m_Az=0;
				var m_Bx=0;
				var m_By=0;
				var m_Bz=0;

				if (XDOCX.XDUIInputPointCount() == 1)
	                 {
						  m_Ax = pos[0];
	                      m_Ay = pos[1];
	                      m_Az = pos[2];
	                      s_Ax = m_Ax;
		                  s_Ay = m_Ay;
		                  s_Az = m_Az;
						 XDOCX.XDLaySetEditable("Temporary");
	                     if (XDOCX.XDLayGetObjectCount("Temporary")>0){
	  						if (bExistObjectInLayer("Temporary","시작점")==true){
	  							XDOCX.XDObjDelete("Temporary","시작점");
	  						}
	  					}
	                     //clsUtil.CreateLayer(1, "Temporary", 1, 100000, false);
	                     XDOCX.XDRefSetColor(0, 255, 0, 0);
	                     XDOCX.XDRefSetPos(m_Ax, m_Ay, m_Az);
	                     XDOCX.XDObjCreateText("시작점", "시작점", "");
	                     
	                     XDOCX.XDMapRender();
	                 }

	                 if (XDOCX.XDUIInputPointCount() == 2)
	                 {
	                     m_Bx = pos[0];
	                     m_By = pos[1];
	                     m_Bz = pos[2];
	                    
	                    var subX = parseFloat(s_Ax) - parseFloat(m_Bx);
	                    var subY = parseFloat(s_Ay) - parseFloat(m_By);
	                    var subZ = parseFloat(s_Az) - parseFloat(m_Bz);
	                    var distance = Math.sqrt((subX * subX) + (subY * subY) + (subZ * subZ));
	                    
//	                     left.document.getElementById('Road_size').value =  parseInt(distance*100)/100;
//	                     var angle = (Math.atan2(-subY,-subX)*180/Math.PI);
//	                     if(angle > 90){
//	                    	 angle = 180-angle;
//	                     }
//	                     left.document.getElementById('Road_angle').value = parseInt(angle*100)/100; 
	                     
	                     s_Bx = m_Bx;
	                     s_By = m_By;
	                     s_Bz = m_Bz;

	                     XDOCX.XDLaySetEditable("Temporary");
	                     if (XDOCX.XDLayGetObjectCount("Temporary")>0){
	   						if (bExistObjectInLayer("Temporary","끝점")==true){
	   							XDOCX.XDObjDelete("Temporary","끝점");
	   						}
	   					}

	                     //clsUtil.CreateLayer(1, "anal", 1, 100000, false);
	                     XDOCX.XDRefSetColor(0, 255, 0, 0);
	                     XDOCX.XDRefSetPos(m_Bx, m_By, m_Bz);
	                     XDOCX.XDObjCreateText("끝점", "끝점", "");
	                     XDOCX.XDMapRender();
	                     XDOCX.XDUISetWorkMode(1);
	                 }
				 
                 break;
			case "Road_size": //사선분석
				var m_Ax=0;
				var m_Ay=0;
				var m_Az=0;
				var m_Bx=0;
				var m_By=0;
				var m_Bz=0;
				 if (XDOCX.XDUIInputPointCount() == 1)
                 {
					  m_Ax = pos[0];
                      m_Ay = pos[1];
                      m_Az = pos[2];
                      s_Ax = m_Ax;
                      s_Ay = m_Ay;
                      s_Az = m_Az;
					 XDOCX.XDLaySetEditable("Temporary");
                     if (XDOCX.XDLayGetObjectCount("Temporary")>0){
  						if (bExistObjectInLayer("Temporary","시작점")==true){
  							XDOCX.XDObjDelete("Temporary","시작점");
  						}
  					}
                     //clsUtil.CreateLayer(1, "Temporary", 1, 100000, false);
                     XDOCX.XDRefSetColor(0, 255, 0, 0);
                     XDOCX.XDRefSetPos(m_Ax, m_Ay, m_Az);
                     XDOCX.XDObjCreateText("시작점", "시작점", "");
                     
                     XDOCX.XDMapRender();
                 }

                 if (XDOCX.XDUIInputPointCount() == 2)
                 {
                     m_Bx = pos[0];
                     m_By = pos[1];
                     m_Bz = pos[2];
                    
                    var subX = parseFloat(s_Ax) - parseFloat(m_Bx);
                    var subY = parseFloat(s_Ay) - parseFloat(m_By);
                    var subZ = parseFloat(s_Az) - parseFloat(m_Bz);
                    var distance = Math.sqrt((subX * subX) + (subY * subY) + (subZ * subZ));
                    
//                     left.document.getElementById('Road_size').value =  parseInt(distance*100)/100;
                    document.getElementById('Road_size').value =  comma(distance,2);
                     
                     s_Bx = m_Bx;
                     s_By = m_By;
                     s_Bz = m_Bz;

                     XDOCX.XDLaySetEditable("Temporary");
                     if (XDOCX.XDLayGetObjectCount("Temporary")>0){
   						if (bExistObjectInLayer("Temporary","끝점")==true){
   							XDOCX.XDObjDelete("Temporary","끝점");
   						}
   					}

                     //clsUtil.CreateLayer(1, "anal", 1, 100000, false);
                     XDOCX.XDRefSetColor(0, 255, 0, 0);
                     XDOCX.XDRefSetPos(m_Bx, m_By, m_Bz);
                     XDOCX.XDObjCreateText("끝점", "끝점", "");
                     XDOCX.XDMapRender();
                     XDOCX.XDUISetWorkMode(1);
                 }
				break;
			case"조망차폐율":
				if (XDOCX.XDUIInputPointCount() == 1)
                {
					Start_point0 = pos[0];
					Start_point1 = pos[1];
					Start_point2 = pos[2];

                    //clsUtil.CreateLayer(5, "대상지", 1, 100000, false);
                    XDOCX.XDLaySetEditable("Temporary");
                    XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
                    XDOCX.XDRefSetColor(0, 255, 0, 0);
                    XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
                    XDOCX.XDObjCreateText(m_workMode + "_분석시점", m_workMode + "_분석시점", "");
                }
				if (XDOCX.XDUIInputPointCount() == 2)
                {
                	End_point0 = pos[0];
					End_point1 = pos[1];
					End_point2 = pos[2];
					
                    XDOCX.XDRefSetColor(255, 255, 0, 0);
                    XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
                    XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
                    XDOCX.XDLaySetEditable("Temporary");
                    XDOCX.XDObjCreateText(m_workMode + "_목표점", m_workMode + "_목표점", "");
                    m_WorkMode = "";
                   
                    XDOCX.XDUISetWorkMode(1);
                }
				XDOCX.XDMapRender();
				break;
			case "INPUTLINE":
				break;				
			case "조망축":
				exeFunction(pos, true);
				break;
			case "모의주행":
				exeFunction({button:button, pos:pos}, true);
				break;
			case "주동길이":
				exeFunction(pos, true);				
				break;
				
			}
			break;
		case XDMouseState.MML_INPUT_RECT : 		//22
			break;
		case XDMouseState.MML_INPUT_CIRCLE : 		//23
			break;
		case XDMouseState.MML_INPUT_AREA :		//24
			switch (m_workMode)
            {
			case "조망차폐율_대상지":
				 XDOCX.XDLaySetEditable("anal");
                 XDOCX.XDUISetWorkMode(24);
				break;
			case  "set_rect":
				if (button == 1) {
					if (left.hei_min.value == ""){
						left.hei_min.value = Math.round(parseFloat(pos[1]) * 100) / 100;  
					}else{
						if (left.hei_min.value > pos[1]){
							left.hei_min.value = Math.round(parseFloat(pos[1]) * 100) / 100; 
						}
					}
					if (left.hei_max.value == ""){
						left.hei_max.value = Math.round(parseFloat(pos[1]) * 100) / 100; 
					}else{
						if (left.hei_max.value < pos[1]){
							left.hei_max.value = Math.round(parseFloat(pos[1]) * 100) / 100; 
						}
					}
					left.hei_average.value = Math.round(((parseFloat(left.hei_min.value) + parseFloat(left.hei_max.value)) / 2) * 100) / 100;
					left.hei_change.value = Math.round(((parseFloat(left.hei_min.value) + parseFloat(left.hei_max.value)) / 2) * 100) / 100;
				}				
		 	break;
		 	}
			break;
		case XDMouseState.MML_INPUT_SPHERE :		//25 
			break;
			
		case XDMouseState.MML_OBJECT_INSERT :		//40
			break;
		case XDMouseState.MML_OBJECT_MOVE_XZ :	//41 
			break;
		case XDMouseState.MML_OBJECT_MOVE_YZ :	//42
			break;
		case XDMouseState.MML_OBJECT_ROTATE :		//43
			break;
		case XDMouseState.MML_OBJECT_SCALE :		//44
			break;
		case XDMouseState.MML_OBJECT_SCALE_Y :	//45
			break;
		case XDMouseState.MML_OBJECT_SCALE_XZ :	//46
			break;
			
		case XDMouseState.MML_DRAW_CUBE :			//50
			break;
		case XDMouseState.MML_DRAW_CYLINDER :		//51
			break;
		case XDMouseState.MML_DRAW_SPHERE :		//52
			break;
		case XDMouseState.MML_DRAW_CON :			//53
			break;
		case XDMouseState.MML_DRAW_PIPE :			//54
			break;
		case XDMouseState.MML_DRAW_DOME :			//55
			break;
		case XDMouseState.MML_DRAW_POLYHEAD :		//56
			break;
		case XDMouseState.MML_DRAW_ARROW :		//57
			break;
			
		case XDMouseState.MML_ANALYS_AREA :		//80
			break;
		case XDMouseState.MML_ANALYS_DISTANCE : 	//81
			break;
		case XDMouseState.MML_ANALYS_VIEWSHED :	//82
			break;
			
		case XDMouseState.MML_UI_MEMO :			//90
			break;
		case XDMouseState.ANALYS_JOMANGPOINT :	//94
			//left1.input_point(pos[0], pos[1], pos[2]);

			if (getSimulMode() == 103){   
				var m_flag;
				//alert(getObj());
				if (getObj() == 1 || getObj() == 0)
                {
                    if (XDOCX.XDAnsJomangListCount() < 2)
                    {
                        XDOCX.XDLaySetEditable("Temporary");
                        XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 255, 255, 255);
                        XDOCX.XDRefSetColor(0, 0, 0, 0);
                        XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
                        XDOCX.XDObjCreateText("기준점", "기준점", getWorkPath() + "\\kopss\\BlueP.png");
                        left.setJomangIn(pos[0], pos[1], pos[2]);
                        //alert(getWorkPath() + "\\texture\\BlueP.png");
                        //setOperationMode(1);	//XDOCX.XDUISetWorkMode(1);
                        XDOCX.XDUISetWorkMode(1);
                        XDOCX.XDMapRender();
                        //left.setAnalysisImage();

                    }
                    else
                    {
                        if (getObj() == 1)
                        {
                        	//alert("방향점" + (XDOCX.XDAnsJomangListCount() - 1));
                        	var count = XDOCX.XDAnsJomangListCount() - 1;
                        	//alert("방향점 "+count+"를 입력해주세요 .")
                            m_flag = true;
                            XDOCX.XDLaySetEditable("Temporary");
                            XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 255, 255, 255);
                            XDOCX.XDRefSetColor(0, 0, 0, 0);
                            XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
                            XDOCX.XDObjCreateText("방향점" + (XDOCX.XDAnsJomangListCount() - 1), "방향점" + (XDOCX.XDAnsJomangListCount() - 1), getWorkPath() + "\\kopss\\GreenP.png");
                        	left.makeTbl(count, pos[0], pos[1], pos[2],"방향점"+ count +"#"+XDOCX.XDLayGetObjectKey("Temporary2", XDOCX.XDLayerGetObjectNum("Temporary2") - 1));
                            //alert("방향점" + (XDOCX.XDAnsJomangListCount() - 1));
                            //setOperationMode(1);
                        	XDOCX.XDUISetWorkMode(1);
                            //pv.m_frmAnalJomangView.AddPoint(m_Fx, m_Fy, m_Fz, m_flag, ("방향점" + Convert.ToString(XDOCX.XDAnsJomangListCount() - 1)) + "#" + XDOCX.XDLayGetObjectKey("Temporary2", pv.XDOCX.XDLayerGetObjectNum("Temporary2") - 1));
                            //MessageBox.Show(""+(XDOCX.XDLayGetObjectKey("Temporary2", pv.XDOCX.XDLayerGetObjectNum("Temporary") - 1)));
                            //for (int i = 0; i < XDOCX.XDLayerGetObjectNum("Temporary"); i++) { XDOCX.XDLayGetObjectKey("Temporary", i); MessageBox.Show(""+XDOCX.XDLayGetObjectKey("Temporary", i));}
                            XDOCX.XDMapRender();
                            //left1.setAnalysisImage();
                        }
                        else if (getObj() == 0)
                        {
                            XDOCX.XDAnaJomangElement(getObj());
                            m_flag = false;
                            // pv.XDOCX.xdans
                            //pv.m_frmAnalJomangG.AddPoint(m_Fx, m_Fy, m_Fz, m_flag);
                        }
                        //0:수정,1:추가
                    }

                    setObj(2);
                    //setOperationMode(1);
                    XDOCX.XDUISetWorkMode(1);

                    //m_Fx = posX
                    //m_Fy = posY
                    //m_Fz = posZ

                    var GetPosY = 0;
                    var getTerrain = 0;
                    GetPosY = pos[1];
                    getTerrain = XDOCX.XDTerrGetPointHeight(pos[0], pos[2]);

                    if (GetPosY == getTerrain)
                    {
                    	setJomangBasePt(1.7);
                    }
                    else
                    {
                    	setJomangBasePt(0);
                    }
                    setJomang(false); 
                }else{
                	
                }
                XDOCX.XDMapRender();
			}
			break;
			
		default:
			break;
	}
	
	XDOCX.XDMapRender();
}

m_JomangBasePt = 1.7;
setJomangBasePt = function(value)
{
	m_JomangBasePt = value;
}

getJomangBasePt = function()
{
	return m_JomangBasePt;
}

m_Jomang = '';
setJomang = function(value)
{
	m_Jomang = value;
}

getJomang = function()
{
	return m_Jomang;
}

//작업함수
var m_function = new Array();

/**
 * 작업함수 추가
 * @param fn
 */
function addFunction(fn){
	m_function.push(fn);
}

/**
 * 작업함수 초기화
 */
function initFunction(){
	m_function = new Array();
}

/**
 * 작업함수 실행
 * @param data
 */
function exeFunction(data, isNoRemove){
	for(var i = 0; i < m_function.length; i++){
		try {
			m_function[i](data);
		} catch (e) {}
	}
	
	if(isNoRemove != true) initFunction();
}


var m_strTemp = "";
setStrTemp = function(value){
	m_strTemp = value;
}
getStrTemp = function(){
	return m_strTemp;
}

var tmpObj = null;
setObj = function(value) {
	tmpObj = value;	
}
getObj = function() {
	return tmpObj;	
}

//화면 다시그리기
Refresh = function() {
	top.XDOCX.XDMapRenderLock(true);
	//layVis(false);
	top.XDOCX.XDMapClearTempLayer();
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDAnsClear();
    top.XDOCX.XDSelClear();
    top.XDOCX.XDUIDistanceClear();
    top.XDOCX.XDUIAreaClear();
    top.top.XDOCX.XDUIClearMemo();    
    //top.XDOCX.XDLayClear(top.getMLayer());
    //top.XDOCX.XDLayClear(top.getMLayer2());
    top.XDOCX.XDLayRemove("anal");
    top.XDOCX.XDLaySetEditable("Temporary");
    top.XDOCX.XDLayClear("Temporary");
    top.XDOCX.XDAnsJomangListClear();
    top.XDOCX.XDLaySetEditable("SteetTree");
    top.XDOCX.XDLayRemove("SteetTree");
    top.XDOCX.XDLaySetEditable("Temporary2");
    top.XDOCX.XDLayRemove("Temporary2");
    top.XDOCX.XDAnsSigokGuideClear();
	top.XDOCX.XDTerrEditUndo();
	top.XDOCX.XDUISetWorkMode(1);
    top.setSimulMode(0);
    top.XDOCX.XDMapRenderLock(false);
 	top.XDOCX.XDMapLoad();
    top.XDOCX.XDMapRender();
    top.XDOCX.XDMapResetRTT(); 
    
}


/**
 * 경관지표분석 결과
 *
 * 가시권분석, 가시권역분석, 사선분석, 조망비율, 평균높이, 주동길이, 조망차폐율, 광역단면, 시곡면분석, 녹시변화율,
 * 선택지점, 주변건물, 영역그리드, 지형일조, 경사도, 경사향
 */
var _indicator_result = {};  

/**
 * 경관지표분석 결과 저장
 */
function setIndicator(name, value){
	_indicator_result[name] = value;
}

/**
 * 경관지표분석 결과 추가 저장(Array 타입)
 */
function addIndicator(name, value){
	if(!_indicator_result[name]) _indicator_result[name] = new Array();
	_indicator_result[name].push(value);
}

/**
 * 경관지표분석 결과 반환
 */
function getIndicator(name){
	return _indicator_result[name];
}

/**
 * 경관지표분석 결과 초기화 
 */
function initIndicator(name){
	if(name){
		_indicator_result[name] = null;
	}else{
		_indicator_result[name] = {};
	}
}


m_JomangBasePt = 1.7;
setJomangBasePt = function(value)
{
	m_JomangBasePt = value;
}

getJomangBasePt = function()
{
	return m_JomangBasePt;
}

m_Jomang = '';
setJomang = function(value)
{
	m_Jomang = value;
}

getJomang = function()
{
	return m_Jomang;
}

//작업함수
var m_function = new Array();

/**
 * 작업함수 추가
 * @param fn
 */
function addFunction(fn){
	m_function.push(fn);
}

/**
 * 작업함수 초기화
 */
function initFunction(){
	m_function = new Array();
}

/**
 * 작업함수 실행
 * @param data
 */
function exeFunction(data, isNoRemove){
	for(var i = 0; i < m_function.length; i++){
		try {
			m_function[i](data);
		} catch (e) {}
	}
	
	if(isNoRemove != true) initFunction();
}


var m_strTemp = "";
setStrTemp = function(value){
	m_strTemp = value;
}
getStrTemp = function(){
	return m_strTemp;
}

var tmpObj = null;
setObj = function(value) {
	tmpObj = value;	
}
getObj = function() {
	return tmpObj;	
}

//화면 다시그리기
Refresh = function() {
	top.XDOCX.XDMapRenderLock(true);
	//layVis(false);
	top.XDOCX.XDMapClearTempLayer();
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDAnsClear();
    top.XDOCX.XDSelClear();
    top.XDOCX.XDUIDistanceClear();
    top.XDOCX.XDUIAreaClear();
    top.top.XDOCX.XDUIClearMemo();    
    //top.XDOCX.XDLayClear(top.getMLayer());
    //top.XDOCX.XDLayClear(top.getMLayer2());
    top.XDOCX.XDLayRemove("anal");
    top.XDOCX.XDLaySetEditable("Temporary");
    top.XDOCX.XDLayClear("Temporary");
    top.XDOCX.XDAnsJomangListClear();
    top.XDOCX.XDLaySetEditable("SteetTree");
    top.XDOCX.XDLayRemove("SteetTree");
    top.XDOCX.XDLaySetEditable("Temporary2");
    top.XDOCX.XDLayRemove("Temporary2");
    top.XDOCX.XDAnsSigokGuideClear();
	top.XDOCX.XDTerrEditUndo();
	top.XDOCX.XDUISetWorkMode(1);
    top.setSimulMode(0);
    top.XDOCX.XDMapRenderLock(false);
 	top.XDOCX.XDMapLoad();
    top.XDOCX.XDMapRender();
    top.XDOCX.XDMapResetRTT(); 
}

function addComma(value) {
	var point = "";
	var returnValue = "";
	
	if (value == "") { return "";}
	
	value = value.toString();
	
	if (value.indexOf(".") > 0) {
		point = value.substring(value.indexOf("."), value.length);
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

function getCurrDate() {
	var today = new Date(); 
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var date = today.getDate();
	var time = today.getTime();
	var hour = today.getHours()
	var mi = today.getMinutes();
	var sec = today.getSeconds();
	var ms = today.getMilliseconds();
	
	var cDate = "";	
	cDate += year.toString();
	if (month < 10) {
		cDate += "0" + month;
	} else {
		cDate += month;		
	}	
	if (date < 10) {
		cDate += "0" + date;
	} else {
		cDate += date;		
	}
	if (hour < 10) {
		cDate += "0" + hour;
	} else {
		cDate += hour;		
	}
	if (mi < 10) {
		cDate += "0" + mi;
	} else {
		cDate += mi;		
	}
	if (sec < 10) {
		cDate += "0" + sec;
	} else {
		cDate += sec;		
	}
	if (ms < 100)  {
		cDate += "00" + ms;		
	} else 	if (ms < 10)  {
		cDate += "0" + ms;		
	} else {
		cDate += ms;		
	}
	
	return cDate;
}

function toHex(value) {
	if (value == null) { return "00"; }
	value = parseInt(value);
	if (value == 0 || isNaN(value)) return "00";
	value = Math.max(0, value); value = Math.min(value, 255); value = Math.round(value);
	return "0123456789ABCDEF".charAt((value-value%16)/16)+"0123456789ABCDEF".charAt(value%16);
}

//색상
function HexToDec(color) {
	if (color.substring(0,1) == "#")
	{
		color = color.substring(1);	
	}
	color = color.toUpperCase();
	a = GiveDec(color.substring(0, 1));
	b = GiveDec(color.substring(1, 2));
	c = GiveDec(color.substring(2, 3));
	d = GiveDec(color.substring(3, 4));
	e = GiveDec(color.substring(4, 5));
	f = GiveDec(color.substring(5, 6));
	x = (a * 16) + b;
	y = (c * 16) + d;
	z = (e * 16) + f;

	var strColor = x+","+y+","+z;
	return strColor;	
}
