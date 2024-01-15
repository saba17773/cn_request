<?php

namespace Components;

class Authentication
{
	public function isLogin()
	{
		if(isset($_SESSION["user"])){
			return true;
		} else {
			return false;
		}
	}
}