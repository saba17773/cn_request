<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class LinkService
{
	public function all($no)
	{
		//$no="DSICN2016001";
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT * FROM DataFile WHERE TransID = ?",
			[$no]
			);
	}

	public function alluserlist($no)
	{
		//$no="DSICN2016001";
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT TOP 1 T.DebitTransID
			       ,(SELECT U.FullName FROM UserMaster U 
				   WHERE U.UserID = T.CreateBy)[CreateBy]
				   ,(SELECT U.FullName FROM UserMaster U 
				   WHERE U.UserID = T.ApproveBy)[ApproveBy]
				   ,(SELECT U.FullName FROM UserMaster U 
				   WHERE U.UserID = T.CancelBy)[CancelBy]
			FROM DebitTrans T
			WHERE T.DebitTransID =?",
			[$no]
			);
	}
}