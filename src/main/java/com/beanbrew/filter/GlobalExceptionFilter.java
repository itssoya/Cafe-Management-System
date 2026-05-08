package com.beanbrew.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.beanbrew.util.ServiceException;

/**
 * Servlet Filter implementation class GlobalExceptionFilter
 */
@WebFilter("/*")
public class GlobalExceptionFilter extends HttpFilter implements Filter {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public GlobalExceptionFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
		 HttpServletRequest req = (HttpServletRequest) request;
	     HttpServletResponse res = (HttpServletResponse) response;

		// pass the request along the filter chain
	     
	     try {
	            chain.doFilter(req, res);

	        } catch (Exception e) {
	           
	        	System.out.println("Unhandled error cautch by Filter");

	            HttpServletRequest  httpReq = (HttpServletRequest)  req;
	            HttpServletResponse httpRes = (HttpServletResponse) res;

	            httpReq.setAttribute("errorMessage", "Something went wrong. Please try again later.");
	            httpReq.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(httpReq, httpRes);
	        }
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
