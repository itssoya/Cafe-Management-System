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

import com.beanbrew.util.SessionUtil;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter(urlPatterns = {"/addmenu", "/usermanagement", "/menu", "/addcategory", "/cart", "/userprofile", "/stockmanagement/restockitem", "/ordermanagement", "/menumanagement","/editmenu", "addrecipe"})
public class AuthenticationFilter extends HttpFilter implements Filter {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public AuthenticationFilter() {
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
		
		// Cast the generic request/response to HTTP-specific versions
			HttpServletRequest httpRequest = (HttpServletRequest) request;
			HttpServletResponse httpResponse = (HttpServletResponse) response;

			// Logic: Check if the session exists and contains your login identifier
			// Change "user" to whatever attribute name you set in your LoginServlet
			boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "currentUser", Object.class) != null;

			if (isLoggedIn) {
				// User is logged in, allow the request to proceed to the destination
				// In my case, now go to that servlet which I have called
				httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
		        httpResponse.setHeader("Pragma", "no-cache");
		        httpResponse.setDateHeader("Expires", 0);
		        
					chain.doFilter(request, response);
			} else {
				// User is not logged in, redirect to login page
				// Note: Avoid caching the dashboard so the back button doesn't reveal data
				
				String requestedUrlByUser = httpRequest.getRequestURI();

			    // 2. Save it to the session
			    httpRequest.getSession().setAttribute("intendedUrl", requestedUrlByUser );

			    // 3. Redirect to login
			    httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");

				
				return;
			}

		// pass the request along the filter chain
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
