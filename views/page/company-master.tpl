<?php $this->layout("layouts/base"); ?>
<h1>Company</h1>
<!-- <button class="btn btn-default" id="add">Create</button>
<button class="btn btn-primary" id="edit">Update</button>
<button class="btn btn-danger" id="delete">Delete</button> -->
<hr>
<div id="gridcompany"></div>

<script type="text/javascript">
	jQuery(document).ready(function($){
	gridcompany();
	
	function gridcompany(){
		var dataAdapter = new $.jqx.dataAdapter({
		datatype: "json",
        datafields: [
        	{ name: "CompanyID", type: "int" },
            { name: "InternalCode", type: "string" },
            { name: "Description", type: "string" }
        ],
        url : base_url+'/api/company/all'
		});

		return $("#gridcompany").jqxGrid({
	        width: '900',
	        source: dataAdapter,
	        autoheight: true,
	        columnsresize: true,
	        pageable: true,
	        filterable: true,
        	showfilterrow: true,
	        theme : 'themeorange2',
	        columns: [
	          { text:"CompanyID", datafield: "InternalCode"},
	          { text:"CompanyName", datafield: "Description"}
	          ]
		    });

		}

	});
</script>