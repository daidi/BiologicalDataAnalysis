package com.isdaidi.bigdata.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.omg.CORBA.Request;

import com.isdaidi.bigdata.util.DBUtil;
import com.isdaidi.bigdata.util.ResultUtil;

/*
 * 基因表的处理类
 */

public class GeneProcess {
//	private int inputsize=0;
//	private int tablesize=0;
//	public int getInputsize() {
//		return inputsize;
//	}
//
//	public int getTablesize() {
//		return tablesize;
//	}

	
	
	/*
	 * 获取表名
	 */
	public ArrayList<String> getTableName(String table) {
		String sql = "select name from sys.objects where name like ? and type = 'u'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> arrayList = new ArrayList<String>();
		int count = -1;
		//tablesize=0;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, table + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				arrayList.add(rs.getString("name"));
				//tablesize++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
		return arrayList;

	}

	/*
	 * 统计单文件时该表的峰值个数
	 */
	public LinkedHashMap<String, Integer> countMax(String table, double start,
			double end, double aptratio,String chromosome) {
		ArrayList<String> arrayList = getTableName(table);
		LinkedHashMap<String, Integer> resultmap = new LinkedHashMap<String, Integer>();
		System.out.println(arrayList + "  " + arrayList.size());
		int count;

		if (aptratio == 1) {
			for (int i = 0; i < arrayList.size(); ++i) {
				String tablename = arrayList.get(i);
				String sql = "SELECT count(*) from [" + tablename
						+ "] WHERE chrom=? AND chromStart>? AND chromEnd<?";
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					conn = DBUtil.getConnection();
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, chromosome);
					pstmt.setDouble(2, start);
					pstmt.setDouble(3, end);
					rs = pstmt.executeQuery();
					rs.next();// count(*)总是有结果的
					count = Integer.parseInt(rs.getString(1));
					resultmap.put(tablename.split(table)[1], count);

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					DBUtil.close(rs);
					DBUtil.close(pstmt);
					DBUtil.close(conn);
				}
			}
		} else {
			for (int i = 0; i < arrayList.size(); ++i) {
				String tablename = arrayList.get(i);
				String sql = " with temp1(frequency)  as (select  ((?-chromStart)/(chromEnd-chromStart)) from ["
						+ tablename
						+ "] where chromStart<? AND chromEnd>?), temp2(frequency)  as (select  ((chromEnd-?)/(chromEnd-chromStart)) from ["
						+ tablename
						+ "] where chromStart<? AND chromEnd>?) select ( (select count(*) from temp1 where frequency>?)+ (select count(*) from temp2 where frequency>?)+ (select count(*) from ["
						+ tablename + "] where  chromStart>? AND chromEnd<?) )";
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					conn = DBUtil.getConnection();
					pstmt = conn.prepareStatement(sql);
					pstmt.setDouble(1, end);
					pstmt.setDouble(2, end);
					pstmt.setDouble(3, end);
					pstmt.setDouble(4, start);
					pstmt.setDouble(5, start);
					pstmt.setDouble(6, start);
					pstmt.setDouble(7, aptratio);
					pstmt.setDouble(8, aptratio);
					pstmt.setDouble(9, start);
					pstmt.setDouble(10, end);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						count = Integer.parseInt(rs.getString(1));
						resultmap.put(tablename.split(table)[1], count);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					DBUtil.close(rs);
					DBUtil.close(pstmt);
					DBUtil.close(conn);
				}
			}
		}
		return resultmap;

	}

	/*
	 * 统计多文件时该表的峰值个数
	 */
	public LinkedHashMap<ResultUtil, Integer> countMax(String table,
			double aptratio, String filepath) {

		StringBuilder sb = new StringBuilder();

		try {
			File file = new File(filepath);
			if (file.isFile() && file.exists()) { // 判断文件是否存在
				InputStreamReader read = new InputStreamReader(
						new FileInputStream(file));
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					sb.append(lineTxt);
				}
				read.close();
			} else {
				System.out.println("找不到指定的文件");
			}
		} catch (Exception e) {
			System.out.println("读取文件内容出错");
			e.printStackTrace();
		}

		// 表名、时间区间、个数
		ArrayList<String> arrayList = getTableName(table);
		LinkedHashMap<ResultUtil, Integer> resultmap = new LinkedHashMap<ResultUtil, Integer>();
		ResultUtil ru = null;
		int count;
		if (aptratio == 1) {
			for (int i = 0; i < arrayList.size(); ++i) {
				String qujian;
				StringTokenizer st2;
				String s = new String(sb);
				StringTokenizer st = new StringTokenizer(s, ";");
				//inputsize=0;
				while (st.hasMoreElements()) {
					//inputsize++;
					qujian = st.nextToken();
					st2 = new StringTokenizer(qujian, ",");
					double start = Double.parseDouble(st2.nextToken());
					double end = Double.parseDouble(st2.nextToken());
					String tablename = arrayList.get(i);
					ru = new ResultUtil();// 输入变量是二维，定义一个实体类存储
					ru.setTimeend(end);
					ru.setTimestart(start);
					ru.setTablename(tablename);

					String sql = "SELECT count(*) from [" + tablename
							+ "] WHERE chromStart>? AND chromEnd<?";
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = DBUtil.getConnection();
						pstmt = conn.prepareStatement(sql);
						pstmt.setDouble(1, start);
						pstmt.setDouble(2, end);
						rs = pstmt.executeQuery();
						rs.next();// count(*)总是有结果的
						count = Integer.parseInt(rs.getString(1));
						System.out.println("tablename======" + tablename
								+ "  count=========" + count);
						resultmap.put(ru, count);

					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						DBUtil.close(rs);
						DBUtil.close(pstmt);
						DBUtil.close(conn);
					}
				}
			}
		} else {
			
			for (int i = 0; i < arrayList.size(); ++i) {
				String qujian;
				StringTokenizer st2;
				String s = new String(sb);
				StringTokenizer st = new StringTokenizer(s, ";");
				//inputsize=0;
				while (st.hasMoreElements()) {
					//inputsize++;
					qujian = st.nextToken();
					st2 = new StringTokenizer(qujian, ",");
					double start = Double.parseDouble(st2.nextToken());
					double end = Double.parseDouble(st2.nextToken());
					String tablename = arrayList.get(i);
					ru = new ResultUtil();// 输入变量是二维，定义一个实体类存储
					ru.setTimeend(end);
					ru.setTimestart(start);
					ru.setTablename(tablename);
					String sql = " with temp1(frequency)  as (select  ((?-chromStart)/(chromEnd-chromStart)) from ["
							+ tablename
							+ "] where chromStart<? AND chromEnd>?), temp2(frequency)  as (select  ((chromEnd-?)/(chromEnd-chromStart)) from ["
							+ tablename
							+ "] where chromStart<? AND chromEnd>?) select ( (select count(*) from temp1 where frequency>?)+ (select count(*) from temp2 where frequency>?)+ (select count(*) from ["
							+ tablename + "] where  chromStart>? AND chromEnd<?) )";
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = DBUtil.getConnection();
						pstmt = conn.prepareStatement(sql);
						pstmt.setDouble(1, end);
						 pstmt.setDouble(2, end);
						 pstmt.setDouble(3, end);
						 pstmt.setDouble(4, start);
						 pstmt.setDouble(5, start);
						 pstmt.setDouble(6, start);
						 pstmt.setDouble(7, aptratio);
						 pstmt.setDouble(8, aptratio);
						 pstmt.setDouble(9, start);
						 pstmt.setDouble(10, end);
						rs = pstmt.executeQuery();
						rs.next();// count(*)总是有结果的
						count = Integer.parseInt(rs.getString(1));
						System.out.println("tablename======" + tablename
								+ "  count=========" + count);
						resultmap.put(ru, count);

					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						DBUtil.close(rs);
						DBUtil.close(pstmt);
						DBUtil.close(conn);
					}
				}
			}
		}
		return resultmap;

	}
	
	
	
}
