<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div>
	<ul class="pager">
		<li><a href="#" data-toggle="modal"
			data-target="#newUserStoryForm">Add New User Story</a></li>
	</ul>
</div>

<div class="container" id="bodyContainer">
	<c:if test="${!empty listUserStory}">
		<table
			class="table table-bordered table-striped table-hover table-responsive">
			<tr>
				<th>Title</th>
				<th>Descriptions</th>
				<th>Status</th>
				<th>Priority</th>
				<th>Assigned To</th>
			</tr>
			<c:forEach items="${listUserStory}" var="us">
				<tr class='clickable-row' onmouseover="" style="cursor: pointer;"
					onclick="view('<spring:url value="/user_story_detail/${us.id}.html"/>')">
					<td>${us.title}</td>
					<td>${us.description}</td>
					<td>${us.status}</td>
					<td>${us.priority}</td>
					<td>${us.employee.name}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

	<!-- Modal -->

	<div class="modal fade" id="newUserStoryForm" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Add New UserStory</h4>
				</div>
				<div class="modal-body">
					<form:form commandName="userStory"
						cssClass="form-horizontal add_us">
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label">Title</label>
							<div class="col-sm-10">
								<form:input path="title" cssClass="form-control" />
								<form:errors path="title" />
							</div>
						</div>
						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">Descriptions</label>
							<div class="col-sm-10">
								<form:input path="description" cssClass="form-control" />
								<form:errors path="description" />
							</div>
						</div>
						<div class="form-group">
							<label for="status" class="col-sm-2 control-label">Status</label>
							<div class="col-sm-10">
								<form:select path="status" cssClass="selectpicker">
									<form:option value="OPEN">OPEN</form:option>
									<form:option value="ON_PROGRESS">ON_PROGRESS</form:option>
									<form:option value="CLOSE">CLOSE</form:option>
									<form:option value="AWAITING_FEEDBACK">AWAITING_FEEDBACK</form:option>
								</form:select>
							</div>
						</div>

						<div class="form-group">
							<label for="priority" class="col-sm-2 control-label">Priority</label>
							<div class="col-sm-10">
								<form:select path="priority" cssClass="selectpicker">
									<form:option value="LOW">LOW</form:option>
									<form:option value="MEDIUM">MEDIUM</form:option>
									<form:option value="HIGH">HIGH</form:option>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="Assign To" class="col-sm-2 control-label">Assign
								To</label>
							<div class="col-sm-10">

								<form:select id="dev" name="dev" path="employee"
									cssClass="selectpicker" label="Developers"
									onchange="enableDisable()">
									<form:option value="NONE" label="Developers(None)" />
									<form:options items="${listDeveloper}" itemLabel="name"
										itemValue="id" />
								</form:select>
								<form:select id="test" path="employee" cssClass="selectpicker"
									onchange="enableDisable()">

									<form:option value="NONE" label="Testers(None)" />
									<form:options items="${listTester}" itemLabel="name"
										itemValue="id" />
								</form:select>
							</div>
						</div>
						<form:hidden path="assignedAsDev" id="as_dev" />
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Cancel</button>
							<input type="submit" class="btn btn-primary" name="save"
								value="Save" />
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript">
	function enableDisable() {
		var dev = document.getElementById("dev");
		var selectedValue = dev.options[dev.selectedIndex].value;
		if (selectedValue != "NONE") {
			document.getElementById("test").disabled = true;

		} else {
			$('#as_dev').val('false');
			document.getElementById("test").disabled = false;
		}
		var test = document.getElementById("test");
		var selectedValue = test.options[test.selectedIndex].value;
		if (selectedValue != "NONE") {
			document.getElementById("dev").disabled = true;

		} else {
			document.getElementById("dev").disabled = false;
			$('#as_dev').val('true');
		}

	}
	function view(link) {
		document.location.href = link;
	}
	$(document)
			.ready(
					function() {
						$(".add_us")
								.validate(
										{
											rules : {
												title : {
													required : true,
													remote : {
														url : "<spring:url value ='/unique.html'/>",
														type : "get",
														data : {
															title : function() {
																return $(
																		"#title")
																		.val();
															}
														}
													}
												},
												description : {
													required : true,
													minlength : 20
												}

											},
											messages : {
												title : {
													required : "Title is required",
													remote : "Title already exists"
												},
												description : {
													required : "Description is required",
													minlength : "Please describe more"
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
											}

										});
					});
</script>
