package com.beanbrew.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.beanbrew.dao.DeleteReviewDAO;
import com.beanbrew.dao.FetchReviewsDAO;
import com.beanbrew.dao.SubmitReviewDAO;
import com.beanbrew.model.Review;
import com.beanbrew.model.User;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/review" })
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

        String success = (String) request.getSession().getAttribute(MessageKeysUtil.SUCCESS);
        String error = (String) request.getSession().getAttribute(MessageKeysUtil.ERROR);
        if(success != null){
            request.setAttribute(MessageKeysUtil.SUCCESS, success);
            request.getSession().removeAttribute(MessageKeysUtil.SUCCESS);
        }
        if (error != null){
            request.setAttribute(MessageKeysUtil.ERROR, error);
            request.getSession().removeAttribute(MessageKeysUtil.ERROR);
        }

        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
        String errorRating = (String) request.getSession().getAttribute("errorRating");
        String errorBoth = (String) request.getSession().getAttribute("errorBoth");

        if (errorMessage != null || errorRating != null || errorBoth != null){
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("errorRating", errorRating);
            request.setAttribute("errorBoth", errorBoth);
            request.getSession().removeAttribute("errorMessage");
            request.getSession().removeAttribute("errorRating");
            request.getSession().removeAttribute("errorBoth");
        }

        try {
            FetchReviewsDAO dao = new FetchReviewsDAO();
            String pageParam = request.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            if (page < 1) page = 1;

            int totalReviews = dao.count();
            int totalPages= (int) Math.ceil((double) totalReviews / 6);
            if (totalPages < 1) totalPages = 1;
            if (page > totalPages) page =totalPages;

            request.setAttribute("reviews", dao.fetchPaged(page));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/review.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

        User currentUser = SessionUtil.getAttribute(request, "currentUser", User.class);

        if(currentUser == null){
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)){
            String reviewIdStr = request.getParameter("reviewId");
            if (reviewIdStr != null){
                try {
                    int reviewId = Integer.parseInt(reviewIdStr);
                    new DeleteReviewDAO().delete(reviewId, currentUser.getUserId());
                } catch(Exception e){
                    e.printStackTrace();
                }
            }
            response.sendRedirect(request.getContextPath() + "/review");
            return;
        }

        String message = request.getParameter("message");
        String ratingStr = request.getParameter("rating");

        boolean noMessage = (message == null || message.trim().isEmpty());
        boolean noRating = (ratingStr == null || ratingStr.equals("0"));

        if (noMessage && noRating) {
            request.getSession().setAttribute("errorBoth", "Please include a review and rating.");
            response.sendRedirect(request.getContextPath() + "/review");
            return;
        } else if (noMessage) {
            request.getSession().setAttribute("errorMessage", "Please include a message with the rating.");
            response.sendRedirect(request.getContextPath() + "/review");
            return;
        } else if (noRating) {
            request.getSession().setAttribute("errorRating", "Please include a rating as well.");
            response.sendRedirect(request.getContextPath() + "/review");
            return;
        }

        Review review = new Review();
        review.setUserId(currentUser.getUserId());
        review.setMessage(message.trim());
        review.setRating(Integer.parseInt(ratingStr));

        try {
            boolean success = new SubmitReviewDAO().submit(review);
            if (success) {
                request.getSession().setAttribute(MessageKeysUtil.SUCCESS, "Your review has been posted. Thank you!");
            } else {
                request.getSession().setAttribute(MessageKeysUtil.ERROR, "Something went wrong. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute(MessageKeysUtil.ERROR, "Database error. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/review");
    }
}