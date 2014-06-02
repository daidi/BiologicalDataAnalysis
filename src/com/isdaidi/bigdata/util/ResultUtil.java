package com.isdaidi.bigdata.util;

public class ResultUtil {
	private String tablename;
	private double timestart;
	private double timeend;

	public String getTablename() {
		return tablename;
	}
	
	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

	public double getTimestart() {
		return timestart;
	}

	public void setTimestart(double timestart) {
		this.timestart = timestart;
	}

	public double getTimeend() {
		return timeend;
	}

	public void setTimeend(double timeend) {
		this.timeend = timeend;
	}

	/*public String toString() {
		return tablename+" + "+timestart+" + "+timeend;
	    }*/
	public String toString(){
		return tablename;
	}
}
