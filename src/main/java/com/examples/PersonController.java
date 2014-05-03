package com.examples;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.formio.FormData;
import net.formio.FormMapping;
import net.formio.Forms;
import net.formio.ParamsProvider;
import net.formio.servlet.HttpServletRequestParams;
import net.formio.validation.ValidationResult;

import com.examples.domain.Person;

/**
 * Servlet implementation class PersonController
 */
@WebServlet("/")
public class PersonController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final FormMapping<Person> personForm = 
		Forms.automatic(Person.class, "person").build();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		FormData<Person> formData = null;
		if (request.getParameter("submit") != null) {
			// Form was submitted
			ParamsProvider params = new HttpServletRequestParams(request);
			formData = personForm.bind(params);
			if (formData.isValid()) {
				// End of processing: Store edited person and redirect:
				Person person = formData.getData(); // store this person...
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/?success=1"));
				return;
			}
			// else show form with validation errors - formData holds the current edited person in 
			// formData.getData() and validation messages in formData.getValidationResult()
		} else {
			// no submission, render form with initial data
			Person person = new Person();
			person.setFirstName("John");
			formData = new FormData<Person>(person, ValidationResult.empty);
		}
	 		
		// Fill form definition with data and push the resulting filled form to the template
		FormMapping<Person> filledForm = personForm.fill(formData);
	 	request.setAttribute("personForm", filledForm);
	 	request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
	}

}
