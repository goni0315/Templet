package com.templet.dao;

import java.util.ArrayList;
import java.util.List;

import net.nice19.smboard.board.model.BoardModel;

import com.templet.vo.BliudVo;
import com.templet.vo.CctvVo;
import com.templet.vo.DrawBoardVo;
import com.templet.vo.EmbVo;
import com.templet.vo.JibunVo;
import com.templet.vo.LayerVo;

public interface DrawDao {
	// insert article data
	boolean writeObejct(DrawBoardVo board);
	ArrayList listEmb(String ename);
	List<JibunVo> getJibunList(int startArticleNum, int endArticleNum, String pnuCode);
	int getJinbunTotalNum(String pnuCode);
	List<DrawBoardVo> getObjectList(int startArticleNum, int endArticleNum, int startDate, int endDate);
	int getObjectTotalNum(int startDate, int endDate);
	List<LayerVo> getLayerList();
	ArrayList listClass(String ename);
	List<BliudVo> getbuildList(int startArticleNum, int endArticleNum, String classnew, String classnow, String embNm, String buildSearch);
	int getbuildTotalNum(String classnew, String classnow, String embNm, String buildSearch);
	List<CctvVo> getCctvList(int startArticleNum, int endArticleNum, String addrName, String embNm);
	int getCctvTotalNum(String addrName, String embNm);
	List<LayerVo> listClsInfo();
}
