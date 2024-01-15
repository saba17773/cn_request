<?php

namespace Models;
use Components\Database;
use Wattanar\Sqlsrv;

class TransService
{
	public function all()
	{
		$conn = (new Database)->connect();
		
			// return (new Sqlsrv)->queryJson($conn, 
			$sql = "SELECT TOP 100 T.ID,
			      T.ParentID
			      ,T.Split
			      ,T.DebitTransID
			      ,T.Type
			      ,T.CustomerCodeID
			      ,T.CompanyID
			      ,T.SubjectID
			      ,CY.CurrencyName
			      ,T.CreateBy
			      ,T.CreateDateTime
			      ,T.ApproveBy
			      ,T.ApproveDateTime
			      ,T.Status
			      ,T.CancelBy
			      ,T.CancelDateTime
			      ,S.Description
			      ,ST.StatusName
			      ,CT.CustName
			      -- ,T.Total[Amount]
			      ,T.CnAmount
			      ,T.CnNumber
			      ,T.Total
			      ,T.CheckLine
			      ,T.CheckClaim
			      ,CASE
					WHEN T.CheckLine=1 THEN (SELECT SUM(Amount) FROM DebitLine WHERE DebitTransID=T.DebitTransID)
					ELSE T.Total END [Amount]
			FROM DebitTrans T
			LEFT JOIN UserMaster CB ON T.CreateBy=CB.UserID
			LEFT JOIN SubjectMaster S ON T.SubjectID=S.SubjectID
			LEFT JOIN StatusMaster ST ON T.Status=ST.StatusID
			LEFT JOIN CurrencyMaster CY  ON T.Currency=CY.CurrencyID
			JOIN 
			(
				SELECT CustCode,CustName,Company
				FROM CustomerDSCMaster
				GROUP BY CustCode,CustName,Company
			)CT ON T.CustomerCodeID=CT.CustCode
				AND  CT.Company=
				CASE 
					 WHEN T.CompanyID='DSC' THEN 'dsc'
					 WHEN T.CompanyID!='DSC' THEN 'dv'
				END
			ORDER BY ParentID DESC";

			if (isset($_GET['filterscount']))
	        {
	            $filterscount = $_GET['filterscount'];
	            
	            if ($filterscount > 0)
	            {
	                $sql = "";
	                $where = "WHERE (";
	                $tmpdatafield = "";
	                $tmpfilteroperator = "";
	                for ($i=0; $i < $filterscount; $i++)
	                {
	                    // get the filter's value.
	                    $filtervalue = $_GET["filtervalue" . $i];
	                    // get the filter's condition.
	                    $filtercondition = $_GET["filtercondition" . $i];
	                    // get the filter's column.
	                    $filterdatafield = $_GET["filterdatafield" . $i];
	                    // get the filter's operator.
	                    $filteroperator = $_GET["filteroperator" . $i];
	                    
	                    if ($tmpdatafield == "")
	                    {
	                        $tmpdatafield = $filterdatafield;           
	                    }
	                    else if ($tmpdatafield <> $filterdatafield)
	                    {
	                        $where .= ")AND(";
	                    }
	                    else if ($tmpdatafield == $filterdatafield)
	                    {
	                        if ($tmpfilteroperator == 0)
	                        {
	                            $where .= " AND ";
	                        }
	                        else $where .= " OR ";  
	                    }
	                    
	                    // build the "WHERE" clause depending on the filter's condition, value and datafield.
	                    switch($filtercondition)
	                    {
	                        case "CONTAINS":
	                            $where .= " " . $filterdatafield . " LIKE '%" . $filtervalue ."%'";
	                            break;
	                        case "DOES_NOT_CONTAIN":
	                            $where .= " " . $filterdatafield . " NOT LIKE '%" . $filtervalue ."%'";
	                            break;
	                        case "EQUAL":
	                            $where .= " " . $filterdatafield . " = '" . $filtervalue ."'";
	                            break;
	                        case "NOT_EQUAL":
	                            $where .= " " . $filterdatafield . " <> '" . $filtervalue ."'";
	                            break;
	                        case "GREATER_THAN":
	                            $where .= " " . $filterdatafield . " > '" . $filtervalue ."'";
	                            break;
	                        case "LESS_THAN":
	                            $where .= " " . $filterdatafield . " < '" . $filtervalue ."'";
	                            break;
	                        case "GREATER_THAN_OR_EQUAL":
	                            $where .= " " . $filterdatafield . " >= '" . $filtervalue ."'";
	                            break;
	                        case "LESS_THAN_OR_EQUAL":
	                            $where .= " " . $filterdatafield . " <= '" . $filtervalue ."'";
	                            break;
	                        case "STARTS_WITH":
	                            $where .= " " . $filterdatafield . " LIKE '" . $filtervalue ."%'";
	                            break;
	                        case "ENDS_WITH":
	                            $where .= " " . $filterdatafield . " LIKE '%" . $filtervalue ."'";
	                            break;
	                    }
	                                    
	                    if ($i == $filterscount - 1)
	                    {
	                        $where .= ")";
	                    }
	                    
	                    $tmpfilteroperator = $filteroperator;
	                    $tmpdatafield = $filterdatafield;           
	                }
	                // build the query.
	                 $sql = "SELECT TOP 100 * FROM ( SELECT T.ID,
					      T.ParentID
					      ,T.Split
					      ,T.DebitTransID
					      ,T.Type
					      ,T.CustomerCodeID
					      ,T.CompanyID
					      ,T.SubjectID
					      ,CY.CurrencyName
					      ,T.CreateBy
					      ,T.CreateDateTime
					      ,T.ApproveBy
					      ,T.ApproveDateTime
					      ,T.Status
					      ,T.CancelBy
					      ,T.CancelDateTime
					      ,S.Description
					      ,ST.StatusName
					      ,CT.CustName
					      -- ,T.Total[Amount]
					      ,T.CnAmount
					      ,T.CnNumber
					      ,T.Total
					      ,T.CheckLine
					      ,T.CheckClaim
					      ,CASE
							WHEN T.CheckLine=1 THEN (SELECT SUM(Amount) FROM DebitLine WHERE DebitTransID=T.DebitTransID)
							ELSE T.Total END [Amount]
					FROM DebitTrans T
					LEFT JOIN UserMaster CB ON T.CreateBy=CB.UserID
					LEFT JOIN SubjectMaster S ON T.SubjectID=S.SubjectID
					LEFT JOIN StatusMaster ST ON T.Status=ST.StatusID
					LEFT JOIN CurrencyMaster CY  ON T.Currency=CY.CurrencyID
					JOIN 
					(
						SELECT CustCode,CustName,Company
						FROM CustomerDSCMaster
						GROUP BY CustCode,CustName,Company
					)CT ON T.CustomerCodeID=CT.CustCode
						AND  CT.Company=
						CASE 
							 WHEN T.CompanyID='DSC' THEN 'dsc'
							 WHEN T.CompanyID!='DSC' THEN 'dv'
						END) A " . $where . "ORDER BY A.ParentID DESC";     
	            }
	        }

	        return  (new Sqlsrv)->queryJson($conn,$sql);

	}
	public function allline($transid)
	{
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT T.ID
			      ,T.DebitTransID
			      ,T.Type
			      ,T.CustomerCodeID
			      ,T.CompanyID
			      ,T.SubjectID
			      ,T.CreateBy
			      ,T.CreateDateTime
			      ,T.ApproveBy
			      ,T.ApproveDateTime
			      ,T.Status
			      ,T.CancelBy
			      ,T.CancelDateTime 
			      ,S.Description
			FROM DebitTrans T
			LEFT JOIN SubjectMaster S ON T.SubjectID=S.SubjectID
			WHERE T.DebitTransID=? ",[$transid]);
	}
	public function checknumberExist($company,$type)
	{
		$year =  date("Y");
		$conn = (new Database)->connect();
		return (new Sqlsrv)->hasRows(
				$conn,
				"SELECT TOP 1 * FROM NumberSequence WHERE NumOfYear=? AND CompanyID=? AND Type=?",
				[$year,$company,$type]
			);
	}
	public function number($company,$type)
	{
		$year =  date("Y");
		$conn = (new Database)->connect();
		return (new Sqlsrv)->queryJson($conn, 
			"SELECT TOP 1 * FROM NumberSequence WHERE NumOfYear=? AND CompanyID=? AND Type=?",
			[$year,$company,$type]
			);	
	}
	public function createnumber($company,$type)
	{
		$year =  date("Y");
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO NumberSequence(CompanyID,Request,Type,Highest,NextRec,NumOfYear) VALUES (?,?,?,?,?,?)",
			[$company,'R',$type,3,1,$year]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function updatenumber($NextNum,$company,$type)
	{
		$year =  date("Y");
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"UPDATE NumberSequence SET NextRec=? WHERE NumOfYear=? AND CompanyID=? AND Type=?",
			[$NextNum,$year,$company,$type]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function create($NumberSequence,$company,$type,$customercode,$subjectid,$currency,$total,$checkline,$checkclaim)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"INSERT INTO DebitTrans(DebitTransID,Type,CustomerCodeID,CompanyID,SubjectID,CreateBy,CreateDateTime,Status,Currency,Split,Total,CheckLine,CheckClaim) VALUES (?,?,?,?,?,?,getdate(),?,?,?,?,?,?)",
			[$NumberSequence,$type,$customercode,$company,$subjectid,$_SESSION['userid'],1,$currency,0,$total,$checkline,$checkclaim]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function update($transid,$currency,$customercode,$subjectid,$total,$checkclaim)
	{	
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"UPDATE DebitTrans SET Currency=? , CustomerCodeID=? , SubjectID=?, Total=?, CheckClaim=? WHERE DebitTransID=?",
			[$currency,$customercode,$subjectid,$total,$checkclaim,$transid]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function deletefile($file)
	{

		$conn = (new Database)->connect();
        $filetarget         = "upload/".$file;
        $flgDelete  = unlink($filetarget);
		$query = (new Sqlsrv)->update(
			$conn,
			"DELETE FROM DataFile
	        WHERE FileName = ?",
			[
				$file
			]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function approve($id)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"UPDATE DebitTrans SET Status=? , ApproveBy=? , ApproveDateTime=getdate() WHERE DebitTransID=?",
			[2,$_SESSION["userid"],$id]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
	public function cancel($id)
	{
		$conn = (new Database)->connect();
		$query = (new Sqlsrv)->insert(
			$conn,
			"UPDATE DebitTrans SET Status=? , CancelBy=? , CancelDateTime=getdate() WHERE DebitTransID=?",
			[10,$_SESSION["userid"],$id]
		);

		if ($query) {
			return true;
		} else {
			return false;
		}
	}
}