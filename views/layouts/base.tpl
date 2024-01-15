<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
  <meta charset="UTF-8">
  <link rel="shortcut icon" type="image/png" href="<?php echo root; ?>/logo.png"/>
  <title>CN-Request</title>
  <link rel="manifest" href="<?php echo root; ?>/assets/manifest.json">
  <!-- CSS -->
  <link rel="stylesheet" href="<?php echo root; ?>/assets/css/normalize.css" />
  <link rel="stylesheet" href="<?php echo root; ?>/assets/jqwidgets/styles/jqx.base.css"/>
  <link rel="stylesheet" href="<?php echo root; ?>/assets/jqwidgets/styles/themeorange2.css"/>
  <link rel="stylesheet" href="<?php echo root; ?>/assets/css/multiple-select.css" />
  <link rel="stylesheet" href="<?php echo root; ?>/assets/css/jquery-ui.min.css">
  <link rel="stylesheet" href="<?php echo root; ?>/assets/css/app.css"/>
  <link rel="stylesheet" href="<?php echo root; ?>/assets/css/bootstrap.min.css" />
  <link rel="stylesheet" href="<?php echo root; ?>/bootstrap/superhero.min.css" />
  <link rel="stylesheet" href="<?php echo root; ?>/assets/sweetalert-master/dist/sweetalert.css">
  <!-- JS -->
  <script>
    var base_url = '<?php echo root;?>';
  </script>
  <script src="<?php echo root; ?>/assets/sweetalert-master/dist/sweetalert.min.js"></script> 
  <script src="<?php echo root; ?>/assets/js/jquery-1.12.0.min.js"></script>
  <script src="<?php echo root; ?>/assets/js/jquery-ui.min.js"></script>
  <script src="<?php echo root; ?>/assets/js/bootstrap.min.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxcore.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxinput.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxdata.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxbuttons.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxbuttongroup.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxscrollbar.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxmenu.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxlistbox.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxdropdownlist.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.selection.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.columnsresize.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.filter.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.sort.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.pager.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.edit.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxgrid.grouping.js"></script> 
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxwindow.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxinput.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxcheckbox.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxpanel.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxcombobox.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/jqxdropdownbutton.js"></script>
  <script src="<?php echo root; ?>/assets/jqwidgets/globalization/globalize.js"></script>
  <script src="<?php echo root; ?>/assets/js/fastclick.js"></script>
  <script src="<?php echo root; ?>/assets/js/jquery.maskMoney.min.js"></script>
  <script src="<?php echo root; ?>/assets/js/gotify.min.js"></script>
  <script src="<?php echo root; ?>/assets/js/gojax.min.js"></script>
  <script src="<?php echo root; ?>/assets/js/multiple-select.js"></script>
  <script src="<?php echo root; ?>/assets/js/jqx_mod.js"></script>
  <script src="<?php echo root; ?>/assets/js/app.js"></script>


</head>
<style>
    .glyphicon-remove-circle {
       color: #FFFFFF; 
    }
    /*input[type="text"]
    {
        font-family:"Browallia New";
        font-size:22px;
    }*/
</style>
<body>
<!-- GOTIFY -->
  <div class="gotify-overlay"></div>

  <div class="gotify">
      <div class="gotify-wrap">
          <div class="close-gotify" onclick="return close_gotify()"></div>
          <div class="gotify-content"></div>
      </div>
  </div>

<nav class="navbar navbar-default">
  <div class="container-fluid">

    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <?php  if ($_SESSION["active"]==1){?>
      <a class="navbar-brand" href="./"><img  src="./bootstrap/img/DN2.png" style="padding-left:10px;height:15px; width:auto;" /></a>
      <?php } ?>
      <?php  if ($_SESSION["active"]==0){?>
      <a class="navbar-brand" href="#"><img  src="./bootstrap/img/DN2.png" style="padding-left:10px;height:15px; width:auto;" /></a>
      <?php } ?>
     <!--  <a class="navbar-brand" href="#">Brand</a> -->
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
      <ul class="nav navbar-nav">
       <?php  if (isset($_SESSION["user"])): ?>
        <?php  if ($_SESSION["active"]==1){?>
        <li><a href="./">Home</a></li>
        
        <?php  if ($_SESSION["levelid"]<=2){?>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Setup <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="./subject">Subject</a></li>
            <li><a href="./customer">Customer</a></li>
            <li class="divider"></li>
            <?php  if ($_SESSION["user"]=="admin"){?>
            <li><a href="./user">User Management</a></li>
            <?php } ?>
            <li><a href="./company">Company</a></li>
            <li><a href="./department">Department</a></li>
            <li><a href="./currency">Currency</a></li>
          </ul>         
        </li>
        <?php } ?>
        <?php } ?>
      <?php endif ?>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      <?php  if (isset($_SESSION["user"])): ?>
         <li><a href="./profile"><?php echo $_SESSION["user"]; ?> <span class="glyphicon glyphicon-user"></span></a></li>
         <li><a href="<?php echo root; ?>/api/user/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      <?php else: ?>
         <li><a href="./login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      <?php endif ?>
      </ul>
    </div>
  </div>
</nav>

  <div class="container-fluid" style="margin: 20px 0px;">
    <?php echo $this->section("content"); ?>
  </div>
</body>
</html>