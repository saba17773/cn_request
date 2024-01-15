<?php  

namespace Controllers;

use Models\LinkService;
use Components\Database;
use Wattanar\Sqlsrv;

class LinkController
{
	public function all()
	{
		$no = trim(filter_input(INPUT_GET, "no"));
		echo (new LinkService)->all($no);
	}
	public function alluserlist()
	{
		$no = trim(filter_input(INPUT_GET, "no"));
		echo (new LinkService)->alluserlist($no);
	}
}