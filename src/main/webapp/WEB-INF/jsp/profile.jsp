<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/layout/taglibs.jsp" %>

<div class="container">

	<div class="jumbotron"></div>
	<div class="col-md-3">
		<img alt="" src="" class="img-responsive"
			style="height: 200px; width: 200px">
	</div>

	<div class="col-md-9">
		<c:if test="${!empty employee}">
			<div class="row editInfo">
				<div class="col-md-4">
					<h4>Name</h4>
				</div>
				<div class="col-md-6">
					<h5>${employee.name}</h5>
				</div>
				<div class="col-md-2 manage-editInfo">
					<a
						class='btn btn-primary btn-sm pull-right glyphicon glyphicon-pencil'
						href="#" data-toggle="modal" data-target="#editEmployeeInfo"
						data-placement="right" title="Edit General Informations"></a>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>Address</h4>
				</div>
				<div class="col-md-6">
					<h5>${employee.address}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>Contact</h4>
				</div>
				<div class="col-md-6">
					<h5>${employee.contact}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>E-mail</h4>
				</div>
				<div class="col-md-6">
					<h5>${employee.email}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
			<div class="row editRoles">
				<div class="col-md-4">
					<h4>Roles</h4>
				</div>
				<div class="col-md-6">
					<h5>
						<c:forEach items="${employee.roles}" var="role">
										${role.name}
										<br>
						</c:forEach>
					</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
		</c:if>
	</div>

</div>

<!-- Modal -->
<div class="modal fade" id="editEmployeeInfo" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
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
				<form:form commandName="employee" cssClass="form-horizontal">
					<form:hidden path="id" />
					<form:hidden path="enabled" />
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">Name</label>
						<div class="col-sm-10">
							<form:input path="name" cssClass="form-control"
								placeholder="Name" />
						</div>
					</div>
					<div class="form-group">
						<label for="address" class="col-sm-2 control-label">Address</label>
						<div class="col-sm-10">
							<form:input path="address" cssClass="form-control"
								placeholder="1000 N 4TH ST, IA, USA" />
						</div>
					</div>
					<div class="form-group">
						<label for="contact" class="col-sm-2 control-label">Contact</label>
						<div class="col-sm-10">
							<form:input path="contact" cssClass="form-control"
								placeholder="9876543210" />
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<form:input path="email" cssClass="form-control"
								placeholder="email@email.com" />
						</div>
					</div>
					<form:select path="roles" items="${employee.roles}" itemValue="id"
						hidden="true" />
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">Username</label>
						<div class="col-sm-10">
							<form:input path="username" cssClass="form-control"
								placeholder="Username" />
						</div>
					</div>
					<div class="form-group">
						<label for="password" class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<form:password path="password" cssClass="form-control"
								placeholder="password" />
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
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						<input type="submit" class="btn btn-primary" name="submit"
							value="Update">
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$(".editInfo").hover(function() {
			$(".manage-editInfo").show();
		}, function() {
			$(".manage-editInfo").hide();
		});
	});
</script>