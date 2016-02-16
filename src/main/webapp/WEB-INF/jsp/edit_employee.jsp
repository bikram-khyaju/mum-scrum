<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="container">
	<form class="form-horizontal" action="#" method="post">
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">Name</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="name" placeholder="Name">
			</div>
		</div>
		<div class="form-group">
			<label for="address" class="col-sm-2 control-label">Address</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="address"
					placeholder="1000 N 4TH ST">
			</div>
		</div>
		<div class="form-group">
			<label for="contact" class="col-sm-2 control-label">Contact</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="contact"
					placeholder="9876543210">
			</div>
		</div>
		<div class="form-group">
			<label for="email" class="col-sm-2 control-label">Email</label>
			<div class="col-sm-10">
				<input type="email" class="form-control" id="email"
					placeholder="email@email.com">
			</div>
		</div>
		<div class="form-group">
			<label for="username" class="col-sm-2 control-label">Username</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="username"
					placeholder="Username">
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-sm-2 control-label">Password</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="password"
					placeholder="********">
			</div>
		</div>
		<div class="form-group">
			<label for="confirm_password" class="col-sm-2 control-label">Confirm
				Password</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="confirm_password"
					placeholder="********">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<a href='<spring:url value="/admin.html"/>' class="btn btn-default">Cancel</a>
				<button type="submit" class="btn btn-primary">Update</button>
			</div>
		</div>
	</form>
</div>
