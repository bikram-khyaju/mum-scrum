<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form:form method="post" commandName="sprint">

		<div class="form-group">
			<label for="name">Name</label>
			<form:input path="name" />
		</div>
		<div class="form-group">
			<label for="description">Description</label>
			<form:input path="description" />
		</div>
		<div class="form-group">
			<label for="startDate">Start Date</label>
			<form:input path="startDate" id="startDate" />
		</div>
		<script>
			$(document).ready(function() {
				$(function() {
					$("#startDate").datepicker();
				});
			});
		</script>

		<input type="submit" class="btn btn-default" value="save">

	</form:form>
</body>
</html>