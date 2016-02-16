<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
var selectedRowIndex = -1;
function createUserStoryForm(x){
	selectedRowIndex = x.rowIndex;
	document.getElementById("edit_title").innerHTML = x.cells[0].innerHTML;
	document.getElementById("edit_description").innerHTML = x.cells[1].innerHTML;
	document.getElementById("edit_estimation").value = x.cells[2].innerHTML;
	document.getElementById("edit_remaining").value = x.cells[3].innerHTML;
}
function OnSubmit(){
	var estimated = parseInt(document.getElementById("edit_estimation").value);
	var remaining = parseInt(document.getElementById("edit_remaining").value);
	if(estimated < 0 || remaining < 0 || remaining > estimated){
		alert("Wrong input");
		return false;
	}
	
	var strRequest = document.getElementById("edit_title").innerHTML;
	strRequest +=  "~" + estimated;
	strRequest +=  "~" + remaining;
	
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : "${home}updateUserStoryProgress.html",
		data : strRequest,
		//data : JSON.stringify(search),
		//dataType : 'json',
		timeout : 100000,
		success : function(data) {
			console.log("SUCCESS: ", data);
			alert("SUCCESS");
			var row = document.getElementById("userstory_table").rows[selectedRowIndex];
			row.cells[2].innerHTML = '' + estimated;
			row.cells[3].innerHTML = '' + remaining;
		},
		error : function(e) {
			console.log("ERROR: ", e);
			alert("ERROR");
		},
		done : function(e) {
			console.log("DONE");
		}
	});
	return true;
}
function OnCancel(){
	//alert("cancel");
	
}
</script>
<div class="container" id="bodyContainer">
	<table class="table" id="userstory_table">
		<thead>
			<tr>
				<th>Title</th>
				<th>Description</th>
				<th>Estimation</th>
				<th>Remaining</th>
				<th>Function</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dev_userstorylist}" var="us_es">
			<tr onclick="createUserStoryForm(this)">
				<td>${us_es.title}</td>
				<td>${us_es.description}</td>
				<td>${us_es.estimatedTime}</td>
				<td>${us_es.remainingTime}</td>
				<td><button type="button" data-toggle="modal"
						data-target="#myModal">Edit</button></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Edit User Story</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="control-label col-sm-2">Title:</label>
							<label class="control-label col-sm-10" id="edit_title" align="left"></label>
							<!-- 
							<div class="col-sm-10">
								<input class="form-control" id="title"
									value="title">
							</div>
							 -->
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" >Description:</label>
							<label class="control-label col-sm-10" id="edit_description" align="left"></label>
							<!-- 
							<div class="col-sm-10">
								<input class="form-control" id="description"
									value="description">
							</div>
							 -->
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="estimation">Estimation:</label>
							<div class="col-sm-10">
								<input type="number" min="0" step="1" class="form-control" id="edit_estimation"
									value="">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="remaining">Remaining:</label>
							<div class="col-sm-10">
								<input type="number" min="0" step="1" class="form-control" id="edit_remaining"
									value="">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" onclick="OnSubmit();">Submit</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" onclick="OnCancel();">Cancel</button>
				</div>
			</div>

		</div>
	</div>
</div>
