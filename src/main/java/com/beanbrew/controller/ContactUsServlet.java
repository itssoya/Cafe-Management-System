package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.beanbrew.model.ContactUs;
import com.beanbrew.service.ContactUsManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

/**
 * Servlet implementation class ContactUsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/contactus" })
public class ContactUsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ContactUsManagementService contactUsManagementService = new ContactUsManagementService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactUsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		request.getRequestDispatcher("/WEB-INF/pages/ContactUs.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        try{
        	
        	ContactUs contactUs = new ContactUs();
        	contactUs.setName(name);
        	contactUs.setEmail(email);
        	contactUs.setSubject(subject);
        	contactUs.setMessage(message);
        	
        	contactUsManagementService.addContactUs(contactUs);
        	
        } catch (ServiceException e) {
        	 
        	request.setAttribute(MessageKeysUtil.ERROR, e);
            request.getRequestDispatcher("/WEB-INF/pages/contactus.jsp").forward(request, response);
            return;
        }
        
	}

}
