<?php

namespace Components;

class Database
{
	public function connect()
	{
		return self::connector(
				"Mormont\Develop",
				"CN_Request",
				"EAconnection",
				"l;ylfu;yo0yomiN"
			);
	}

	public function connector($server, $dbname, $username, $password)
	{
		$connection = array( 
			"Database" => $dbname, 
			"UID" => $username, 
			"PWD" => $password ,
			"CharacterSet" => "UTF-8",
			"ReturnDatesAsStrings" => true,
			"MultipleActiveResultSets" => true
		);

		$conn = sqlsrv_connect( 
			$server, 
			$connection
		);

		return $conn;
	}
}