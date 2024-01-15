<?php  

namespace Controllers;

use Models\ReportService;

class ReportController
{
	public function reportdebit($id)
	{
		$comp = substr($id, 0, -10);
		$arr = (new ReportService)->allpdftrans($id,$comp);
		$json_decodeTrans  = json_decode($arr);
		
		$arr = (new ReportService)->allpdfline($id);
		$json_decodeLine  = json_decode($arr);
		// echo count($json_decodeLine);

		if ($json_decodeTrans['0']->Type=="CN") {
			$type_show="Credit";
		}else{
			$type_show="Debit";
		}

		$old_date_timestamp = strtotime($json_decodeTrans['0']->CreateDateTime);
		$new_date 		= date('d/m/Y',$old_date_timestamp);
		$comp 			= $json_decodeTrans['0']->CompanyID;	
		$DebitTransID 	= $json_decodeTrans['0']->DebitTransID;
		$CustomerGroup 	= $json_decodeTrans['0']->CustomerGroup;
		$CustomerCodeID = $json_decodeTrans['0']->CustomerCodeID;
		$CustName 		= $json_decodeTrans['0']->CustName;
		$Address 		= $json_decodeTrans['0']->Address;

		// echo "<pre>". print_r($json_decodeTrans, true) . "</pre>";
		// exit();
		// renderView("page/report-debit",[
		// 	"datajsonT" => $json_decodeTrans,
		// 	"datajsonL" => $json_decodeLine
		// ]);
			if ($json_decodeTrans[0]->CheckLine==1) {
				foreach ($json_decodeLine as $value) {
	  				$sum += $value->Amount;
	  			}
	  			$total = $sum;
	  		}else{
	  			$total = $json_decodeTrans[0]->Total;
	  		}

		renderView("page/report-debit-pdf",[
			"datajsonT" => $json_decodeTrans,
			"datajsonL" => $json_decodeLine,
			"new_date" 	=> $new_date,
			"type_show" => $type_show,
			"comp" 		=> $comp,
			"DebitTransID" 	 => $DebitTransID,
			"CustomerGroup"  => $CustomerGroup,
			"CustomerCodeID" => $CustomerCodeID,
			"CustName" 	=> $CustName,
			"Address" 	=> $Address,
			"Total"		=> $total
		]);

	}
}