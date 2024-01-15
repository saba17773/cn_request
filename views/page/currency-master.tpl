<?php $this->layout("layouts/base"); ?>
<h1>Currency</h1>
<button onclick="return modal_create_open()"  class="btn btn-default" data-backdrop="static" data-toggle="modal" data-target="#modal_create">Create</button>
<button class="btn btn-primary" id="edit">Update</button>
<button class="btn btn-danger" id="delete">Delete</button>
<hr>
<div id="gridcurrency"></div>
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
        <form id="form_create" onsubmit="return submit_create_currency()">
          
          <div class="form-group">
            <label for="subject">Currency</label>
            <input type="text" name="currency" id="currency" class="form-control" autocomplete="off" required>
          </div>
          <div class="form-group">
            <label for="subject">Descriptiion</label>
            <input type="text" name="description" id="description" class="form-control" autocomplete="off" required>
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
	$('#edit').on('click', function(e) {
      var rowdata = row_selected("#gridcurrency");
      if (typeof rowdata !== 'undefined') {
        $('#modal_create').modal({backdrop: 'static'});
        $('input[name=form_type]').val('update');
        $('.modal-title').text('Update');
        //$('input[name=currency]').prop('readonly', true);
        $('input[name=currency]').val(rowdata.CurrencyID);
        $('input[name=id]').val(rowdata.RecID);
        $('input[name=description]').val(rowdata.CurrencyName);
      }
      
  	});
	$('#delete').on('click', function(event) {
	      event.preventDefault();
	      var rowdata = row_selected('#gridcurrency');
	      if (!!rowdata) {
	        if (confirm('Are you sure?')) {
	          gojax('post', base_url+'/api/currency/delete', {id:rowdata.RecID})
	          .done(function(data) {
	            if (data.status == 200) {
	              gotify(data.message,"success");
	              $('#gridcurrency').jqxGrid('updatebounddata');
	            } else {
	              gotify(data.message,"danger");
	            }
	          });
	        }
	      }
  	});
	function modal_create_open(){
  	    $('#form_create').trigger('reset');
  	    $('input[name=currency]').prop('readonly', false);
  	    $('.modal-title').text('Create New Currency');
  	    $('input[name=form_type]').val('create');
    }
    function submit_create_currency() {
		    $.ajax({
		        url : base_url + '/api/currency/create',
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
		          $('#gridcurrency').jqxGrid('updatebounddata');
		        }
	        });
    	return false;
	}
	jQuery(document).ready(function($){
  	gridcurrency();

  	function gridcurrency(){
		
		var dataAdapter = new $.jqx.dataAdapter({
		datatype: "json",
        datafields: [
        	{ name: "RecID", type: "int" },
            { name: "CurrencyID", type: "string" },
            { name: "CurrencyName", type: "string" }
        ],
        url : base_url+'/api/currency/all'
		});

		return $("#gridcurrency").jqxGrid({
	        width: '900',
	        source: dataAdapter,
	        autoheight: true,
	        columnsresize: true,
	        pageable: true,
	        filterable: true,
	        showfilterrow: true,
	        theme : 'themeorange2',
	        columns: [
	          { text:"currency", datafield: "CurrencyID"},
	          { text:"description", datafield: "CurrencyName"}
	          ]
		});

	}

  	});
</script>