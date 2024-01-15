<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class TypeService
{
	public function all()
	{
		$conn = Database::connect();
		return Sqlsrv::queryJson($conn, 
			"SELECT * FROM TypeMaster");
	}
}