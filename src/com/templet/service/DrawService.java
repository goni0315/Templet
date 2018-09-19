package com.templet.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.nice19.smboard.board.model.BoardModel;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.templet.dao.DrawDao;
import com.templet.vo.BliudVo;
import com.templet.vo.CctvVo;
import com.templet.vo.DrawBoardVo;
import com.templet.vo.EmbVo;
import com.templet.vo.JibunVo;
import com.templet.vo.LayerVo;



public class DrawService implements DrawDao{

	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	public boolean writeObejct(DrawBoardVo board) {
		sqlMapClientTemplate.insert("draw.writeObject", board);		
		return true;
	}
	
	public ArrayList listEmb(String ename) {
		ArrayList<EmbVo> result = new ArrayList<EmbVo>();
		result =  (ArrayList<EmbVo>) sqlMapClientTemplate.queryForList("draw.embSearch", ename);
		return result;
	}
	
	public ArrayList listClass(String ename) {
		ArrayList<EmbVo> result = new ArrayList<EmbVo>();
		result =  (ArrayList<EmbVo>) sqlMapClientTemplate.queryForList("draw.classSearch", ename);
		return result;
	}
	
	public List<JibunVo> getJibunList(int startArticleNum, int endArticleNum, String pnuCode) {
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("pnuCode", pnuCode);
		return sqlMapClientTemplate.queryForList("draw.jibunSearchList", valueMap);
	}
	
	public int getJinbunTotalNum(String pnuCode) {
		valueMap.put("pnuCode", pnuCode);
		return (Integer) sqlMapClientTemplate.queryForObject("draw.jibunTotalNum", valueMap);
	}

	public List<DrawBoardVo> getObjectList(int startArticleNum, int endArticleNum,
			int startDate, int endDate) {
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("startDate", startDate);
		valueMap.put("endDate", endDate);
		return sqlMapClientTemplate.queryForList("draw.objectSearchList", valueMap);
	}

	public int getObjectTotalNum(int startDate, int endDate) {
		valueMap.put("startDate", startDate);
		valueMap.put("endDate", endDate);
		return (Integer) sqlMapClientTemplate.queryForObject("draw.objectTotalNum", valueMap);
	}

	public List<LayerVo> getLayerList() {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate.queryForList("draw.layerList");
	}

	public List<BliudVo> getbuildList(int startArticleNum, int endArticleNum, String classnew, String classnow, String embNm, String buildSearch) {
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("classnew", classnew);
		valueMap.put("classnow", classnow);
		valueMap.put("embNm", embNm);
		valueMap.put("buildSearch", buildSearch);
		return sqlMapClientTemplate.queryForList("draw.buildSearchList", valueMap);
	}

	public int getbuildTotalNum(String classnew, String classnow, String embNm,	String buildSearch) {
		valueMap.put("classnew", classnew);
		valueMap.put("classnow", classnow);
		valueMap.put("embNm", embNm);
		valueMap.put("buildSearch", buildSearch);
		return (Integer) sqlMapClientTemplate.queryForObject("draw.buildTotalNum", valueMap);
	}

	public List<CctvVo> getCctvList(int startArticleNum, int endArticleNum, String addrName, String embNm) {
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("addrName", addrName);
		valueMap.put("embNm", embNm);
		return sqlMapClientTemplate.queryForList("draw.cctvSearchList", valueMap);
	}

	public int getCctvTotalNum(String addrName, String embNm) {
		valueMap.put("addrName", addrName);
		valueMap.put("embNm", embNm);
		return (Integer) sqlMapClientTemplate.queryForObject("draw.cctvTotalNum", valueMap);
	}

	public List<LayerVo> listClsInfo() {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate.queryForList("draw.layergroup");
	}



	
	
	
}
