<?php $this->layout("layouts/base"); ?>
<h3>CN-REQUEST</h3>
<a href="./createdebit" id="btncreate" class="btn btn-default">Create</a>
<button onclick="return modal_update_open()" class="btn btn-primary" id="update">Update</button>
<button  class="btn btn-warning" id="line">Line</button>
<button onclick="return modal_link_open()" class="btn btn-info" id="file">AttachFile</button>
<button  class="btn btn-success" id="approve">Save</button>
<button  class="btn btn-danger" id="cancel">Cancel</button>
<button  class="btn btn-warning" id="report">Report</button>
<button  class="btn btn-info" id="remark_trans">Remark</button>
<hr>
<div id="gridtrans"></div>
<!-- File Modal -->
<div class="modal" id="modal_file" tabindex="-1" role="dialog">
  <div class="modal-dialog  modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-titlefile">this title</h4>
      </div>
      <div class="modal-body">
      <form id="form_link">
          <div class="form-group has-warning">
            <label class="control-label" for="inputWarning">Request No.</label>
            <input type="text" class="form-control" id="id_trans" name="id_trans" readonly style="background:'#C0C0C0';">
          </div>
          <div class="form-group has-warning">
            <label class="control-label" for="inputWarning">File</label>
            <p id="link"></p>
          </div>
      </form>
      </div>
    </div>
  </div>
</div>
<!-- Line Modal -->
<div class="modal" id="modal_line" tabindex="-1" role="dialog">
  <div class="modal-dialog  modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-titleline">this title</h4>
      </div>
      <div class="modal-body">
      <form id="form_line">
          <div class="form-group has-success">
            <button onclick="return modal_line_create()" class="btn btn-warning" id="create_line">Create</button>
            <button class="btn btn-primary" id="update_line">Update</button>
            <button class="btn btn-danger" id="delete_line">Delete</button>
            <button class="btn btn-info" id="remark_line">Remark</button>
          </div>
          <div id="gridline"></div>
      </form>
      </div>
    </div>
  </div>
</div>
<!-- Linecreate Modal -->
<div class="modal" id="modal_create_line" tabindex="-1" role="dialog">
  <div class="modal-dialog  modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-title">this title</h4>
      </div>
      <div class="modal-body">
      <form id="form_create_line" onsubmit="return submit_create_line()">
          <div class="form-group has-success">
            <label class="control-label" for="inputSuccess">Request No.</label>
            <input type="text" class="form-control" id="id_trans" name="id_trans" readonly style="background:'#C0C0C0';">
          </div>
          <div class="form-group has-success">
            <label class="control-label" for="inputSuccess">Description</label>
            <input type="text" class="form-control" id="description" name="description" autocomplete="off" required>
          </div>
          <div class="form-group has-success">
            <label class="control-label" for="inputSuccess">Amount</label>
            <input type="text" class="form-control" id="amount" name="amount" autocomplete="off" required>
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
<!-- LinecreateRemark Modal -->
<div class="modal" id="modal_remark_line" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-title">this title</h4>
      </div>
      <div class="modal-body">
      <form id="form_create_remark" onsubmit="return submit_remark_line()">
          <div class="form-group has-success">
            <label class="control-label" for="inputSuccess">DescriptionLine</label>
            <input type="text" class="form-control" id="id_trans" name="id_trans" readonly style="background:'#C0C0C0';">
          </div>
          <div class="form-group has-success">
            <textarea class="form-control" id="txtremark" name="txtremark" autocomplete="off" rows="3"required></textarea>
          </div>
          <input type="hidden" name="idremark" id="idremark">
          <input type="hidden" name="id">
          <input type="hidden" name="form_type">
          <label>
            <button class="btn btn-primary">Save</button>
          </label>
          <label>
            <input type="button" class="btn btn-default" name="deleteremark" id="deleteremark" value="Delete">
            <input type="button" class="btn btn-default" name="deleteremarktrans" id="deleteremarktrans" value="Delete">
          </label>
      </form>
      </div>
    </div>
  </div>
</div>
<!-- Username Modal -->
<div class="modal" id="modal_user" tabindex="-1" role="dialog">
  <div class="modal-dialog  modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <p class="modal-titleuser">this title</p>
      </div>
      <div class="modal-body">
      <form id="form_user">
          <div class="form-group has-warning">
            <p id="linkuserlist"></p>
          </div>
      </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$('#remark_trans').hide();
  var levelid = '<?php echo $_SESSION["levelid"]; ?>';
  if (levelid==3) {
      $('#btncreate').prop('disabled', true);
      $('#update').prop('disabled', true);
      $('#approve').prop('disabled', true);
      $('#cancel').prop('disabled', true);
      $('#create_line').prop('disabled', true);
      $('#update_line').prop('disabled', true);
      $('#delete_line').prop('disabled', true);
      $('#remark_line').prop('disabled', true);
  }
  $('#cancel').on('click', function(event) {
      event.preventDefault();
      var rowdata = row_selected('#gridtrans');
      if (rowdata.Status!=3 && rowdata.Status!=4) {
      if (!!rowdata) {
        if (confirm('Are you sure?')) {
          gojax('post', base_url+'/api/trans/cancel', {id:rowdata.DebitTransID})
          .done(function(data) {
            if (data.status == 200) {
              gotify(data.message,"success");
              $('#gridtrans').jqxGrid('updatebounddata');
            } else {
              gotify(data.message,"danger");
            }
          });
        }
      }
      }
  });
  $('#approve').on('click', function(e) {
      var rowdata = row_selected("#gridtrans");
      if (typeof rowdata !== 'undefined') {
        if (rowdata.Status==1) {
        gojax('post', base_url+'/api/trans/approve', {id:rowdata.DebitTransID})
          .done(function(data) {
            if (data.status == 200) {
              gotify(data.message,"success");
              $('#gridtrans').jqxGrid('updatebounddata');
            } else {
              gotify(data.message,"danger");
            }
        });
        }
      }

  });
  $('#line').on('click', function(e) {
      var rowdata = row_selected("#gridtrans");
      if (typeof rowdata !== 'undefined' && rowdata.CheckLine ===true) {
        $('#modal_line').modal({backdrop: 'static'});
        $('.modal-titleline').text('Line'+"-"+rowdata.DebitTransID);
        $('input[name=id_trans]').val(rowdata.DebitTransID);
        LineGirdLoader(rowdata.DebitTransID);      
      }

  });
  $('#create_line').on('click', function(e){
    var rowdata = row_selected("#gridtrans");
    if (rowdata.Status<=3) {
      $('#modal_create_line').modal({backdrop: 'static'});
      $('input[name=id_trans]').val(rowdata.DebitTransID);
      $('.modal-title').text('CreateLine');
    }
      return false;
  });
  $('#update_line').on('click', function(e){
    var rowdata = row_selected("#gridline");
    if (typeof rowdata !== 'undefined') {
      $('#modal_create_line').modal({backdrop: 'static'});
      $('input[name=form_type]').val('update');
      $('input[name=id_trans]').val(rowdata.DebitTransID);
      $('input[name=description]').val(rowdata.Description);
      $('input[name=amount]').val(rowdata.Amount);
      $('input[name=id]').val(rowdata.ID);
      $('.modal-title').text('UpdateLine');
    }
    return false;
  });
  $('#delete_line').on('click', function(event) {
      event.preventDefault();
      var rowdata = row_selected('#gridline');
      if (!!rowdata) {
        if (confirm('Are you sure?')) {
          gojax('post', base_url+'/api/line/delete', {id:rowdata.ID,transid:rowdata.DebitTransID})
          .done(function(data) {
            if (data.status == 200) {
              gotify(data.message,"success");
              $('#gridtrans').jqxGrid('updatebounddata');
              $('#gridline').jqxGrid('updatebounddata');
            } else {
              gotify(data.message,"danger");
            }
          });
        }
      }
  });
  $('#remark_line').on('click', function(e){
    $('#form_create_remark').trigger('reset');
    var rowdata = row_selected("#gridline");
    if (typeof rowdata !== 'undefined') {
      $('#deleteremarktrans').hide();  $('#deleteremark').show();
      $('#modal_remark_line').modal({backdrop: 'static'});
      $('input[name=form_type]').val('create');
      $('input[name=id_trans]').val(rowdata.Description);
      $('input[name=id]').val(rowdata.ID);
      $('.modal-title').text('CreateRemarkLine');
      gojax('get', base_url+'/api/link/allremark?no='+rowdata.ID)
          .done(function(data){
              var i=1;
              $.each(data, function( k, v ) {
                var datalineremark = v.RemarkDescription;
                var idlineremark = v.RemarkID;

                if (datalineremark!=="") {
                  $('#deleteremarktrans').hide(); $('#deleteremark').show();
                  $('input[name=form_type]').val('update');
                  $('.modal-title').text('UpdateRemarkLine');
                  $('#txtremark').val(datalineremark);
                  $('#idremark').val(idlineremark);
                }
                
          });
      });

    }
    return false;
  });

  $('#deleteremark').on('click', function(event) {
      event.preventDefault();
      var rowdata = row_selected('#gridline');
      var type = "deleteline";
        if (confirm('Are you sure?')) {
          gojax('post', base_url+'/api/line/deleteremark', {id:rowdata.ID,type:type})
          .done(function(data) {
            //alert(data.message);
            if (data.status == 200) {
              gotify(data.message,"success");
              $('#modal_remark_line').modal('hide');
              $('#gridline').jqxGrid('updatebounddata');
            } else {
              gotify(data.message,"danger");
            }
          });
        }
      
  });
  $('#deleteremarktrans').on('click', function(event) {
      event.preventDefault();
      var rowdata = row_selected('#gridtrans');
      var type = "deletetrans";
        if (confirm('Are you sure?')) {
          gojax('post', base_url+'/api/line/deleteremark', {id:rowdata.ID,type:type})
          .done(function(data) {
            //alert(data.message);
            if (data.status == 200) {
              gotify(data.message,"success");
              $('#modal_remark_line').modal('hide');
              $('#gridline').jqxGrid('updatebounddata');
            } else {
              gotify(data.message,"danger");
            }
          });
        }
      
  });
  $('#file').on('click', function(e) {
      var rowdata = row_selected("#gridtrans");
      if (typeof rowdata !== 'undefined') {
        $('#modal_file').modal({backdrop: 'static'});
        $('.modal-titlefile').text('File');
        $('input[name=id]').val(rowdata.ID);
        $('input[name=id_trans]').val(rowdata.DebitTransID);

      var transid = rowdata.DebitTransID;
      gojax('get', base_url+'/api/link/all?no='+transid)
          .done(function(data){
              var i=1;
              $.each(data, function( k, v ) {
                var filename = v.FileName;
        
              $('#link').append("<a target='_blank' href='upload/" + v.FileName + "'>" + v.FileName + "</a><br>");
              i++;
          });
      });

      }
  });

  $('#update').on('click',function(){
    var rowdata = row_selected("#gridtrans");
      if (typeof rowdata !== 'undefined') {
        if (rowdata.Status<=2) {
        window.location.assign(base_url +'updatedebit?myParam='+rowdata.DebitTransID);
        }
      }
  });

  $('#report').on('click',function(){
    var rowdata = row_selected("#gridtrans");
      if (typeof rowdata !== 'undefined' && rowdata.Status >=2  && rowdata.Status <=5) {
       window.open(base_url +'api/pdf/reportdebit/'+rowdata.DebitTransID,'_blank');
      }
  });

  $('#gridtrans').on('rowdoubleclick', function (event){
      $('#form_user').trigger('reset');
      $('#linkuserlist').html("");
      var rowdata = row_selected("#gridtrans");
      if (typeof rowdata !== 'undefined') {
        $('#modal_user').modal({backdrop: 'static'});
        $('.modal-titleuser').text('User List'+" - "+rowdata.DebitTransID);
        $('input[name=id]').val(rowdata.ID);
        $('input[name=id_trans]').val(rowdata.DebitTransID);

      var transid = rowdata.DebitTransID;
      gojax('get', base_url+'/api/link/alluserlist?no='+transid)
          .done(function(data){
              var i=1;
              $.each(data, function( k, v ) {
                var user = v.USER;
              if (v.ApproveBy==null) {
                v.ApproveBy ="";
              }
              if (v.CancelBy==null) {
                v.CancelBy ="";
              }
              $('#linkuserlist').append(
                "<p>"+ "<b class='control-label'>CreateBy</b> " + v.CreateBy + "</p><br>"+
                "<p>"+ "<b class='control-label'>ConfirmBy</b> " + v.ApproveBy + "</p><br>"+
                "<p>"+ "<b class='control-label'>CancelBy</b> " + v.CancelBy + "</p><br>");
              i++;
          });
      });

      }       
  });
  $("#gridtrans").on('rowclick',function(event){
          var args = event.args;
          var boundIndex = args.rowindex;
          var datarow = $("#gridtrans").jqxGrid('getrowdata',boundIndex);
          
          if(datarow.CheckLine==0 && datarow.Split==0){
            $('#remark_trans').show();   
          }else if(datarow.CheckLine==1){
            $('#remark_trans').hide(); 
          }else if(datarow.Split==1){
            $('#remark_trans').hide(); 
          }
  });
  $('#remark_trans').on('click', function(e){
    $('#form_create_remark').trigger('reset');
    var rowdata = row_selected("#gridtrans");
    if (typeof rowdata !== 'undefined' && rowdata.Status <= 2) {
      $('#deleteremark').hide(); $('#deleteremarktrans').show();
      $('#modal_remark_line').modal({backdrop: 'static'});
      $('input[name=form_type]').val('create');
      $('input[name=id_trans]').val(rowdata.Description);
      $('input[name=id]').val(rowdata.ID);
      $('.modal-title').text('CreateRemarkTrans');
      gojax('get', base_url+'/api/link/allremarktrans?no='+rowdata.ID)
          .done(function(data){
              var i=1;
              $.each(data, function( k, v ) {
                var datalineremark = v.Remark;

                if (datalineremark!=="") {
                  $('input[name=form_type]').val('updatetrans');
                  $('.modal-title').text('UpdateRemarkTrans');
                  $('#txtremark').val(datalineremark);
                }
                
          });
      });

    }
    return false;
  });
  function submit_create_line() {
        $.ajax({
            url : base_url + '/api/line/create',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create_line').serialize()
          })
          .done(function(data) {
            if (data.status != 200) {
              gotify(data.message,"danger");
            }else{
              gotify(data.message,"success");
              $('#modal_create_line').modal('hide');
              $('#gridline').jqxGrid('updatebounddata');
              $('#gridtrans').jqxGrid('updatebounddata');
            }
          });
      return false;
  }
  function submit_remark_line() {
        // alert($('#id').val());
        $.ajax({
            url : base_url + '/api/line/createremrak',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create_remark').serialize()
          })
          .done(function(data) {
            //alert(data.message);
            if (data.status != 200) {
              gotify(data.message,"danger");
            }else{
              gotify(data.message,"success");
              $('#modal_remark_line').modal('hide');
              $('#gridline').jqxGrid('updatebounddata');
            }
          });
      return false;
  }
  function modal_link_open(){
    $('#form_link').trigger('reset');
    $('#link').html("");
  }
  function modal_line_create(){
    $('#form_create_line').trigger('reset');
    $('.modal-title').text('CreateLine');
    $('input[name=form_type]').val('create');
  }
  jQuery(document).ready(function($){
  gridtrans();
  });
  function gridtrans(){
    var dataAdapter = new $.jqx.dataAdapter({
    datatype: "json",
    filter : function (data) {
        $('#gridtrans').jqxGrid('updatebounddata', 'filter');
      },
        datafields: [
            { name: "ID", type: "int" },
            { name: "DebitTransID", type:"string"},
            { name: "Type", type: "string" },
            { name: "CompanyID", type: "string" },
            { name: "CustomerCodeID", type:"string"},
            { name: "CustName", type:"string"},
            { name: "SubjectID", type:"int"},
            { name: "CurrencyName", type:"string"},
            { name: "Description", type:"string"},
            { name: "Amount", type:"float"},
            { name: "CnAmount", type:"float"},
            { name: "CnNumber", type:"string"},
            { name: "Status", type:"int"},
            { name: "StatusName", type:"string"},
            { name: "Username", type:"string"},
            { name: "Split", type:"int"},
            { name: "Total", type:"int"},
            { name: "CheckLine", type:"bool"},
            { name: "CheckClaim", type:"bool"}
        ],
        url : base_url+'/api/trans/all'
  });

  return $("#gridtrans").jqxGrid({
        width: '100%',
        source: dataAdapter,
        autoheight: true,
        columnsresize: true,
        pageable: true,
        filterable: true,
        showfilterrow: true,
        pagesize: 20,
        theme : 'themeorange2',
        columns: [
          { text:"Request No.", datafield: "DebitTransID",width:120},
          { text:"Type", datafield: "Type",width:60,filtertype: 'checkedlist'},
          { text:"Company", datafield: "CompanyID",width:60,filtertype: 'checkedlist'},
          { text:"CustomerCode", datafield: "CustomerCodeID",width:100},
          { text:"CustName", datafield: "CustName"},
          { text:"Subject", datafield: "Description"},
          { text:"Currency", datafield: "CurrencyName",width:80},
          { text:"Amount", datafield: "Amount",width:100,cellsformat: 'F2'},
          { text:"CN Amount", datafield: "CnAmount",width:100,cellsformat: 'F2'},
          { text:"CN Number", datafield: "CnNumber",width:90},
          { text:"Line", columntype: 'checkbox', datafield: 'CheckLine', width:50},
          { text:"Cliam", columntype: 'checkbox', datafield: 'CheckClaim', width:50},
          { text:"Status", datafield: "StatusName",width:80,filtertype: 'checkedlist', filteritems: ['Create','Confirm','Confirmed','Complete','Cancel'], 
                    cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                        var status;
                           if (value =="Create") {
                               status =  "<div style='padding: 5px; background:#696969 ; color:#ffffff;'> Create </div>";
                           }else if(value =="Confirm"){
                                status =  "<div style='padding: 5px; background:#66CCFF ; color:#ffffff;'> Confirm </div>";
                           }else if(value =="Confirmed"){
                                status =  "<div style='padding: 5px; background:#FFCC33 ; color:#ffffff;'> Confirmed </div>";
                           }else if(value =="Complete"){
                                status =  "<div style='padding: 5px; background:#32CD32 ; color:#ffffff;'> Complete </div>";
                           }else if(value =="Cancel"){
                                status =  "<div style='padding: 5px; background:#EE2C2C ; color:#ffffff;'> Cancel </div>";
                           }

                           return status;
                    }
                },
          { text:"From", datafield: "Split",width:80,filtertype: 'checkedlist', filteritems: ['0','1'], 
                    cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                        var status;
                           if (value ==0) {
                               status =  "<div style='padding: 5px; background:# ; color:#;'> Web </div>";
                           }else if(value ==1){
                                status =  "<div style='padding: 5px; background:# ; color:#;'> Ax </div>";
                           }

                           return status;
                    }
                }
          ]
      });

  }

  function LineGirdLoader(transid){
    var dataAdapter = new $.jqx.dataAdapter({
    datatype: "json",
        datafields: [
            { name: "ID", type: "int" },
            { name: "Description", type:"string"},
            { name: "Amount", type: "float" },
            { name: "DebitTransID", type: "string" }
        ],
        url : base_url+'/api/line/all?p='+transid
  });

  return $("#gridline").jqxGrid({
        width: '700',
        source: dataAdapter,
        autoheight: true,
        columnsresize: true,
        theme : 'themeorange2',
        columns: [
          { text:"Description", datafield: "Description"},
          { text:"Amount", datafield: "Amount",cellsformat: 'F2'}
          ]
      });

  }

</script>