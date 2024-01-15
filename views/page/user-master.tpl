<?php $this->layout("layouts/base"); ?>
<h1>UserManagement</h1>
<button onclick="return modal_create_open()"  class="btn btn-default" data-backdrop="static" data-toggle="modal" data-target="#modal_create">Create</button>
<button class="btn btn-primary" id="edit">Update</button>
<button class="btn btn-danger" id="delete">Active</button>
<hr>
<div id="griduser"></div>
<!-- Create Modal -->
<div class="modal" id="modal_create" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-title">this title</h4>
      </div>
      <div class="modal-body">
        <form id="form_create" onsubmit="return submit_create_user()">
          
          <div class="form-group">

            <label for="user_employee">Employee</label>
            <div class="input-group">
              <input type="text" name="user_employee" id="user_employee" class="form-control" style="width: 300px;" readonly="ture">
              <button class="btn btn-primary" id="btn_employee" type="button">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
              </button>
            </div>
           
            <label for="username">Username</label>
            <input type="text" name="username" id="username" class="form-control" autocomplete="off" required>
            <label for="password">Password</label>
            <input type="text" name="password" id="password" class="form-control" autocomplete="off" required>
            <label for="fullname">Fullname</label>
            <input type="text" name="fullname" id="fullname" class="form-control" autocomplete="off" required>
            <label for="depid">Department</label>
            <select name="depid" id="depid" class="form-control" required></select>
            <label for="compid">Company</label>
            <select name="compid" id="compid" class="form-control" required></select>
            <label for="level">Level</label>
            <select name="level" id="level" class="form-control" required></select>
          </div>
          <input type="hidden" name="id">
        	<input type="hidden" name="form_type">

          <label>
            <button class="btn btn-primary">Save</button>
          </label>

        </form>
      </div>
    </div>
  </div>
</div>

<!-- dialog employee -->
<div class="modal" id="modal_employee" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <b>Employee</b>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
          </button>
        </div>
        
        <div class="modal-body">
          <div id="grid_empployee"></div>
        <hr>
        </div>

    </div>
  </div>
</div>

<script type="text/javascript">

  jQuery(document).ready(function($){
    griduser();

    $('#edit').on('click', function(e) {
        var rowdata = row_selected("#griduser");
        if (typeof rowdata !== 'undefined') {
          $('#modal_create').modal({backdrop: 'static'});
          $('input[name=form_type]').val('update');
          $('.modal-title').text('Update');
          $('input[name=username]').prop('readonly', true);
          $('input[name=id]').val(rowdata.UserID);
          $('input[name=user_employee]').val(rowdata.EMPID);
          $('input[name=username]').val(rowdata.Username);
          $('input[name=password]').val(rowdata.Password);
          $('input[name=fullname]').val(rowdata.FullName);

          gojax('get', base_url+'/api/department/all')
            .done(function(data) {
              $('#depid').html('');
              $.each(data, function(index, val) {
                 $('#depid').append('<option value="'+val.DepartmentID+'">'+val.DepartmentName+'</option>');
              });
              $('#depid').val(rowdata.DepartmentID);
            });
          gojax('get', base_url+'/api/company/all')
            .done(function(data) {
              $('#compid').html('');
              $.each(data, function(index, val) {
                 $('#compid').append('<option value="'+val.InternalCode+'">'+val.Description+'</option>');
              });
              $('#compid').val(rowdata.CompanyID);
            });
          gojax('get', base_url+'/api/level/all')
            .done(function(data) {
              $('#level').html('');
              $.each(data, function(index, val) {
                 $('#level').append('<option value="'+val.LevelID+'">'+val.Description+'</option>');
              });
              $('#level').val(rowdata.LevelID);
            });
        }
        
    });
    $('#delete').on('click', function(event) {
        event.preventDefault();
        var rowdata = row_selected('#griduser');
        if (!!rowdata) {
          if (confirm('Are you sure?')) {
            gojax('post', base_url+'/api/user/delete', {id:rowdata.UserID,empid:rowdata.EMPID,username:rowdata.Username,active:rowdata.USERACTIVE})
            .done(function(data) {
              if (data.status == 200) {
                gotify(data.message,"success");
                $('#griduser').jqxGrid('updatebounddata');
              } else {
                gotify(data.message,"danger");
              }
            });
          }
        }
    });

    $('#btn_employee').on('click', function () {
      $('#modal_employee').modal({backdrop: 'static'});
      load_gridemployee();
      return false;
    });

    $("#grid_empployee").on('rowdoubleclick', function(event) {
        var args = event.args;
        var row = $("#grid_empployee").jqxGrid('getrowdata', args.rowindex);
        $('#user_employee').val(row.CODEMPID);
        // $('#username').val(row.CODEMPID);
        $('#fullname').val(row.EMPNAME+' '+row.EMPLASTNAME);
        $('#modal_employee').modal('hide');
    });

    getDepartment()
        .done(function(data) {
          $('select[name=depid]').html("<option value=''>-- Select --</option>");
          $.each(data, function(index, val) {
            $('select[name=depid]').append('<option value="'+val.DepartmentID+'">'+val.DepartmentName+'</option>');
          });
    });

    getCompany()
        .done(function(data) {
          $('select[name=compid]').html("<option value=''>-- Select --</option>");
          $.each(data, function(index, val) {
            $('select[name=compid]').append('<option value="'+val.InternalCode+'">'+val.Description+'</option>');
          });
    });

    getLevel()
        .done(function(data) {
          $('select[name=level]').html("<option value=''>-- Select --</option>");
          $.each(data, function(index, val) {
            $('select[name=level]').append('<option value="'+val.LevelID+'">'+val.Description+'</option>');
          });
    });

  });

  function modal_create_open(){
        $('#form_create').trigger('reset');
        $('input[name=username]').prop('readonly', false);
        $('.modal-title').text('Create New User');
        $('input[name=form_type]').val('create');
  }

  function submit_create_user() {
    $.ajax({
      url : base_url + '/api/user/create',
      type : 'post',
      cache : false,
      dataType : 'json',
      data : $('form#form_create').serialize()
    })
    .done(function(data) {
      if (data.status != 200) {
        gotify(data.message,"danger");
      }else{
        gotify(data.message,"success");
        $('#modal_create').modal('hide');
        $('#griduser').jqxGrid('updatebounddata');
      }
    });
    return false;
  }

  function getDepartment() {
    return $.ajax({
      url : base_url + '/api/department/all',
      type : 'get',
      dataType : 'json',
      cache : false
    });
  }

  function getCompany() {
    return $.ajax({
      url : base_url + '/api/company/all',
      type : 'get',
      dataType : 'json',
      cache : false
    });
  }

  function getLevel() {
    return $.ajax({
      url : base_url + '/api/level/all',
      type : 'get',
      dataType : 'json',
      cache : false
    });
  }

  function griduser(){
    
    var dataAdapter = new $.jqx.dataAdapter({
    datatype: "json",
        datafields: [
            { name: "UserID", type: "int" },
            { name: "Username", type: "string" },
            { name: "Password", type:"string"},
            { name: "FullName", type:"string"},
            { name: "CompanyID", type:"int"},
            { name: "DepartmentID", type:"int"},
            { name: "DepartmentName", type:"string"},
            { name: "Description", type:"string"},
            { name: "LevelID", type:"int"},
            { name: "LevelName", type:"string"},
            { name: "EMPID", type:"string"},
            { name: "USERACTIVE", type:"string"}
        ],
        url : base_url+'/api/user/all'
    });

    return $("#griduser").jqxGrid({
        width: '950',
        source: dataAdapter,
        autoheight: true,
        columnsresize: true,
        pageable: true,
        filterable: true,
        showfilterrow: true,
        theme : 'themeorange2',
        columns: [
          { text:"Username", datafield: "Username"},
          { text:"Password", datafield: "Password"},
          { text:"FullName", datafield: "FullName",width:200},
          { text:"DepartmentName", datafield: "DepartmentName",width:180},
          { text:"Company", datafield: "Description",width:200},
          { text:"Level", datafield: "LevelName",width:100},
          // { text:"Active", datafield: "USERACTIVE",width:50},
          { text:"Active", datafield: "USERACTIVE",width:50,
              cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                  var status;
                     if (value ==1) {
                         status =  "<div style='padding: 5px; background:#00CC00; color:#F8F8FF; font-size:12px;'> Enable </div>";
                     }else{
                          status =  "<div style='padding: 5px; background:#FF0033; color:#F8F8FF; font-size:12px;'> Disable </div>";
                     }
                     return status;
              }
          }
          ]
    });

  }

  function load_gridemployee(){

    var dataAdapter = new $.jqx.dataAdapter({
    datatype: "json",
    datafields: [
    { name: 'CODEMPID', type: 'string' },
    { name: 'EMPNAME', type: 'string' },
    { name: 'EMPLASTNAME', type: 'string' },
    { name: 'DEPARTMENTNAME', type: 'string' },
    { name: 'DIVISIONNAME', type: 'string' },
    { name: 'COMPANYNAME', type: 'string' },
    { name: 'EMAIL', type: 'string' },
    { name: 'DIVISIONID', type: 'string' },
    { name: 'DEPARTMENTCODE', type: 'string' }
    ],
      url: base_url+'/api/user/employee',
    });

    return $("#grid_empployee").jqxGrid({
        width: '100%',
        source: dataAdapter,
        autoheight: true,
        pageSize: 10,
        altrows: true,
        pageable: true,
        sortable: true,
        filterable: true,
        showfilterrow: true,
        columnsresize: true,
        theme: 'default',
        columns: [
          {text: 'EmployeeCode',datafield: 'CODEMPID',width:110},
          {text: 'Firstname',datafield: 'EMPNAME',width:110},
          {text: 'Lastname',datafield: 'EMPLASTNAME',width:110},
          {text: 'Section',datafield: 'DIVISIONNAME',width:100},
          {text: 'Department',datafield: 'DEPARTMENTNAME',width:100},
          {text: 'Company',datafield: 'COMPANYNAME',width:100},
          {text: 'E-mail',datafield: 'EMAIL'}

        ]
    });
  }

</script>