<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class CustomerService
{
	public function all($company)
	{
		$conn = (new Database)->connect();
		
		if ($company=='DSC') {
			$company='dsc';
		}else{
			$company='dv';
		}
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT C.CustCode
			      ,C.CustName
			      ,C.Address
			      ,C.CustomerGroup
			      ,G.Name[NameGroup]
			      ,C.Currency
			      ,C.Company
			  FROM CustomerDSCMaster C
			  LEFT JOIN CustomerGroupMaster G ON C.CustomerGroup=G.CustomerGroup
			  WHERE C.Company=?
			  GROUP BY C.CustCode
			      ,C.CustName
			      ,C.Address
			      ,C.CustomerGroup
			      ,G.Name
			      ,C.Currency
			      ,C.Company",[$company]);
	}
	public function allplant()
	{
		$conn = (new Database)->connect();
		
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT C.CustCode
			      ,C.CustName
			      ,C.Address
			      ,C.CustomerGroup
			      ,G.Name[NameGroup]
			      ,C.Currency
			      ,C.Company
			  FROM CustomerDSCMaster C
			  LEFT JOIN CustomerGroupMaster G ON C.CustomerGroup=G.CustomerGroup
			  GROUP BY C.CustCode
			      ,C.CustName
			      ,C.Address
			      ,C.CustomerGroup
			      ,G.Name
			      ,C.Currency
			      ,C.Company");
	}
	public function sync()
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"INSERT INTO CustomerDSCMaster(CustCode,CustName,Address,CustomerGroup,Company)
			SELECT A.ACCOUNTNUM COLLATE Latin1_General_CS_AS, A.NAME COLLATE Latin1_General_CS_AS,A.ADDRESS COLLATE Latin1_General_CS_AS,A.CustGroup,A.DATAAREAID
			FROM [FREY\LIVE].[DSL_AX40_SP1_LIVE].[dbo].[CUSTTABLE] A 
			WHERE A.ACCOUNTNUM NOT IN 
				(
					SELECT CN_Request.dbo.CustomerMaster.CustCode FROM CN_Request.DBO.CustomerMaster
				) 
			AND A.CustGroup !='10' AND A.NAME !=''
			-- AND A.DATAAREAID='dv'"
		);

		if ($query) {
			$query = (new Sqlsrv)->update(
				$conn,
				"UPDATE 
					W
				SET 
					W.CustName = A.NAME
				FROM CustomerDSCMaster W
				LEFT JOIN  [FREY\LIVE].[DSL_AX40_SP1_LIVE].[dbo].[CUSTTABLE] A  
				ON A.ACCOUNTNUM = W.CustCode 
				AND A.DATAAREAID = W.Company"
			);

			return true;
		} else {
			return false;
		}
	}
}