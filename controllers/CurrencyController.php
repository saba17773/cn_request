<?php  

namespace Controllers;

use Models\CurrencyService;

class CurrencyController
{
	public function all()
	{
		echo CurrencyService::all();
	}
	public function create()
	{
		$currency = trim(filter_input(INPUT_POST, "currency"));
		$description = trim(filter_input(INPUT_POST, "description"));
		$form_type = trim(filter_input(INPUT_POST, "form_type"));
		$id = trim(filter_input(INPUT_POST, "id"));

		if ($form_type == "create") {
			if((new CurrencyService)->create($currency,$description) === false) {
				echo json_encode(["status" => 404, "message" => "Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Successful"]);
		}

		if ($form_type == "update") {
			if((new CurrencyService)->update($currency,$description,$id)=== false) {
				echo json_encode(["status" => 404, "message" => "Update Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Update Successful"]);
		}

	}
	public function delete(){
		$id = filter_input(INPUT_POST, "id");
		if ((new CurrencyService)->delete($id)) {
			echo json_encode(["status" => 200, "message" => "Delete Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Delete Failed"]);
		}	
	}
}