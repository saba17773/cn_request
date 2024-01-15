<?php $this->layout("layouts/base"); ?>
<h1>Customer</h1>
<button class="btn btn-primary" id="sync">Sync Customer Form Ax</button>
<hr>
<div id="gridcustomer"></div>

<script type="text/javascript">
	$('#sync').on('click', function(event) {
		event.preventDefault();
	          gojax('post', base_url+'/api/customer/sync')
	          .done(function(data) {
	            if (data.status != 200) {
	              swal({  title: data.message,
	                imageUrl: "./assets/sweetalert-master/example/images/error.png",  
	                confirmButtonColor: "#afeeee",
	                confirmButtonText: "OK"
	              }); 
			    }else{
	              swal({  title: data.message,
	                imageUrl: "./assets/sweetalert-master/example/images/success.png",  
	                timer: 2000,   showConfirmButton: false
	              });
			          $('#gridcustomer').jqxGrid('updatebounddata');
		        }
	          });
	});

	jQuery(document).ready(function($){
	gridcustomer();
	
	function gridcustomer(){
		var dataAdapter = new $.jqx.dataAdapter({
		datatype: "json",
        datafields: [
            { name: "CustomerID", type: "int" },
            { name: "CustCode", type: "string" },
            { name: "CustName", type:"string"},
            { name: "Address", type:"string"},
            { name: "CustomerGroup", type:"string"},
            //{ name: "NameGroup", type:"string"},
            { name: "Currency", type:"string"},
            { name: "Company", type:"string"}
        ],
        url : base_url+'/api/customer/allplant'
		});

		return $("#gridcustomer").jqxGrid({
	        width: '900',
	        source: dataAdapter,
	        autoheight: true,
	        columnsresize: true,
	        pageable: true,
	        filterable: true,
        	showfilterrow: true,
	        theme : 'themeorange2',
	        columns: [
	          { text:"CustCode", datafield: "CustCode"},
	          { text:"CustName", datafield: "CustName"},
	          { text:"Address", datafield: "Address"},
	          { text:"CustomerGroup", datafield: "CustomerGroup"},
	          { text:"Company", datafield: "Company"}
	          ]
		    });

		}

	});
</script>