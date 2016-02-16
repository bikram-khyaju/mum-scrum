<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="container">

	<div class="jumbotron"></div>
	<div class="col-md-3"></div>

	<div class="col-md-9">
		<c:if test="${!empty userstory}">
			<div class="row editInfo">
				<div class="col-md-4">
					<h4>Title</h4>
				</div>
				<div class="col-md-6">
					<h5>${userstory.title}</h5>
				</div>
				<div class="col-md-2 manage-editInfo">
					<security:authorize
						access="hasAnyRole('ROLE_SM','ROLE_DEV','ROLE_TEST')">
						<a
							class='btn btn-primary btn-sm pull-right glyphicon glyphicon-pencil'
							data-toggle="modal" data-placement="right"
							title="Edit General Informations" href="#editUserStoryForm"></a>
					</security:authorize>

					<security:authorize access="hasRole('ROLE_SM')">
						<spring:url value="delete/${userstory.id}.html" var="url"
							htmlEscape="true" />
						<a
							class='btn btn-danger btn-sm pull-right glyphicon glyphicon-trash triggerRemove'
							data-toggle="tooltip" data-placement="right" title="Delete"
							href="${url}"></a>
					</security:authorize>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>Descriptions</h4>
				</div>
				<div class="col-md-6">
					<h5>${userstory.description}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>Status</h4>
				</div>
				<div class="col-md-6">
					<h5>${userstory.status}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>Priority</h4>
				</div>
				<div class="col-md-6">
					<h5>${userstory.priority}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<h4>Assigned To</h4>
				</div>
				<div class="col-md-6">
					<h5>${userstory.employee.name}</h5>
				</div>
				<div class="col-md-2">&nbsp;</div>
				<div class="col-md-2 manage-editRoles"></div>
			</div>
		</c:if>
	</div>

</div>

<!-- Modal -->
<div class="modal fade" id="editUserStoryForm" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Edit UserStory</h4>
			</div>
			<div class="modal-body">
				<form:form commandName="userStory"
					cssClass="form-horizontal edit_us" action="/master_userstory.html	">
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">Title</label>
						<form:hidden path="id" value="${userstory.id}" />
						<div class="col-sm-10">
							<form:input path="title" cssClass="form-control"
								value="${userstory.title}" />
						</div>

					</div>
					<div class="form-group">
						<label for="description" class="col-sm-2 control-label">Descriptions</label>
						<div class="col-sm-10">
							<form:input path="description" value="${userstory.description}"
								cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="status" class="col-sm-2 control-label">Status</label>
						<div class="col-sm-10">
							<form:select path="status" cssClass="selectpicker">
								<c:forEach var="i" items="${listStatus}">
									<c:if test="${i eq userstory.status}">
										<form:option value="${i}" label="${i}" selected="true" />
									</c:if>
									<c:if test="${i ne userstory.status}">
										<form:option value="${i}" label="${i}" />
									</c:if>
								</c:forEach>

							</form:select>
						</div>
					</div>

					<div class="form-group">
						<label for="priority" class="col-sm-2 control-label">Priority</label>
						<div class="col-sm-10">
							<form:select path="priority" cssClass="selectpicker">
								<c:forEach var="i" items="${listPriority}">
									<c:if test="${i eq userstory.priority}">
										<form:option value="${i}" label="${i}" selected="true" />
									</c:if>
									<c:if test="${i ne userstory.priority}">
										<form:option value="${i}" label="${i}" />
									</c:if>
								</c:forEach>
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
								<c:if test="${userstory.assignedAsDev eq true}">
									<c:forEach items="${listDeveloper}" var="i">
										<c:if test="${i.name eq userstory.employee.name }">
											<form:option value="${userstory.employee.id}"
												label="${userstory.employee.name}" selected="true" />
											<script>
												window.onload = function() {
													enableDisable();
												}
											</script>
										</c:if>
										<c:if test="${i.name  ne userstory.employee.name }">
											<form:option value="${i.id}" label="${i.name}" />
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${userstory.assignedAsDev ne true}">
									<form:options items="${listDeveloper}" itemLabel="name"
										itemValue="id" />
								</c:if>
							</form:select>
							<form:select path="employee" cssClass="selectpicker"
								onchange="enableDisable()" id="test">
								<form:option value="NONE" label="Testers(None)" />
								<c:if test="${userstory.assignedAsDev eq false}">
									<c:forEach items="${listTester}" var="i">
										<c:if test="${i.name eq userstory.employee.name }">
											<form:option value="${userstory.employee.id}"
												label="${userstory.employee.name}" selected="true" />
											<script>
												window.onload = function() {
													enableDisable();
												}
											</script>
										</c:if>
										<c:if test="${i.name  ne userstory.employee.name }">
											<form:option value="${i.id}" label="${i.name}" />
										</c:if>
									</c:forEach>

								</c:if>
								<c:if test="${userstory.assignedAsDev eq true}">
									<form:options items="${listTester}" itemLabel="name"
										itemValue="id" />
								</c:if>


							</form:select>
						</div>

					</div>
					<form:hidden path="assignedAsDev" id="as_dev" />

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-primary">Update</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>

<!-- Remove User Modal -->
<div class="modal fade" id="modalRemove" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Remove User Story</h4>
			</div>
			<div class="modal-body">Are you sure?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<a href="" class="btn btn-danger removeBtn">Remove</a>
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
		$(".editRoles").hover(function() {
			$(".manage-editRoles").show();
		}, function() {
			$(".manage-editRoles").hide();
		});
	});
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
	console.log($("#title").val());
	console.log("${userstory.title}");

	$(document)
			.ready(
					function() {
						$(".triggerRemove").click(
								function(e) {
									e.preventDefault();
									$("#modalRemove .removeBtn").attr("href",
											$(this).attr("href"));
									$("#modalRemove").modal();
								});

						$(".edit_us")
								.validate(
										{
											rules : {
												title : {
													required : true,
													remote : {
														url : "<spring:url value ='/uniqueEdit.html'/>",
														type : "get",
														data : {
															newtitle : function() {
																return $(
																		"#title")
																		.val();
															},
															oldtitle : function() {
																return "${userstory.title}";
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
													remote : "Title must be unique"
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