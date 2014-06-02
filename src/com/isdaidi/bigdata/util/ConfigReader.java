package com.isdaidi.bigdata.util;



import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 读取xml配置文件
 *
 */
public class ConfigReader {

	private static ConfigReader instance = new ConfigReader();
	
	private Document doc;
	
	private JdbcInfo jdbcInfo;
	
	private final String configFile="sys-config.xml";//sys-config.xml
	
	private ConfigReader() {
		try {
			doc = new SAXReader().read(Thread.currentThread().getContextClassLoader().getResourceAsStream(configFile));
			Element driverNameElt = (Element)doc.selectObject("/config/db-info/driver-name");
			Element urlElt = (Element)doc.selectObject("/config/db-info/url");
			Element usernameElt = (Element)doc.selectObject("/config/db-info/username");
			Element passwordElt = (Element)doc.selectObject("/config/db-info/password");
			jdbcInfo = new JdbcInfo();
			jdbcInfo.setDriverName(driverNameElt.getStringValue());
			jdbcInfo.setUrl(urlElt.getStringValue());
			jdbcInfo.setUsername(usernameElt.getStringValue());
			jdbcInfo.setPassword(passwordElt.getStringValue());
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	
	public static ConfigReader getInstance() {
		return instance;
	}
	
	public JdbcInfo getJdbcInfo() {
		return jdbcInfo;
	}
	
	public static void main(String[] args){
		//System.out.println(ConfigReader.getInstance().getJdbcInfo().getDriverName());
		
		System.out.println(ConfigReader.getInstance().getJdbcInfo());
	}
}
