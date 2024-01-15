<?php $this->layout("layouts/base"); ?>

<form class="form-horizontal" id="loginForm">
  <fieldset>    
    <legend><center>CN-Request</center></legend>
    <div class="form-group">
      <label for="inputUsername" class="col-lg-4 control-label">Username</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="inputUsername" name="inputUsername" placeholder="Username" required>
      </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-lg-4 control-label">Password</label>
      <div class="col-lg-4">
        <input type="Password" class="form-control" id="inputPassword" name="inputPassword" placeholder="Password" required>
      </div>
    </div>
    <div class="form-group">
      <div class="col-lg-4 col-lg-offset-4">
        <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-log-in"></span> Login</button>
      </div>
    </div>
        <br><br><br><br><br><br><br>
        <legend></legend>
        <center>
          <footer>
            <p>Copyright © 2017 EA Team @ Deestone Co., Ltd</p>
            <p>Contact information : <a href="mailto:it_ea@deestone.com">
            IT_EA@deestone.com</a></p>
          </footer>
        </center>
      
   </fieldset>
</form>

<script type="text/javascript">
  $('#inputUsername').focus();
	$('#loginForm').submit(function(e){
		e.preventDefault();
			$.ajax({
		        url : base_url + '/api/user/login',
		        type : 'post',
		        cache : false,
		        dataType : 'json',
		        data : $('form#loginForm').serialize()
	        })
	        .done(function(data) {
            if (data.active != 1) {
              gotify("Changpassword","info");
              window.location = base_url + 'profile';

            }else if(data.status != 200) {
              gotify(data.message,"danger");
              $('#loginForm').trigger('reset');
		        }else{
              gotify(data.message,"success");
              window.location = base_url + '';
		        }
	        });
    	return false;
	});
</script>