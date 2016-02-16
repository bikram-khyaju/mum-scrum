<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="container">

	<div class="jumbotron"></div>

	<div class="col-md-9">

		<div class="row edit-sprint">
			<div class="col-md-4">
				<h4>Name</h4>
			</div>
			<div class="col-md-6">
				<h5>${sprint.name}</h5>
			</div>
			<div class="col-md-2 manage-editsprint">
				<security:authorize access="hasRole('ROLE_ADMIN')">

					<a
						class='btn btn-primary btn-sm pull-right glyphicon glyphicon-pencil'
						href="#" data-toggle="modal" data-target="#editSprint"
						data-placement="right" title="Edit General Informations"></a>
					<a
						class='btn btn-danger btn-sm pull-right glyphicon glyphicon-trash triggerRemove'
						data-toggle="tooltip" data-placement="right"
						title="Edit General Informations"
						href='<spring:url value="/sprint_detail/delete/${sprint.id}.html" />'></a>
				</security:authorize>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<h4>Description</h4>
			</div>
			<div class="col-md-6">
				<h5>${sprint.description}</h5>
			</div>
			<div class="col-md-2">&nbsp;</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<h4>Start Date</h4>
			</div>
			<div class="col-md-6">
				<h5>${sprint.startDate}</h5>
			</div>
			<div class="col-md-2">&nbsp;</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<h4>End Date</h4>
			</div>
			<div class="col-md-6">
				<h5>${sprint.endDate}</h5>
			</div>
			<div class="col-md-2">&nbsp;</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<h4>UserStory</h4>
			</div>
			<div class="col-md-6">
				<c:forEach items="${sprint.userStories}" var="us">
						${us.title}
						<br />
				</c:forEach>
			</div>
			<div class="col-md-2">&nbsp;</div>
		</div>

		<div class="modal fade" id="editSprint" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Edit Sprint</h4>
					</div>
					<div class="modal-body">
						<form:form commandName="sprint" cssClass="form-horizontal">
							<form:hidden path="id" />
							<%-- <form:hidden path="enabled" /> --%>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">Name</label>
								<div class="col-sm-10">
									<form:input path="name" cssClass="form-control"
										placeholder="Name" />
								</div>
							</div>
							<div class="form-group">
								<label for="description" class="col-sm-2 control-label">Description</label>
								<div class="col-sm-10">
									<form:input path="description" cssClass="form-control"
										placeholder="description" />
								</div>
							</div>
							<div class="form-group">
								<label for="startDate" class="col-sm-2 control-label">Start
									Date</label>
								<div class="col-sm-10">
									<form:input path="startDate" cssClass="form-control"
										placeholder="02/02/2016" />
								</div>
							</div>
							<div class="form-group">
								<label for="endDate" class="col-sm-2 control-label">End
									Date</label>
								<div class="col-sm-10">
									<form:input path="endDate" cssClass="form-control"
										placeholder="02/02/2016" />
								</div>
							</div>
							<div class="form-group">
								<label for="userStories" class="col-sm-2 control-label">User
									Stories</label>
								<div class="col-sm-10">
									<form:select path="userStories" multiple="true"
										cssClass="selectpicker">
										<form:options items="${sprint.userStories}" itemValue="id"
											itemLabel="title" />
										<form:options items="${userStories}" itemValue="id"
											itemLabel="title" />
									</form:select>
								</div>
							</div>
							<script>
								$(function() {
									$("#startDate").datepicker(
											{
												defaultDate : +9,
												dayNamesMin : [ "So", "Mo",
														"Di", "Mi", "Do", "Fr",
														"Sa" ],
												duration : "slow"
											});
								});
								$(function() {
									$("#endDate").datepicker(
											{
												defaultDate : +9,
												dayNamesMin : [ "So", "Mo",
														"Di", "Mi", "Do", "Fr",
														"Sa" ],
												duration : "slow"
											});
								});
							</script>

							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Cancel</button>
								<input type="submit" class="btn btn-primary" name="submit"
									value="Update">
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- Remove Sprint -->
<div class="modal fade" id="modalRemove" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Remove Sprint</h4>
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
	$(document).ready(
			function() {

				$(".edit-sprint").hover(function() {
					$(".manage-editsprint").show();
				}, function() {
					$(".manage-editsprint").hide();
				});
				$(".triggerRemove").click(
						function(e) {
							e.preventDefault();
							$("#modalRemove .removeBtn").attr("href",
									$(this).attr("href"));
							$("#modalRemove").modal();
						});

				$(".add-sprint").validate(
						{
							rules : {
								name : {
									required : true
								},
								description : {
									required : true
								},
								userStories : {
									required : true
								},
								startDate : {
									required : true
								},
								endDate : {
									required : true
								}
							},
							highlight : function(element) {
								$(element).closest(".form-group").removeClass(
										"has-success").addClass("has-error");
							},
							unhighlight : function(element) {
								$(element).closest(".form-group").removeClass(
										"has-error").addClass("has-success");
							},
							messages : {
								name : {
									required : "Name is required"
								},
								description : {
									required : "Description is required"
								},
								userStories : {
									requred : "You must assign a userstory"
								},
								startDate : {
									required : "Start Date is required"
								},
								endDate : {
									required : "End Date is required"
								}

							}

						});

			});
	function view(link) {
		document.location.href = link;
	}
</script>
