<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class LineService
{
	public function all($transid)
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT *
			FROM DebitLine
			WHERE DebitTransID=? ",[$transid]);
	}
	public function create($description,$amount,$transid)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO DebitLine(Description,Amount,DebitTransID,CreateBy,CreateDateTime) VALUES (?,?,?,?,getdate())",
			[$description,$amount,$transid,$_SESSION['userid']]
		);
		$sql = "SELECT T.Total
			FROM DebitTrans T
			WHERE T.DebitTransID='$transid'";
			$result=sqlsrv_query($conn,$sql);
			while($res = sqlsrv_fetch_object($result)) {
				 	$query = (new Sqlsrv)->insert($conn,"UPDATE DebitTrans SET Total=? WHERE DebitTransID=?",[$res->Total+$amount,$transid]);	
			}
		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function update($description,$amount,$transid,$id)
	{
		$conn = (new Database)->connect();
		$sql = "SELECT L.Amount,T.Total
				FROM DebitLine L
				LEFT JOIN DebitTrans T ON L.DebitTransID=T.DebitTransID
				WHERE L.ID='$id'";
			$result=sqlsrv_query($conn,$sql);
			while($res = sqlsrv_fetch_object($result)) {
					if ($res->Amount>$amount) {
						$sumamount = $res->Amount-$amount;
						$query = (new Sqlsrv)->insert($conn,"UPDATE DebitTrans SET Total=? WHERE DebitTransID=?",[($res->Total-$sumamount),$transid]);	
					}else if ($res->Amount<$amount) {
						$sumamount = $amount-$res->Amount;
						$query = (new Sqlsrv)->insert($conn,"UPDATE DebitTrans SET Total=? WHERE DebitTransID=?",[($res->Total+$sumamount),$transid]);	
					}
				 	
			}

		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE DebitLine
			SET	Description = ?, Amount=?, UpdateBy=?, UpdateDateTime=getdate()
	        WHERE ID = ?",
			[
				$description,
				$amount,
				$_SESSION['userid'],
				$id
			]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function delete($id,$transid)
	{
		$conn = (new Database)->connect();
		$sql = "SELECT TOP 1 L.Amount,T.Total
					FROM DebitLine L
					LEFT JOIN DebitTrans T ON L.DebitTransID=T.DebitTransID
					WHERE T.DebitTransID='$transid' AND L.ID='$id'";
			$result=sqlsrv_query($conn,$sql);
			while($res = sqlsrv_fetch_object($result)) {
						$query = (new Sqlsrv)->insert($conn,"UPDATE DebitTrans SET Total=? WHERE DebitTransID=?",[$res->Total-$res->Amount,$transid]);					 	
			}

		$query = (new Sqlsrv)->update(
			$conn,
			"DELETE FROM DebitLine
	        WHERE ID = ?",
			[
				$id
			]
		);

		

		if ($query) {
			return true;
		} else {
			return false;
		}
	}

	public function allremark($no)
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT *
			FROM RemarkMaster
			WHERE DebitLineID =?",
			[$no]
			);
	}

	public function allremarktrans($no)
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT Remark
			FROM DebitTrans
			WHERE ID =?",
			[$no]
			);
	}

	public function createremrak($id,$txtremark)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO RemarkMaster(DebitLineID,RemarkDescription) VALUES (?,?)",
			[$id,$txtremark]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}

	public function updateremrak($idremark,$txtremark)
	{
		$conn = (new Database)->connect();

		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE RemarkMaster
			SET	RemarkDescription = ?
	        WHERE RemarkID = ?",
			[
				$txtremark,
				$idremark
			]
		);
		if ($query) {
			return true;
		} else {
			return false;
		}
	}

	public function updateremraktrans($id,$txtremark)
	{
		$conn = (new Database)->connect();

		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE DebitTrans
			SET	Remark = ?
	        WHERE ID = ?",
			[
				$txtremark,
				$id
			]
		);
		if ($query) {
			return true;
		} else {
			return false;
		}
	}

	public function deleteremark($id,$type)
	{

		$conn = (new Database)->connect();
		if ($type=="deleteline") {
			$query = (new Sqlsrv)->update(
			$conn,
			"DELETE FROM RemarkMaster
	        WHERE DebitLineID = ?",
			[
				$id
			]
			);

			if ($query) {
				return true;
			} else {
				return false;
			}
		}else if($type=="deletetrans"){
			$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE DebitTrans SET Remark = null
	        WHERE ID = ?",
			[
				$id
			]
			);

			if ($query) {
				return true;
			} else {
				return false;
			}
		}
		
	}

	public function deletecheck($id)
	{

		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"DELETE FROM DebitLine
	        WHERE DebitTransID = ?",
			[
				$id
			]
		);

		$query_u = (new Sqlsrv)->update(
			$conn,
			"UPDATE DebitTrans
			SET	CheckLine = ?
	        WHERE DebitTransID = ?",
			[
				0,
				$id
			]
		);

		if ($query && $query_u) {
			return true;
		} else {
			return false;
		}
	}	

	public function deletechecktotal($id)
	{

		$conn = (new Database)->connect();
		$query_u = (new Sqlsrv)->update(
			$conn,
			"UPDATE DebitTrans
			SET	CheckLine = ?, Total = ?
	        WHERE DebitTransID = ?",
			[
				1,
				0,
				$id
			]
		);

		if ($query_u) {
			return true;
		} else {
			return false;
		}
	}


}