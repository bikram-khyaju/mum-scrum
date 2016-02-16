<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/layout/taglibs.jsp"%>

<div>
	<ul class="pager">
		<li><a href="#" data-toggle="modal"
			data-target="#newEmployeeForm">Add New Employee</a></li>
	</ul>
</div>
<div class="container" id="bodyContainer">
	<c:if test="${!empty employeesList}">
		<table
			class="table table-bordered table-striped table-hover table-responsive">
			<thead>
				<tr>
					<th>Name</th>
					<th>Address</th>
					<th>Contact</th>
					<th>Email</th>
					<th>Username</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${employeesList}" var="employee">
					<tr onmouseover="" style="cursor: pointer;"
						onclick="view('<spring:url value="/employee_detail/${employee.id}.html"/>')">
						<td>${employee.name}</td>
						<td>${employee.address}</td>
						<td>${employee.contact}</td>
						<td>${employee.email}</td>
						<td>${employee.username}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>

<!-- Modal -->
<div class="modal fade" id="newEmployeeForm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Add New Employee</h4>
			</div>
			<div class="modal-body">
				<form:form commandName="employee"
					cssClass="form-horizontal add-employee" id="add-employee">
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">Name</label>
						<div class="col-sm-10">
							<form:input path="name" cssClass="form-control"
								placeholder="Name" />
							<form:errors path="name" />
						</div>
					</div>
					<div class="form-group">
						<label for="address" class="col-sm-2 control-label">Address</label>
						<div class="col-sm-10">
							<form:input path="address" cssClass="form-control"
								placeholder="1000 N 4TH ST, IA, USA" />
							<form:errors path="address" />
						</div>
					</div>
					<div class="form-group">
						<label for="contact" class="col-sm-2 control-label">Contact</label>
						<div class="col-sm-10">
							<form:input path="contact" cssClass="form-control"
								placeholder="9876543210" />
							<form:errors path="contact" />
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<form:input path="email" cssClass="form-control"
								placeholder="email@email.com" />
							<form:errors path="email" />
						</div>
					</div>
					<div class="form-group">
						<label for="roles" class="col-sm-2 control-label">Roles</label>
						<div class="col-sm-10">
							<form:select path="roles" items="${rolesList}"
								cssClass="selectpicker" multiple="true" itemLabel="name"
								itemValue="id" />
						</div>
					</div>
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">Username</label>
						<div class="col-sm-10">
							<form:input path="username" cssClass="form-control"
								placeholder="Username" />
							<form:errors path="username" />
						</div>
					</div>
					<div class="form-group">
						<label for="password" class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<form:password path="password" cssClass="form-control"
								placeholder="password" />
							<form:errors path="password" />
						</div>
					</div>
					<div class="form-group">
						<label for="confirm_password" class="col-sm-2 control-label">Confirm
							Password</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="confirm_password"
								name="confirm_password" placeholder="********">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						<input type="submit" class="btn btn-primary" name="submit"
							value="Save">
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$(".add-employee")
								.validate(
										{
											rules : {
												name : {
													required : true
												},
												address : {
													required : true
												},
												contact : {
													required : true,
													number : true,
													minlength : 6,
													maxlength : 10
												},
												email : {
													required : true,
													email : true,
													remote : {
														url : "<spring:url value='/addEmployee/availableEmail.html'  />",
														type : "get",
														data : {
															email : function() {
																return $(
																		"#email")
																		.val();
															}
														}
													}
												},
												roles : {
													required : true
												},
												username : {
													required : true,
													remote : {
														url : "<spring:url value='/addEmployee/availableUsername.html' />",
														type : "get",
														data : {
															username : function() {
																return $(
																		"#username")
																		.val();
															}
														}
													}
												},
												password : {
													required : true,
													minlength : 5
												},
												confirm_password : {
													required : true,
													minlength : 5,
													equalTo : "#password"
												}
											},
											highlight : function(element) {
												$(element).closest(
														".form-group")
														.removeClass(
																"has-success")
														.addClass("has-error");
											},
											unhighlight : function(element) {
												$(element)
														.closest(".form-group")
														.removeClass(
																"has-error")
														.addClass("has-success");
											},
											messages : {
												name : {
													required : "Name is required!"
												},
												address : {
													required : "Address is required!"
												},
												contact : {
													required : "Contact is required!",
													number : "Contact must be number",
													minlength : "Contact must be of more than 6 digits",
													maxlength : "Contact must be of less than 10 digits"
												},
												email : {
													required : "Email is required!",
													email : "Please enter valid email address!",
													remote : "Email already exists!"
												},
												roles : {
													required : "Please select an role!"
												},
												username : {
													required : "Username is required!",
													remote : "Username already exists!"
												},
												password : {
													required : "Password is required!",
													minlength : "Password must be of 5 characters!"
												},
												confirm_password : {
													required : "Enter the password again!",
													minlength : "Password must be of 5 characters!",
													equalTo : "Password didn't matched!"
												}
											}
										});
					});

	function view(link) {
		document.location.href = link;
	}
</script>
