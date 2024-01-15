<?php  

namespace Controllers;

use Models\UserService;

class UserController
{
	public function all()
	{
		echo UserService::all();
	}
	public function alllevel()
	{
		echo UserService::alllevel();
	}
	public function create()
	{
		$employee = trim(filter_input(INPUT_POST, "user_employee"));
		$username = trim(filter_input(INPUT_POST, "username"));
		$password = trim(filter_input(INPUT_POST, "password"));
		$fullname = trim(filter_input(INPUT_POST, "fullname"));
		$depid = trim(filter_input(INPUT_POST, "depid"));
		$compid = trim(filter_input(INPUT_POST, "compid"));
		$level = trim(filter_input(INPUT_POST, "level"));
		$form_type = trim(filter_input(INPUT_POST, "form_type"));
		$id = trim(filter_input(INPUT_POST, "id"));
		
		if ($form_type == "create") {
			if((new UserService)->create($employee,$username,$password,$fullname,$depid,$compid,$level) === false) {
				echo json_encode(["status" => 404, "message" => "Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Successful"]);
		}

		if ($form_type == "update") {
			if((new UserService)->update($employee,$username,$password,$fullname,$depid,$compid,$level,$id) === false) {
				echo json_encode(["status" => 404, "message" => "Update Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "Update Successful"]);
		}

	}
	
	public function delete(){
		$id = filter_input(INPUT_POST, "id");
		$empid = filter_input(INPUT_POST, "empid");
		$username = filter_input(INPUT_POST, "username");
		$active = filter_input(INPUT_POST, "active");
		if ((new UserService)->delete($id,$empid,$username,$active)) {
			echo json_encode(["status" => 200, "message" => "Delete Successful"]);
		} else {
			echo json_encode(["status" => 404, "message" => "Delete Failed"]);
		}	
	}
	public function login()
	{
		$user = filter_input(INPUT_POST, "inputUsername");
		$pass = filter_input(INPUT_POST, "inputPassword");
		//echo UserService::checkExist();
		if((new UserService)->checkExistLogin($user,$pass) === false) {
				echo json_encode(["status" => 404, "message" => "Login Failed", "active" => "1"]);
				exit;
		}
		$user_data = UserService::getUserLogin($user);
		if (!$user_data) {
			exit(json_encode(["status" => 404, "message" => "Login Error"]));
		}

		$insertLogs = UserService::insertLogs($user_data[0]["Username"],$user_data[0]["EMPID"]);
		$insertLogsApp = UserService::insertLogsApp($user_data[0]["Username"],$user_data[0]["EMPID"],'login');

		$_SESSION["active"] = $user_data[0]["Active"];
		$_SESSION["userid"] = $user_data[0]["UserID"];
		$_SESSION["user"] = $user_data[0]["Username"];
		$_SESSION["pass"] = $user_data[0]["Password"];
		$_SESSION["fullname"] = $user_data[0]["FullName"];
		$_SESSION["company"] = $user_data[0]["CompanyID"];
		$_SESSION["levelid"] = $user_data[0]["LevelID"];
		$_SESSION["empid"] = $user_data[0]["EMPID"];

		echo json_encode(["status" => 200, "message" => "Login Successful", "active" => $_SESSION["active"]]);
	}
	public function changpassword()
	{
		$user = filter_input(INPUT_POST, "username");
		$pass = filter_input(INPUT_POST, "connewpassword");
		if((new UserService)->changpassword($user,$pass) === false) {
				echo json_encode(["status" => 404, "message" => "Changpassword Failed"]);
				exit;
		}
		session_destroy();
		echo json_encode(["status" => 200, "message" => "Changpassword Successful"]);
	}
	public function logout()
	{
		$insertLogsApp = UserService::insertLogsApp($_SESSION["user"],$_SESSION["empid"],'logout');

		$redirect_path = root . "login";
		session_destroy();
		header("Location:" . $redirect_path);
	}
	public function employee()
	{
		echo UserService::employee();
	}

}