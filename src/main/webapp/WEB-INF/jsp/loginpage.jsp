<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container">
	<div class="jumbotron">
		<h1>MUMScrum</h1>
		<p class="lead">Welcome to MUMScrum! The only free SCRUM tool,
			developed by NEON group as a project for Software Development course
			from Maharishi University of Management.</p>
	</div>
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2 class="form-signin-heading">Please Log in</h2>
				</div>
				<div class="panel-body">
					<form class="form-signin" action="/login" method="post">
						<label for="username" class="sr-only">Username</label> <input
							type="text" id="username" name="username" class="form-control"
							placeholder="Username" required autofocus> <br> <label
							for="password" class="sr-only">Password</label> <input
							type="password" id="password" name="password"
							class="form-control" placeholder="Password" required> <br>
						<button class="btn btn-lg btn-primary btn-block" type="submit">Log
							in</button>
					</form>
				</div>

			</div>
		</div>
		<div class="col-md-2"></div>
	</div>
</div>
