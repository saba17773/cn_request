<?php  

namespace Controllers;

use Models\CompanyService;

class CompanyController
{
	public function all()
	{
		echo CompanyService::all();
	}
}