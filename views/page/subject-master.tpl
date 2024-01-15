<?php $this->layout("layouts/base"); ?>

<style type="text/css">
  input[type=checkbox] {
    width: 15px;
    height: 15px;
    vertical-align: top;
  }
</style>

<h1>Subject</h1>
<button onclick="return modal_create_open()"  class="btn btn-default" data-backdrop="static" data-toggle="modal" data-target="#modal_create">Create</button>
<button class="btn btn-primary" id="edit">Update</button>
<button class="btn btn-danger" id="delete">Delete</button>
<hr>
<div id="gridsubject"></div>
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
        <form id="form_create" onsubmit="return submit_create_subject()">
          
          <div class="form-group">
            <label for="subject">Subject</label>
            <input type="text" name="subject" id="subject" class="form-control" autocomplete="off" required>
          </div>

          <div class="form-group">
            <label for="active">Active</label>
            <input type="checkbox" name="active" id="active" value="1" checked="true">
            <label> </label>
            <label for="deactive">Deactive</label>
            <input type="checkbox" name="active" id="deactive" value="0">
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
<script type="text/javascript">

	jQuery(document).ready(function($){

  	gridsubject();


    $('#edit').on('click', function(e) {
        
      var rowdata = row_selected("#gridsubject");
      if (typeof rowdata !== 'undefined') {
        $('#modal_create').modal({backdrop: 'static'});
        $('input[name=form_type]').val('update');
        $('.modal-title').text('Update');
        $('input[name=username]').prop('readonly', true);
        $('input[name=id]').val(rowdata.SubjectID);
        $('input[name=subject]').val(rowdata.Description);
      }

      $("#active").prop("checked", false);
      $("#deactive").prop("checked", false);
      // console.log(rowdata.Active);
      $('input[type=checkbox][value='+rowdata.Active+']').prop('checked','true');
    });

    $('#delete').on('click', function(event) {
      event.preventDefault();
      var rowdata = row_selected('#gridsubject');
      if (!!rowdata) {
        if (confirm('Are you sure?')) {
          gojax('post', base_url+'/api/subject/delete', {id:rowdata.SubjectID})
          .done(function(data) {
            if (data.status == 200) {
              gotify(data.message,"success");
              $('#gridsubject').jqxGrid('updatebounddata');
            } else {
              gotify(data.message,"danger");
            }
          });
        }
      }
    });

    // CheckBox only one
    $("input:checkbox").on('click', function() {
        var $box = $(this);
        if ($box.is(":checked")) {
          var group = "input:checkbox[name='" + $box.attr("name") + "']";
          var value = $box.attr("value");
          $(group).prop("checked", false);
          $box.prop("checked", true);

        }else{
          $box.prop("checked", false);
          $('#active').hide();
        }
    });

  });

  function gridsubject(){
    
    var dataAdapter = new $.jqx.dataAdapter({
    datatype: "json",
        datafields: [
            { name: "SubjectID", type: "int" },
            { name: "Description", type: "string" },
            { name: "Active", type: "int"}
        ],
        url : base_url+'/api/subject/all'
    });

    return $("#gridsubject").jqxGrid({
          width: '900',
          source: dataAdapter,
          autoheight: true,
          columnsresize: true,
          pageable: true,
          filterable: true,
          showfilterrow: true,
          theme : 'themeorange2',
          columns: [
            //{ text:"SubjectID", datafield: "SubjectID"},
            { text:"Description", datafield: "Description"}
            ]
    });

  }

  function modal_create_open(){
      $('#form_create').trigger('reset');
      $('input[name=subject]').prop('readonly', false);
      $('.modal-title').text('Create New Subject');
      $('input[name=form_type]').val('create');
  }

  function submit_create_subject() {
    $.ajax({
      url : base_url + '/api/subject/create',
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
        $('#gridsubject').jqxGrid('updatebounddata');
      }
    });
    return false;
  }

</script>