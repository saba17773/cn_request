<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class ReportService
{
	public function allpdftrans($id,$comp)
	{
		if ($comp=='DSC') {
			$comp='dsc';
		}else{
			$comp='dv';
		}
		$conn = Database::connect();
		return Sqlsrv::queryJson($conn,"SELECT T.CompanyID
				,T.Type
				,T.DebitTransID
				,SUBSTRING(T.DebitTransID, 11, 3) AS NumberTrans
				,SUBSTRING(T.DebitTransID, 7, 4) AS YearTrans
				,T.CustomerCodeID
				,C.CustomerGroup
				,C.CustName
				,C.Address
				,T.CreateBy
				,U.FullName
				,T.CreateDateTime
				,T.Currency
				,Y.CurrencyName
				,T.SubjectID
				,S.Description[subjname]
				,T.CheckLine
				,T.Total
				,T.Remark
		FROM DebitTrans T
		-- LEFT JOIN CustomerDSCMaster C ON T.CustomerCodeID=C.CustCode AND C.Company=?
		JOIN 
			(
				SELECT CustCode,CustName,Company,Address,CustomerGroup
				FROM CustomerDSCMaster
				GROUP BY CustCode,CustName,Company,Address,CustomerGroup
			)C  ON T.CustomerCodeID=C.CustCode
				AND C.Company=?
		LEFT JOIN UserMaster U ON T.CreateBy=U.UserID
		LEFT JOIN SubjectMaster S ON T.SubjectID=S.SubjectID
		LEFT JOIN CurrencyMaster Y ON T.Currency=Y.CurrencyID
		WHERE T.DebitTransID=? AND T.Split=?",[$comp,$id,0]);
	}
	public function allpdfline($id)
	{
		$conn = Database::connect();
		return Sqlsrv::queryJson($conn,"SELECT L.ID
			  ,L.DebitTransID
		      ,L.Description
		      ,L.Amount
		      ,S.Description[subjectname]
		      ,R.RemarkDescription
		      ,T.Currency
		      ,C.CurrencyName
		FROM DebitLine L 
		LEFT JOIN DebitTrans T ON L.DebitTransID=T.DebitTransID AND T.Split=0
		LEFT JOIN RemarkMaster R ON L.ID=R.DebitLineID
		LEFT JOIN SubjectMaster S ON T.SubjectID=S.SubjectID
		LEFT JOIN CurrencyMaster C ON T.Currency=C.CurrencyID
		WHERE L.DebitTransID=? ORDER BY L.ID ASC",[$id]);
	}
	
}