<%@page contentType="text/html; charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:bundle basename="com.examples.domain.Person">
<html>
<body>
<h1>Formio Getting Started</h1>

<c:set var="fields" value="${personForm.fields}"/>
<c:set var="fieldMsgs" value="${personForm.validationResult.fieldMessages}" />
<form action="<c:url value="/"/>" method="post">
	<div>
		<label><fmt:message key="${fields.firstName.labelKey}"/>
			<input type="text" name="${fields.firstName.name}" value="${fields.firstName.value}"/>
		</label>
	</div>
	<div>
		<label><fmt:message key="${fields.lastName.labelKey}"/>
			<input type="text" name="${fields.lastName.name}" value="${fields.lastName.value}"/>
		</label>
	</div>
	<div>
		<label><fmt:message key="${fields.email.labelKey}"/>
			<input type="text" name="${fields.email.name}" value="${fields.email.value}"/>
		</label>
		<c:forEach var="message" items="${fieldMsgs[fields.email.name]}">
			<div class="${message.severity.styleClass}"><c:out value="${message.text}" /></div>
		</c:forEach>
	</div>
	<p><fmt:message key="${personForm.nested['contactAddress'].labelKey}"/>:</p>
	<c:set var="addressFields" value="${personForm.nested['contactAddress'].fields}"/>
	<div>
		<label><fmt:message key="${addressFields.street.labelKey}"/>
			<input type="text" name="${addressFields.street.name}" value="${addressFields.street.value}"/>
		</label>
	</div>
	<div>
		<label><fmt:message key="${addressFields.city.labelKey}"/>
			<input type="text" name="${addressFields.city.name}" value="${addressFields.city.value}"/>
		</label>
	</div>
	<div>
		<label><fmt:message key="${addressFields.zipCode.labelKey}"/>
			<input type="text" name="${addressFields.zipCode.name}" value="${addressFields.zipCode.value}"/>
		</label>
	</div>
	<button name="submit" type="submit">Submit</button>
</form>

</body>
</html>
</fmt:bundle>
