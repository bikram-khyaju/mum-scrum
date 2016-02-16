<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="pager">
		<li><a href="#" data-toggle="modal" data-target="#newSprint">Add
				New Sprint</a></li>
	</ul>
</div>
<div class="container" id="bodyContainer">
	<c:if test="${!empty sprint}">
		<table
			class="table table-bordered table-striped table-hover table-responsive">
			<thead>
				<tr>

					<th>Name</th>
					<th>Description</th>
					<th>Start Date</th>
					<th>End Date</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${sprint}" var="sprint">
					<tr onmouseover="" style="cursor: pointer;"
						onclick="view('<spring:url value="/sprint_detail/${sprint.id}.html"/>')">

						<td>${sprint.name}</td>
						<td>${sprint.description}</td>
						<td>${sprint.startDate}</td>
						<td>${sprint.endDate}</td>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>

<div class="modal fade" id="newSprint" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">New Sprint</h4>
			</div>
			<div class="modal-body">
				<form:form method="post" commandName="addsprint"
					cssClass="add-sprint form-horizontal">
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
							<form:select path="userStories" items="${userStories}"
								cssClass="selectpicker" multiple="true" itemLabel="title"
								itemValue="id" />
						</div>
					</div>
					<script>
						$(function() {
							$("#startDate").datepicker(
									{
										defaultDate : +9,
										dayNamesMin : [ "So", "Mo", "Di", "Mi",
												"Do", "Fr", "Sa" ],
										duration : "slow"
									});
						});
						$(function() {
							$("#endDate").datepicker(
									{
										defaultDate : +9,
										dayNamesMin : [ "So", "Mo", "Di", "Mi",
												"Do", "Fr", "Sa" ],
										duration : "slow"
									});
						});
					</script>
					<input type="submit" class="btn btn-primary" name="submit"
						value="save">

				</form:form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(
			function() {
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