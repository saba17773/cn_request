<?php  

namespace Controllers;

use Models\SubjectService;

class SubjectController
{
	public function all()
	{
		echo SubjectService::all();
	}

	public function alldebit()
	{
		echo SubjectService::alldebit();
	}

	public function create()
	{
		$subject = trim(filter_input(INPUT_POST, "subject"));
		$active = trim(filter_input(INPUT_POST, "active"));
		$form_type = trim(filter_input(INPUT_POST, "form_type"));
		$id = trim(filter_input(INPUT_POST, "id"));

		if ($form_type == "create") {
			if((new SubjectService)->create($subject,$active) === false) {
				echo json_encode(["status" => 404, "message" => "Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Successful"]);
		}

		if ($form_type == "update") {
			if((new SubjectService)->update($subject,$active,$id) === false) {
				echo json_encode(["status" => 404, "message" => "Update Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Update Successful"]);
		}

	}
	public function delete(){
		$id = filter_input(INPUT_POST, "id");
		if ((new SubjectService)->delete($id)) {
			echo json_encode(["status" => 200, "message" => "Delete Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Delete Failed"]);
		}	
	}
}