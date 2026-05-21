package com.beanbrew.service;

import java.sql.SQLException;

import com.beanbrew.dao.AddContactUsDAO;
import com.beanbrew.model.ContactUs;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.ServiceExecutor;

public class ContactUsManagementService {
	
public void addContactUs (ContactUs contactUs) {
		
       if (contactUs.getName()== null || !contactUs.getName().isEmpty()) throw new ServiceException ("All filed required");
       
       if (contactUs.getEmail()== null || !contactUs.getEmail().isEmpty()) throw new ServiceException ("All filed required");
       
       if (contactUs.getSubject()== null || !contactUs.getSubject().isEmpty()) throw new ServiceException ("All filed required");
       
       if (contactUs.getMessage()== null || !contactUs.getMessage().isEmpty()) throw new ServiceException ("All filed required");
       
       try {
    	   
    	   AddContactUsDAO.addContactDetails(contactUs);
    	   
       } catch (SQLException e) {
    	   
    	   throw new ServiceException ("Something went wrong");
       }
    }

}
