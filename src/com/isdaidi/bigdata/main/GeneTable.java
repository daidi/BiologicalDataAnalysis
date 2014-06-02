package com.isdaidi.bigdata.main;

/*
 * 基因表的实体类
 */

public class GeneTable {
	private String chrom;
	private String chromStart;
	private String chromEnd;
	private String signalValue;
	private String pValue;
	private String qValue;

	public String getChrom() {
		return chrom;
	}

	public void setChrom(String chrom) {
		this.chrom = chrom;
	}

	public String getChromStart() {
		return chromStart;
	}

	public void setChromStart(String chromStart) {
		this.chromStart = chromStart;
	}

	public String getChromEnd() {
		return chromEnd;
	}

	public void setChromEnd(String chromEnd) {
		this.chromEnd = chromEnd;
	}

	public String getSignalValue() {
		return signalValue;
	}

	public void setSignalValue(String signalValue) {
		this.signalValue = signalValue;
	}

	public String getpValue() {
		return pValue;
	}

	public void setpValue(String pValue) {
		this.pValue = pValue;
	}

	public String getqValue() {
		return qValue;
	}

	public void setqValue(String qValue) {
		this.qValue = qValue;
	}

}
