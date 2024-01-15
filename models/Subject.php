<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class SubjectService
{
	public function all()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT * FROM SubjectMaster");
	}
	public function alldebit()
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT * FROM SubjectMaster WHERE Active=1");
	}
	public function create($subject,$active)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO SubjectMaster(Description,Active) VALUES (?,?)",
			[$subject,$active]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function update($subject,$active,$id)
	{

		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->update(
			$conn,
			"UPDATE SubjectMaster
			SET	Description = ?, Active = ?
	        WHERE SubjectID = ?",
			[
				$subject,
				$active,
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
			"DELETE FROM SubjectMaster
	        WHERE SubjectID = ?",
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