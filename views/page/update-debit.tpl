<?php $this->layout("layouts/base"); ?>
<h1>Update Debit Note</h1>
<hr>
<?php 
	use Components\Database;
	use Wattanar\Sqlsrv;
	$conn = (new Database)->connect();
	$transid = $_GET['myParam']; 
	$arr = (new Sqlsrv)->queryJson($conn, 
			"SELECT T.ID
			      ,T.DebitTransID
			      ,T.Type
			      ,T.CustomerCodeID
			      ,T.CompanyID
			      ,T.SubjectID
			      ,T.CreateBy
			      ,T.CreateDateTime
			      ,T.ApproveBy
			      ,T.ApproveDateTime
			      ,T.Status
			      ,T.Currency
			      ,T.CancelBy
			      ,T.CancelDateTime 
			      ,S.Description
			      ,C.CustName
			      ,CY.CurrencyName
			      ,T.Total
			      ,T.CheckLine
			      ,T.CheckClaim
			FROM DebitTrans T
			LEFT JOIN SubjectMaster S ON T.SubjectID=S.SubjectID
			LEFT JOIN CustomerMaster C ON T.CustomerCodeID=C.CustCode
			LEFT JOIN CurrencyMaster CY  ON T.Currency=CY.CurrencyID
			WHERE T.DebitTransID=?",[$transid]);
	$json_decode  = json_decode($arr);
	foreach ($json_decode as $value) {
		$value->DebitTransID;
		$value->CompanyID;
		$value->Type;
		$value->CustomerCodeID;
		$value->CustName;
		$value->SubjectID;
		$value->Description;
		$value->CurrencyName;
		$value->Total;
		$value->CheckLine;
		$value->CheckClaim;
	}
?>
	<form id="form_create" class="form-horizontal" method="post" enctype="multipart/form-data" 		action="./api/trans/update" onsubmit="return submit_create()">
        <div class="form-group">
	        <label for="company" class="col-lg-2 control-label">Company</label>
	        <div class="col-xs-2">
	            <select name="company" id="company" class="form-control" required></select>
	        </div>

	        <label for="customercode" class="col-lg-1 control-label">CustomerCode</label>
	        <div class="col-xs-3">
	            <input type="text" name="customercode" id="customercode" class="form-control" autocomplete="off" required readonly>
	        </div>
	        <button class="btn btn-info" type="button" id="btn_customer">Select</button>
        </div>
        <div class="form-group">
	        <label for="type" class="col-lg-2 control-label">Type</label>
	        <div class="col-xs-2">
	           <select name="type" id="type" class="form-control" required></select>
	        </div>

	        <label for="customername" class="col-lg-1 control-label">CustomerName</label>
	        <div class="col-xs-4">
	            <input type="text" name="customername" id="customername" class="form-control" autocomplete="off" required readonly>
	        </div>
        </div>    
        <div class="form-group">
	        <label for="subject" class="col-lg-2 control-label">Subject</label>
	        <div class="col-xs-6">
	            <input type="text" name="subject" id="subject" class="form-control" autocomplete="off" required readonly>
	            <input type="hidden" name="subjectid" id="subjectid">
	        </div>
	        <button class="btn btn-info" type="button" id="btn_subject">Select</button>
        </div>
        <div class="form-group">
	        <label for="currency" class="col-lg-2 control-label">Currency</label>
	        <div class="col-xs-2">
	        	<input type="hidden" name="currency" id="currency">
	            <input type="text" name="currencyname" id="currencyname" class="form-control" autocomplete="off" required readonly>
	        </div>
	        <button class="btn btn-info" type="button" id="btn_currency">Select</button>
        </div>
        <div class="form-group">
          <label for="total" class="col-lg-2 control-label" id="labeltotal">Total</label>
          <div class="col-xs-2">
              <input type="text" name="total" id="total" class="form-control">
          </div>
        </div>
        <div class="form-group">
          <label for="checkline" class="col-lg-2 control-label">CheckLine</label>
          <div class="col-xs-2">
              <input type="checkbox" name="checkline" id="checkline" value="1">
          </div>
        </div>
        <div class="form-group">
          <label for="checkclaim" class="col-lg-2 control-label">Claim</label>
          <div class="col-xs-2">
              <input type="checkbox" name="checkclaim" id="checkclaim" value="1">
          </div>
        </div>
        <div class="form-group">
	        <label for="request" class="col-lg-2 control-label">Attach File <span class="glyphicon glyphicon-paperclip"></span></label>
	        <div class="col-xs-4">
	            <input name="browse" id="browse" type="button" class="btn btn-info" value="+">
	            <br>
	            <p id ="link"></p>
                <div class="well"><span id="mySpan"></span></div>
	        </div>
        </div>
        <input type="hidden" name="transid" id="transid" value="<?php echo "$value->DebitTransID"; ?>">
        <div class="form-group">
        <label for="request" class="col-lg-2 control-label"></label>
	        <div class="col-xs-4">
            <button class="btn btn-primary">Save</button>
            </div>
        </div>
    </form>

    <!-- dialog customer -->
	<div class="modal" id="modal_customer_create" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            	<span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
          	</button>
	        <h4 class="modal-title">Customer</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="form_create_item">
	      		<div class="form-group">
	      			<div id="grid_customer"></div>
	      		</div>
	      	</form>
	      </div>
	      <div class="modal-footer">

	      </div>
	    </div>
	  </div>
	</div>
	<!-- dialog subject -->
	<div class="modal" id="modal_subject_create" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            	<span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
          	</button>
	        <h4 class="modal-title">Subject</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="form_create_item">
	      		<div class="form-group">
	      			<div id="grid_subject"></div>
	      		</div>
	      	</form>
	      </div>
	      <div class="modal-footer">

	      </div>
	    </div>
	  </div>
	</div> 
	<!-- dialog currency -->
	<div class="modal" id="modal_currency_create" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            	<span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
          	</button>
	        <h4 class="modal-title">Currency</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="form_create_item">
	      		<div class="form-group">
	      			<div id="grid_currency"></div>
	      		</div>
	      	</form>
	      </div>
	      <div class="modal-footer">

	      </div>
	    </div>
	  </div>
	</div>
<script type="text/javascript">
	$('#btn_customer').on('click',function(){
        $('#modal_customer_create').modal({backdrop: 'static'});       
    });
    $('#btn_subject').on('click',function(){
        $('#modal_subject_create').modal({backdrop: 'static'});       
    });
    $('#btn_currency').on('click',function(){
        $('#modal_currency_create').modal({backdrop: 'static'});       
    });
    $('input[name=customercode]').val("<?php echo $value->CustomerCodeID; ?>");
    $('input[name=customername]').val("<?php echo $value->CustName; ?>");
    $('input[name=subjectid]').val("<?php echo $value->SubjectID; ?>");
    $('input[name=subject]').val("<?php echo $value->Description; ?>");
    $('input[name=currency]').val("<?php echo $value->Currency; ?>");
    $('input[name=currencyname]').val("<?php echo $value->CurrencyName; ?>");
    $('input[name=total]').val("<?php echo $value->Total; ?>");
    $('input[name=checkline]').val("<?php echo $value->CheckLine; ?>");
    $('input[name=checkclaim]').val("<?php echo $value->CheckClaim; ?>");
    var transid = "<?php echo "$value->DebitTransID"; ?>";
    var line = "<?php echo "$value->CheckLine"; ?>";
    var claim = "<?php echo "$value->CheckClaim"; ?>";
    if (line==1) {
    	$("input[name=checkline]").prop('checked' , true);
    	$('#total').hide();
        $('#labeltotal').hide();
    }else{
    	$('#total').show();
        $('#labeltotal').show();
    }
    if (claim==1) {
    	$("input[name=checkclaim]").prop('checked' , true);
    }
    $("#checkclaim").on('change', function() {
    	if ($(this).is(':checked')) {  
		    if($("input[name=checkclaim]").prop('checked' , true)){
		    	$("input[name=checkclaim]").val('1');
		    }
		}
    });
    $("#checkline").on('change', function() {
      
        if ($(this).is(':checked')) {   
        	$("input[name=checkline]").prop('checked' , false);
        	if (confirm('Are You Sure Delete Total ?')) {
        		//delete total
        		id = "<?php echo "$value->DebitTransID"; ?>";
        		total = $('#total').val(); 
        		deletetotal(id);
        	}
        	
        	
        }else{
        	$("input[name=checkline]").prop('checked' , true);
        	if (confirm('Are You Sure Delete Line ?')) {
        		//delete line
        		id = "<?php echo "$value->DebitTransID"; ?>";
        		deleteline(id);
        	}
        	
        	
        }
    });

	jQuery(document).ready(function($){

	    grid_customer('<?php echo $value->CompanyID; ?>');
		$('#grid_customer').on('rowdoubleclick', function (event){
	        var args = event.args;
	        var boundIndex = args.rowindex;        
	        var datarow = $("#grid_customer").jqxGrid('getrowdata', boundIndex);
	        $('#customercode').val(datarow.CustCode);
	        $('#customername').val(datarow.CustName);
	        alert($('#customercode').val());
	        $('#modal_customer_create').modal('hide');
		});
		grid_subject();
		$('#grid_subject').on('rowdoubleclick', function (event){
	        var args = event.args;
	        var boundIndex = args.rowindex;        
	        var datarow = $("#grid_subject").jqxGrid('getrowdata', boundIndex);
	        $('#subjectid').val(datarow.SubjectID);
	        $('#subject').val(datarow.Description);
	        alert($('#subject').val());
	        $('#modal_subject_create').modal('hide');
		});
		grid_currency();
		$('#grid_currency').on('rowdoubleclick', function (event){
	        var args = event.args;
	        var boundIndex = args.rowindex;        
	        var datarow = $("#grid_currency").jqxGrid('getrowdata', boundIndex);
	        $('#currency').val(datarow.CurrencyID);
	        $('#currencyname').val(datarow.CurrencyName);
          	alert(datarow.CurrencyName);
	        $('#modal_currency_create').modal('hide');
		});
		getCompany()
	      .done(function(data) {
	        $('select[name=company]').html("<option value=''>-- Select --</option>");
	        $.each(data, function(index, val) {
	          $('select[name=company]').append('<option value="'+val.InternalCode+'">'+val.InternalCode+'</option>');
	        $('select[name=company]').val('<?php echo $value->CompanyID; ?>');
	        $('select[name=company]').prop('disabled', true);
	        });
  		});
	    getType()
	      .done(function(data) {
	        $('select[name=type]').html("<option value=''>-- Select --</option>");
	        $.each(data, function(index, val) {
	          $('select[name=type]').append('<option value="'+val.TypeID+'">'+val.TypeName+'</option>');
	          $('select[name=type]').val('<?php echo $value->Type; ?>');
	          $('select[name=type]').prop('disabled', true);
	        });
	  	});
	    gojax('get', base_url+'/api/link/all?no='+transid)
          .done(function(data){
              var i=1;
              $.each(data, function( k, v ) {
                var filename = v.FileName;

              $('#link').append("<button type='button' class='btn btn-info btn-xs' onclick=deleteFile\('"+filename+"')>-</button><a target='_blank' href='upload/" + v.FileName + "'>" + v.FileName + "</a><br>");
              i++;

          });
      	});
        
		function getCompany() {
		    return $.ajax({
		      url : base_url + '/api/company/all',
		      type : 'get',
		      dataType : 'json',
		      cache : false
		    });
		}
		function getType() {
		    return $.ajax({
		      url : base_url + '/api/type/all',
		      type : 'get',
		      dataType : 'json',
		      cache : false
		    });
		}
		function grid_customer(company){
			var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: [
	            { name: "CustomerID", type: "int"},
	            { name: "CustCode", type: "string"},
	            { name: "CustName", type: "string"},
	            { name: "Address", type: "string"},
	            { name: "CustomerGroup", type: "string"}
	        ],
	        url : base_url+'/api/customer/all?company='+company
		});

		return $("#grid_customer").jqxGrid({
	        width: '100%',
	        source: dataAdapter,  
	        pageable: true,
	        autoHeight: true,
	        filterable: true,
	        showfilterrow: true,
	        enableanimations: false,
	        sortable: true,
	        pagesize: 10,
	        theme: 'themeorange2',
	        columns: [
	          { text:"CustCode", datafield: "CustCode"},
	          { text:"CustomerName", datafield: "CustName"},
	          { text:"Group", datafield: "CustomerGroup"}
	          ]
		    });

		}
		function grid_subject(){
			var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: [
	            { name: "SubjectID", type: "int"},
	            { name: "Description", type: "string"}
	        ],
	        url : base_url+'/api/subject/alldebit'
		});

		return $("#grid_subject").jqxGrid({
	        width: '100%',
	        source: dataAdapter,  
	        pageable: true,
	        autoHeight: true,
	        filterable: true,
	        showfilterrow: true,
	        enableanimations: false,
	        sortable: true,
	        pagesize: 10,
	        theme: 'themeorange2',
	        columns: [
	          { text:"Description", datafield: "Description"}
	          ]
		    });

		}
		function grid_currency(){
			var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: [
	            { name: "CurrencyID", type: "string"},
	            { name: "CurrencyName", type: "string"}
	        ],
	        url : base_url+'/api/currency/all'
		});

		return $("#grid_currency").jqxGrid({
	        width: '100%',
	        source: dataAdapter,  
	        pageable: true,
	        autoHeight: true,
	        filterable: true,
	        showfilterrow: true,
	        enableanimations: false,
	        sortable: true,
	        pagesize: 10,
	        theme: 'themeorange2',
	        columns: [
	          { text:"Currency", datafield: "CurrencyID"},
	          { text:"Description", datafield: "CurrencyName"}
	          ]
		    });

		}

	});
		//attach file
		var number = 1;
		$('#browse').bind('click', function() {

		  number++;

		  var add = "add" + number;
		  var add1 = "add1" + number;
		  var br1 = "br1" + number;
		  
		  $('#mySpan').append("<button id='" + add + "' onclick='removeEle(" + add + ',' + add1 +','+br1+ ")' type='button' class='btn btn-info'>-</button><input type='file' name='fileUpload[]' id='" + add1 + "'><br id='"+br1+"'>");  
		});

		function removeEle(divid, _divid,br){
		    $(divid).remove();
		    $(_divid).remove();
		    $(br).remove();
		}

		function deleteFile(file_name)
	    {
		        if (confirm('Are you sure?')) {
		          gojax('get', base_url+'/api/trans/deletefile', {file:file_name})
		          .done(function(data) {
		            if (data.status == 200) {
		              gotify(data.message,"success");
		              location.reload();
		            } else {
		              gotify(data.message,"danger");
		            }
		          });
		        }
        }
        function deleteline(id)
	    {
		          gojax('post', base_url+'/api/line/deletecheck', {id:id})
		          .done(function(data) {
		            if (data.status == 200) {
		              gotify(data.message,"success");
		                $("input[name=checkline]").prop('checked' , false);
				        $('#total').show();
				        $('#labeltotal').show();
		            } else {
		              gotify(data.message,"danger");
		            }
		          });
	    }
	    function deletetotal(id)
	    {
		          gojax('post', base_url+'/api/total/deletechecktotal', {id:id})
		          .done(function(data) {
		            if (data.status == 200) {
		              gotify(data.message,"success");
		                $("input[name=checkline]").prop('checked' , true);
				        $('#total').val('');
				        $('#total').hide();
				        $('#labeltotal').hide();
		            } else {
		              gotify(data.message,"danger");
		            }
		          });
	    }
</script>