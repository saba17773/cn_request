<?php  

namespace Controllers;

use Models\CustomerService;

class CustomerController
{
	public function all()
	{
		$company = trim(filter_input(INPUT_GET, "company"));
		echo (new CustomerService)->all($company);
	}
	public function allplant()
	{
		echo (new CustomerService)->allplant();
	}
	public function sync()
	{
		if ((new CustomerService)->sync()) {
			echo json_encode(["status" => 200, "message" => "Sync Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Sync Failed"]);
		}	
	}
}