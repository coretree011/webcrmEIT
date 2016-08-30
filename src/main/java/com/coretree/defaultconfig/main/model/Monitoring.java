package com.coretree.defaultconfig.main.model;

public class Monitoring {
	private long totIbCnt;					//총인입
	private long totAgtConnCnt;			//상담원연결
	private long totAbanCnt;				//상담원포기
	private long totAgtIbCnt;				//상담원전체인바운드건수
	private long totAgtObCnt;			//상담원전체아웃바운드건수
	private long agtIbCnt;					//로그인상담원 인ㅇ바운드
	private long agtObCnt;				//로그인상담원 아웃바운드
	private long totCbCnt;					//당일 전체 콜백
	private long agtCbCnt;				//당일 상담원이 처리한 콜백
	private long totRevCnt;				//당일 전체 상담예약건수
	private long agtRevCnt;				//당일 상담원이 처리한 상담예약
	private long totBbsCnt;				//공지사항
	public long getTotIbCnt() {
		return totIbCnt;
	}
	public void setTotIbCnt(long totIbCnt) {
		this.totIbCnt = totIbCnt;
	}
	public long getTotAgtConnCnt() {
		return totAgtConnCnt;
	}
	public void setTotAgtConnCnt(long totAgtConnCnt) {
		this.totAgtConnCnt = totAgtConnCnt;
	}
	public long getTotAbanCnt() {
		return totAbanCnt;
	}
	public void setTotAbanCnt(long totAbanCnt) {
		this.totAbanCnt = totAbanCnt;
	}
	public long getTotAgtIbCnt() {
		return totAgtIbCnt;
	}
	public void setTotAgtIbCnt(long totAgtIbCnt) {
		this.totAgtIbCnt = totAgtIbCnt;
	}
	public long getTotAgtObCnt() {
		return totAgtObCnt;
	}
	public void setTotAgtObCnt(long totAgtObCnt) {
		this.totAgtObCnt = totAgtObCnt;
	}
	public long getAgtIbCnt() {
		return agtIbCnt;
	}
	public void setAgtIbCnt(long agtIbCnt) {
		this.agtIbCnt = agtIbCnt;
	}
	public long getAgtObCnt() {
		return agtObCnt;
	}
	public void setAgtObCnt(long agtObCnt) {
		this.agtObCnt = agtObCnt;
	}
	public long getTotCbCnt() {
		return totCbCnt;
	}
	public void setTotCbCnt(long totCbCnt) {
		this.totCbCnt = totCbCnt;
	}
	public long getAgtCbCnt() {
		return agtCbCnt;
	}
	public void setAgtCbCnt(long agtCbCnt) {
		this.agtCbCnt = agtCbCnt;
	}
	public long getTotRevCnt() {
		return totRevCnt;
	}
	public void setTotRevCnt(long totRevCnt) {
		this.totRevCnt = totRevCnt;
	}
	public long getAgtRevCnt() {
		return agtRevCnt;
	}
	public void setAgtRevCnt(long agtRevCnt) {
		this.agtRevCnt = agtRevCnt;
	}
	public long getTotBbsCnt() {
		return totBbsCnt;
	}
	public void setTotBbsCnt(long totBbsCnt) {
		this.totBbsCnt = totBbsCnt;
	}
	@Override
	public String toString() {
		return "Monitoring [totIbCnt=" + totIbCnt + ", totAgtConnCnt="
				+ totAgtConnCnt + ", totAbanCnt=" + totAbanCnt
				+ ", totAgtIbCnt=" + totAgtIbCnt + ", totAgtObCnt="
				+ totAgtObCnt + ", agtIbCnt=" + agtIbCnt + ", agtObCnt="
				+ agtObCnt + ", totCbCnt=" + totCbCnt + ", agtCbCnt="
				+ agtCbCnt + ", totRevCnt=" + totRevCnt + ", agtRevCnt="
				+ agtRevCnt + ", totBbsCnt=" + totBbsCnt + "]";
	}
}