package com.util.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharsetEncodingFilter implements Filter {

	private String encoding = "UTF-8";

	public void destroy() { //返回filter的配置对象
	}

	public void doFilter(ServletRequest servletRequest, //执行filter 的工作.
			ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		servletRequest.setCharacterEncoding(this.encoding);
		filterChain.doFilter(servletRequest, servletResponse);
	}

	public void init(FilterConfig filterConfig) throws ServletException { //设置filter 的配置对象
		this.encoding = filterConfig.getInitParameter("encoding");
	}
}