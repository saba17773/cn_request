<?php  

namespace Controllers;

use Models\TypeService;

class TypeController
{
	public function all()
	{
		echo TypeService::all();
	}
}