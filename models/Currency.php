<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class CurrencyService
{
	public function all()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT * FROM CurrencyMaster");
	}
	public function create($currency,$description)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO CurrencyMaster(CurrencyID,CurrencyName) VALUES (?,?)",
			[$currency,$description]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function update($currency,$description,$id)
	{

		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE CurrencyMaster
			SET	CurrencyID = ?,CurrencyName = ?
	        WHERE RecID = ?",
			[
				$currency,
				$description,
				$id
			]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function delete($id)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"DELETE FROM CurrencyMaster
	        WHERE RecID = ?",
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