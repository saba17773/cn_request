<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class CompanyService
{
	public function all()
	{
		$conn = Database::connect();
		return Sqlsrv::queryJson($conn, 
			"SELECT * FROM CompanyMaster");
	}
}