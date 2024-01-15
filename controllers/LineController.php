<?php  

namespace Controllers;

use Models\LineService;
use Components\Database;
use Wattanar\Sqlsrv;

class LineController
{
	public function all()
	{
		$transid = trim(filter_input(INPUT_GET, "p"));
		echo (new LineService)->all($transid);
	}
	public function create()
	{
		$description = trim(filter_input(INPUT_POST, "description"));
		$amount = trim(filter_input(INPUT_POST, "amount"));
		$transid = trim(filter_input(INPUT_POST, "id_trans"));
		$form_type = trim(filter_input(INPUT_POST, "form_type"));
		$id = trim(filter_input(INPUT_POST, "id"));
		$conn = (new Database)->connect();
		$amount = str_replace(",","",$amount);
		if ($form_type == "create") {
			if((new LineService)->create($description,$amount,$transid) === false) {
				echo json_encode(["status" => 404, "message" => "Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Successful"]);
		}

		if ($form_type == "update") {
			if((new LineService)->update($description,$amount,$transid,$id) === false) {
				echo json_encode(["status" => 404, "message" => "Update Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Update Successful"]);
		}
	}
	
	public function delete(){
		$id = filter_input(INPUT_POST, "id");
		$transid = filter_input(INPUT_POST, "transid");
		// echo json_encode(["status" => 200, "message" => $transid]);
		// exit();
		if ((new LineService)->delete($id,$transid)) {
			echo json_encode(["status" => 200, "message" => "Delete Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Delete Failed"]);
		}	
	}

	public function allremark()
	{
		$no = trim(filter_input(INPUT_GET, "no"));
		echo (new LineService)->allremark($no);
	}
	public function allremarktrans()
	{
		$no = trim(filter_input(INPUT_GET, "no"));
		echo (new LineService)->allremarktrans($no);
	}
	public function createremrak()
	{
		$txtremark = trim(filter_input(INPUT_POST, "txtremark"));
		$form_type = trim(filter_input(INPUT_POST, "form_type"));
		$idremark = trim(filter_input(INPUT_POST, "idremark"));
		$id = trim(filter_input(INPUT_POST, "id"));
		$conn = (new Database)->connect();
		 // echo json_encode(["message" => $form_type]);
		 // exit();
		if ($form_type == "create") {
			if((new LineService)->createremrak($id,$txtremark) === false) {
				echo json_encode(["status" => 404, "message" => "Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Successful"]);
		}

		if ($form_type == "update") {
			if((new LineService)->updateremrak($idremark,$txtremark) === false) {
				echo json_encode(["status" => 404, "message" => "Update Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Update Successful"]);
		}

		if ($form_type == "updatetrans") {
			if((new LineService)->updateremraktrans($id,$txtremark) === false) {
				echo json_encode(["status" => 404, "message" => "Update Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Update Successful"]);
		}
	}

	public function deleteremark(){
		$id = filter_input(INPUT_POST, "id");
		$type = filter_input(INPUT_POST, "type");
		// echo json_encode(["status" => 200, "message" => $type]);
		// exit();
		if ($type=="deleteline") {
			if ((new LineService)->deleteremark($id,$type)) {
				echo json_encode(["status" => 200, "message" => "Delete Successful"]);
			} else {
				echo json_encode(["status" => 404, "message" => "Delete Failed"]);
			}
		}else if($type=="deletetrans"){
			if ((new LineService)->deleteremark($id,$type)) {
				echo json_encode(["status" => 200, "message" => "Delete Successful"]);
			} else {
				echo json_encode(["status" => 404, "message" => "Delete Failed"]);
			}
		}
			
	}

	public function deletecheck(){
		$id = filter_input(INPUT_POST, "id");
		//$total = filter_input(INPUT_POST, "total");
		if ((new LineService)->deletecheck($id)) {
			echo json_encode(["status" => 200, "message" => "Delete Line Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Delete Line Failed"]);
		}	
	}

	public function deletechecktotal(){
		$id = filter_input(INPUT_POST, "id");
		// echo json_encode(["status" => 200, "message" => $id]);
		// exit();
		if ((new LineService)->deletechecktotal($id)) {
			echo json_encode(["status" => 200, "message" => "Delete Total Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Delete Total Failed"]);
		}	
	}
}