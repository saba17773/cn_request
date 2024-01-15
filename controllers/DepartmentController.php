<?php  

namespace Controllers;

use Models\DepartmentService;

class DepartmentController
{
	public function all()
	{
		echo DepartmentService::all();
	}
	public function sync()
	{
		if ((new DepartmentService)->sync()) {
			echo json_encode(["status" => 200, "message" => "Sync Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Sync Failed"]);
		}	
	}
}