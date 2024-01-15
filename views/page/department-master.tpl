<?php $this->layout("layouts/base"); ?>
<h1>Department</h1>
<button class="btn btn-primary" id="sync">Sync Department Form Ax</button>
<hr>
<div id="griddepartment"></div>

<script type="text/javascript">
	$('#sync').on('click', function(event) {
		event.preventDefault();
	          gojax('post', base_url+'/api/department/sync')
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
	griddepartment();
	
	function griddepartment(){
		var dataAdapter = new $.jqx.dataAdapter({
		datatype: "json",
        datafields: [
            { name: "DepartmentID", type: "string" },
            { name: "DepartmentName", type: "string" }
        ],
        url : base_url+'/api/department/all'
		});

		return $("#griddepartment").jqxGrid({
	        width: '900',
	        source: dataAdapter,
	        autoheight: true,
	        columnsresize: true,
	        pageable: true,
	        filterable: true,
        	showfilterrow: true,
	        theme : 'themeorange2',
	        columns: [
	          { text:"DepartmentID", datafield: "DepartmentID"},
	          { text:"DepartmentName", datafield: "DepartmentName"}
	          ]
		    });

		}

	});
</script>