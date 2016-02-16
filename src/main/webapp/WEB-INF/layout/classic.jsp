<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras"
	prefix="tilesx"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<tilesx:useAttribute name="current" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.4/css/bootstrap-select.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.4/js/bootstrap-select.min.js"></script>

<script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>

<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">

<script src="http://code.highcharts.com/highcharts.js"
	type="text/javascript"></script>

<script src="http://code.highcharts.com/modules/exporting.js"
	type="text/javascript"></script>

<title><tiles:getAsString name="title" /></title>
</head>
<body>
	<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href='<spring:url value="/"/>'>MUM Scrum</a>
		</div>
		<ul class="nav navbar-nav">
			<security:authorize access="hasRole('ROLE_ADMIN')">
				<li class="${current == 'employees' ? 'active' : ''}"><a
					href='<spring:url value="/admin.html"/>'>Employees</a></li>
			</security:authorize>
			<security:authorize access="hasRole('ROLE_DEV')">
				<li class="${current == 'devUserStory' ? 'active' : ''}"><a
					href='<spring:url value="/dev_userstory.html"/>'>Developing US</a></li>
			</security:authorize>
			<security:authorize access="hasRole('ROLE_TEST')">
				<li class="${current == 'testUserStory' ? 'active' : ''}"><a
					href='<spring:url value="/test_userstory.html"/>'>Testing US</a></li>
			</security:authorize>
			<security:authorize access="hasRole('ROLE_SM')">
				<li class="${current == 'mus' ? 'active' : ''}"><a
					href='<spring:url value="/master_userstory.html"/>'>Managing US</a></li>
				<li class="${current == 'ms' ? 'active' : ''}"><a
					href='<spring:url value="/master_sprint.html"/>'>Sprint</a></li>
				<li class="${current == 'mbc' ? 'active' : ''}"><a
					href='<spring:url value="/master_burndownChart.html" />'>BD
						chart</a></li>
			</security:authorize>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<security:authorize access="!isAuthenticated()">
				<li><a href='<spring:url value="/loginpage.html"/>'>Log in</a></li>
			</security:authorize>
			<security:authorize access="isAuthenticated()">
				<li class="${current == 'profile' ? 'active' : ''}"><a
					href='<spring:url value="/profile.html"/>'><span
						class="glyphicon glyphicon-user"></span> Profile</a></li>
				<li><a href="/logout"><span
						class="glyphicon glyphicon-log-out"></span> Logout</a></li>
			</security:authorize>
		</ul>
	</div>
	</nav>
	<tiles:insertAttribute name="body"></tiles:insertAttribute>
	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
</body>
</html>