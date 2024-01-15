<?php $this->layout("layouts/base"); ?>

<form class="form-horizontal" id="profilefrom">
  <fieldset>    
    <legend><center>ChangPassword</center></legend>
    <div class="form-group">
      <label for="inputUsername" class="col-lg-4 control-label">Username</label>
      <div class="col-lg-4">
        <input type="text" class="form-control" id="username" name="username" placeholder="Username" required value='<?php echo $_SESSION["user"]; ?>'; readonly>
      </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-lg-4 control-label">Password</label>
      <div class="col-lg-4">
        <input type="Password" class="form-control" id="password" name="password" placeholder="Password" required>
      </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-lg-4 control-label">New Password</label>
      <div class="col-lg-4">
        <input type="Password" class="form-control" id="newpassword" name="newpassword" placeholder="Password" required>
      </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-lg-4 control-label">Confirm New Password</label>
      <div class="col-lg-4">
        <input type="Password" class="form-control" id="connewpassword" name="connewpassword" placeholder="Password" required>
      </div>
    </div>
    <div class="form-group">
      <div class="col-lg-4 col-lg-offset-4">
        <button class="btn btn-primary" type="submit"><strong>Submit</strong></button>
        <button class="btn " type="reset"><strong>Cancel</strong></button>
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
  $('#profilefrom').submit(function(e){
      e.preventDefault();
      
          if ("<?php echo $_SESSION["pass"]; ?>"!=$('#password').val()) {
              gotify("Please Check Password","danger");
          }else if($('#password').val()==$('#newpassword').val()){
              gotify("Please Check Password","danger");
          }else if($('#newpassword').val()!=$('#connewpassword').val()){
              gotify("Please Check New Password & Comfirm Password","danger");
          }else{
            $.ajax({
              url : base_url + '/api/user/changpassword',
              type : 'post',
              cache : false,
              dataType : 'json',
              data : $('form#profilefrom').serialize()
            })
            .done(function(data) {
              if (data.status != 200) {
                gotify(data.message,"danger");
                $('#loginForm').trigger('reset');
              }else{
                gotify(data.message,"success");
                window.location = base_url + '/api/user/logout';
              }
            });
          }
      
  });
</script>