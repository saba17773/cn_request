<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class DepartmentService
{
	public function all()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT * FROM DepartmentMaster");
	}
	public function sync()
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"INSERT INTO DepartmentMaster(DepartmentName)
				SELECT A.DSG_DESCRIPTION
				FROM [FREY\LIVE].[DSL_AX40_SP1_LIVE].[dbo].[DSG_DEPARTMENTTABLE] A 
				WHERE A.DSG_DESCRIPTION NOT IN 
					(
						SELECT CN_Request.dbo.DepartmentMaster.DepartmentName FROM CN_Request.DBO.DepartmentMaster
					)
				GROUP BY A.DSG_DESCRIPTION"
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
}