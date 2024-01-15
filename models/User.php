<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class UserService
{
	public function all()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn,
			"SELECT U.UserID
			      ,U.Username
			      ,U.Password
			      ,U.FullName
			      ,U.DepartmentID
			      ,U.CompanyID
			      ,D.DepartmentName
			      ,C.Description
			      ,U.LevelID
			      ,L.Description[LevelName]
			      ,U.EMPID
			      ,U.USERACTIVE
			  FROM UserMaster U
			  LEFT JOIN DepartmentMaster D ON U.DepartmentID=D.DepartmentID
			  LEFT JOIN CompanyMaster C ON U.CompanyID=C.InternalCode
			  LEFT JOIN LevelMaster L ON U.LevelID=L.LevelID
			  ORDER BY U.DepartmentID DESC");
	}
	public function alllevel()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn,
			"SELECT *
			  FROM LevelMaster");
	}
	public function checkExistLogin($user,$pass)
	{
		$date = date("m-d-Y H:i:s");
		$conn = (new Database)->connect();
		
		return (new Sqlsrv)->hasRows(
			$conn,
			"SELECT * FROM UserMaster
			WHERE Username = ? AND Password = ? AND USERACTIVE =?",
			[$user,$pass,1]
		);

	}
	public function getUserLogin($user)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->queryArray(
				$conn,
				"SELECT * FROM UserMaster
				WHERE Username = ?",
				[$user]
			);
		return $query;

	}
	public function checkExist($username)
	{
		$username = trim($username);
		$conn = (new Database)->connect();
		return (new Sqlsrv)->hasRows(
			$conn,
			"SELECT * FROM UserMaster
			WHERE Username = ?",
			[$username]
		);
	}

	public function create($employee,$username,$password,$fullname,$depid,$compid,$level)
	{
		if ((new self)->checkExist($username) === true) {
			return false;
		}
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO UserMaster(EMPID, USERACTIVE, Username, Password, FullName, DepartmentID, CompanyID, LevelID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
			[$employee, 1, $username, $password, $fullname, $depid, $compid, $level]
		);

		if ($query) {

			$InsertLogUser = (new Sqlsrv)->insert(
		        $conn,
		        "INSERT INTO [EA_APP].[dbo].[TB_USER_APP] (EMP_CODE,USER_NAME,HOST_NAME,PROJECT_NAME,CREATE_DATE)
		        VALUES (?,?,?,?,getdate())",
		        [
		          $employee,
		          $username,
		          gethostbyaddr($_SERVER['REMOTE_ADDR']),
		          'CN Request'
		        ]
		    );

			return true;
		} else {
			return false;
		}
	}

	public function update($employee,$username,$password,$fullname,$depid,$compid,$level,$id)
	{

		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE UserMaster
			SET	EMPID = ?, USERACTIVE = ?, Password = ?, FullName=?, DepartmentID=?, CompanyID=?, LevelID=?
	        WHERE UserID = ?",
			[	
				$employee,
				1,
				$password,
				$fullname,
				$depid,
				$compid,
				$level,
				$id
			]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function delete($id,$empid,$username,$active)
	{
		if ($active==0) {
			$status=1;
		}else if($active==1){
			$status=0;
		}

		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			// "DELETE FROM UserMaster
	  //       WHERE UserID = ?",
			"UPDATE UserMaster SET USERACTIVE = ? WHERE UserID = ?",
			[
				$status,
				$id
			]
		);

		if ($query) {

			if ($status==1) {
				$InsertLogUser = (new Sqlsrv)->insert(
			        $conn,
			        "INSERT INTO [EA_APP].[dbo].[TB_USER_APP] (EMP_CODE,USER_NAME,HOST_NAME,PROJECT_NAME,CREATE_DATE)
			        VALUES (?,?,?,?,getdate())",
			        [
			          $empid,
			          $username,
			          gethostbyaddr($_SERVER['REMOTE_ADDR']),
			          'CN Request'
			        ]
			    );
			}else{
				$DeleteLogUser = (new Sqlsrv)->update(
					$conn,
					"UPDATE [EA_APP].[dbo].[TB_USER_APP]
					SET UPDATE_DATE = getdate(), STATUS = ?
					WHERE EMP_CODE = ? AND  USER_NAME= ? AND PROJECT_NAME = ?",
					[
						0,
						$empid,
				        $username,
				        'CN Request'
					]
				);
			}
			
			return true;
		} else {
			return false;
		}
	}
	public function changpassword($user,$pass)
	{

		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE UserMaster
			SET	Password = ? , Active = ?
	        WHERE Username = ?",
			[
				$pass,
				1,
				$user
			]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}

	public function employee()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn,
			"SELECT 
        		E.CODEMPID, E.EMPNAME, E.EMPLASTNAME, S.DIVISIONID, E.DEPARTMENTCODE ,D.DEPARTMENTNAME,S.DIVISIONNAME,E.COMPANYNAME,T.EMAIL
	        from [HRTRAINING].[dbo].[Employee] E
	        LEFT JOIN [HRTRAINING].[dbo].[DEPARTMENT] D ON E.DEPARTMENTCODE=D.DEPARTMENTCODE
	        LEFT JOIN [HRTRAINING].[dbo].[DIVISION] S ON E.DIVISIONCODE=S.DIVISIONCODE
	        LEFT JOIN [HRTRAINING].[dbo].[TEMPLOY1] T ON E.CODEMPID=T.CODEMPID
	        where E.STATUS != 9 
	        -- and T.EMAIL IS NOT NULL 
	        -- and T.EMAIL != 'dummy@tjs.co.th'
	        group by E.CODEMPID, E.EMPNAME, E.EMPLASTNAME, S.DIVISIONID, E.DEPARTMENTCODE,D.DEPARTMENTNAME,S.DIVISIONNAME,E.COMPANYNAME,T.EMAIL"
    	);
	}

	public function insertLogs($user,$employee)
	{
		$conn = (new Database)->connect();

		$getdate = date("Y-m-d H:i:s");
	    $computername = gethostbyaddr($_SERVER['REMOTE_ADDR']);
	    $remark = $_SERVER['HTTP_USER_AGENT'];

		$updateLastlogin = sqlsrv_query(
			$conn,
			"UPDATE UserMaster SET LastLogin = ?
			WHERE Username = ?",[$getdate,$user]
		);

	    $InsertLog = sqlsrv_query(
	      $conn,
	      "INSERT INTO [WEB_CENTER].[dbo].[LoginLogs] (EmployeeID,ComputerName,Username,LoginDevice,LoginDate,ProjectID,Remark)
	      VALUES(?,?,?,?,?,?,?)",[$employee,$computername,$user,1,$getdate,12,$remark]
	    );

	    $InsertlogApp = sqlsrv_query(
	    	$conn,
            "INSERT INTO [EA_APP].[dbo].[TB_LOG_APP] (EMP_CODE,USER_NAME,HOST_NAME,LOGIN_DATE,PROJECT_NAME)
            VALUES (?,?,?,?,?)",
            array(
                $employee,
	          	$user,
	          	$computername,
	          	date('Y-m-d H:i:s'),
	          	'CN Request'
            )
        );

	}

	public function insertLogsApp($user,$employee,$type)
	{
		$conn = (new Database)->connect();

		$getdate = date("Y-m-d H:i:s");
	    $computername = gethostbyaddr($_SERVER['REMOTE_ADDR']);
	    $remark = $_SERVER['HTTP_USER_AGENT'];

	    if ($type == "login") {
	    	$InsertlogApp = sqlsrv_query(
		    	$conn,
	            "INSERT INTO [EA_APP].[dbo].[TB_LOG_APP] (EMP_CODE,USER_NAME,HOST_NAME,LOGIN_DATE,PROJECT_NAME)
	            VALUES (?,?,?,?,?)",
	            array(
	                $employee,
		          	$user,
		          	$computername,
		          	date('Y-m-d H:i:s'),
		          	'CN Request'
	            )
	        );
	    }else{
	    	$InsertlogApp = sqlsrv_query(
		    	$conn,
	            "INSERT INTO [EA_APP].[dbo].[TB_LOG_APP] (EMP_CODE,USER_NAME,HOST_NAME,LOGOUT_DATE,PROJECT_NAME)
	            VALUES (?,?,?,?,?)",
	            array(
	                $employee,
		          	$user,
		          	$computername,
		          	date('Y-m-d H:i:s'),
		          	'CN Request'
	            )
	        );
	    }
	    
	}

}
