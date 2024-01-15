<?php  

namespace Controllers;

use Models\TransService;
use Components\Database;
use Wattanar\Sqlsrv;

class TransController
{
	public function all()
	{
		echo (new TransService)->all();
	}
	public function allline()
	{
		$transid = trim(filter_input(INPUT_GET, "p"));
		echo (new TransService)->allline($transid);
	}
	public function create()
	{
		$company = trim(filter_input(INPUT_POST, "company"));
		$customercode = trim(filter_input(INPUT_POST, "customercode"));
		$type = trim(filter_input(INPUT_POST, "type"));
		$subjectid = trim(filter_input(INPUT_POST, "subjectid"));
		$currency = trim(filter_input(INPUT_POST, "currency"));
		$total = trim(filter_input(INPUT_POST, "total"));
		$checkline = trim(filter_input(INPUT_POST, "checkline"));
		$checkclaim = trim(filter_input(INPUT_POST, "checkclaim"));
		$conn = (new Database)->connect();

		if ($checkline==true) {
			$checkline=1;
			$total=NULL;
		}else{
			$checkline=0;
			$total = str_replace(",","",$total);
		}
		if ($checkclaim==true) {
			$checkclaim=1;
		}else{
			$checkclaim=0;
		}
		// echo $checkclaim;
		// exit();
		if((new TransService)->checknumberExist($company,$type) === false) {
			if((new TransService)->createnumber($company,$type) === false) {
				echo "Failed Number";
				exit;
			}
			//echo "Success";
		}
		//GenNumber
        $arr = (new TransService)->number($company,$type);
        $json_decode  = json_decode($arr);
       	
			$before = 0;
		    $strlen = strlen($json_decode[0]->NextRec);
			    if ($strlen>=$json_decode[0]->Highest){	
			    	$json_decode[0]->Highest++;	$before = '';
			    }
		    for($i=1;$i<=$json_decode[0]->Highest-$strlen;$i++){
		        @$pre.=$before;
		    }
		    $NumberSequence = $company.$json_decode[0]->Request.$type.$json_decode[0]->NumOfYear.$pre.$json_decode[0]->NextRec;
        //InsertTrans
		// echo $NumberSequence;
		// exit();
		if ($company=="" && $json_decode[0]->Request=="" && $type=="" && $json_decode[0]->NumOfYear=="" && $json_decode[0]->NextRec=="") {
			echo "<h2>"."NumberSequence Not Found !"."<br>"."Please Create Again"."</h2>";
			exit;
		}else{

			if((new TransService)->create($NumberSequence,$company,$type,$customercode,$subjectid,$currency,$total,$checkline,$checkclaim) === false) {
				echo "<h2>"."Failed Trans"."</h2>";
				exit;
			}
			//UpdateNumber
			$NextNum = $json_decode[0]->NextRec+1;
			if((new TransService)->updatenumber($NextNum,$company,$type)=== false){
				echo "<h2>"."Failed UpdateNumber"."</h2>";
				exit;
			}
			//UploadFile
			if(isset($_FILES["fileUpload"]["name"])){
	                for($i=0;$i<count($_FILES["fileUpload"]["name"]);$i++)
	                {
	                    if($_FILES["fileUpload"]["name"][$i] != "")
	                    {   
	            
	            $file = strtolower($_FILES["fileUpload"]["name"][$i]);
	            $type= strrchr($file,".");
	            date_default_timezone_set("asia/bangkok");
	            $nf = substr(date('Ymd_His'), 0).round(microtime(true) * 1000);  
	            $newfilenameDes= $NumberSequence."_".$nf.$type;
	            
	            if(move_uploaded_file($_FILES["fileUpload"]["tmp_name"][$i],"upload/".$newfilenameDes)){
	                
	                $InsertFile = sqlsrv_query(
	                $conn,
		                "INSERT INTO DataFile(TransID,FileName) VALUES(?,?)",
		                array($NumberSequence,$newfilenameDes,'1')
	                );
	            }else{
	                echo "<h2>"."Upload Failed!"."</h2>";
	            }
	                    }
	                }
	                    
	        }

			echo '<script>';
	        echo 'alert("Success !");';
	        echo 'location.href="/CN_Request"';
	        echo '</script>';
			//header("Location: /CN_Request/"); 
		}
	}
	public function update()
	{
		$company = trim(filter_input(INPUT_POST, "company"));
		$customercode = trim(filter_input(INPUT_POST, "customercode"));
		$type = trim(filter_input(INPUT_POST, "type"));
		$subjectid = trim(filter_input(INPUT_POST, "subjectid"));
		$currency = trim(filter_input(INPUT_POST, "currency"));
		$transid = trim(filter_input(INPUT_POST, "transid"));
		$total = trim(filter_input(INPUT_POST, "total"));
		//$checkline = trim(filter_input(INPUT_POST, "checkline"));
		$checkclaim = trim(filter_input(INPUT_POST, "checkclaim"));
		$conn = (new Database)->connect();
		$total = str_replace(",","",$total);

		if ($checkclaim==true) {
			$checkclaim=1;
		}else{
			$checkclaim=0;
		}
		 // echo $checkclaim;
		 // exit();
		if((new TransService)->update($transid,$currency,$customercode,$subjectid,$total,$checkclaim)=== false){
			echo "Failed UpdateTrans";
			exit;
		}
		if(isset($_FILES["fileUpload"]["name"])){
                for($i=0;$i<count($_FILES["fileUpload"]["name"]);$i++)
                {
                    if($_FILES["fileUpload"]["name"][$i] != "")
                    {   
            
            $file = strtolower($_FILES["fileUpload"]["name"][$i]);
            $type= strrchr($file,".");
            
            $nf = substr(date('Ymd_His'), 0).round(microtime(true) * 1000);  
            $newfilenameDes= $transid."_".$nf.$type;
            
            if(move_uploaded_file($_FILES["fileUpload"]["tmp_name"][$i],"upload/".$newfilenameDes)){
                
                $InsertFile = sqlsrv_query(
                $conn,
	                "INSERT INTO DataFile(TransID,FileName) VALUES(?,?)",
	                array($transid,$newfilenameDes,'1')
                );
            }else{
                echo "Upload Failed!";
            }
                    }
                }
                    
        }
		echo '<script>';
        echo 'alert("Success !");';
        echo 'location.href="/CN_Request"';
        echo '</script>';
	}
	public function deletefile()
	{
		$file = trim(filter_input(INPUT_GET, "file"));
		if((new TransService)->deletefile($file) === false) {
			echo json_encode(["status" => 404, "message" => "Failed"]);
			exit;
		}
		echo json_encode(["status" => 200, "message" => "Successful"]);
	}
	public function approve()
	{
		$id = trim(filter_input(INPUT_POST, "id"));
		if((new TransService)->approve($id) === false) {
			echo json_encode(["status" => 404, "message" => "Failed"]);
			exit;
		}
		echo json_encode(["status" => 200, "message" => "Successful"]);
	}
	public function cancel()
	{
		$id = trim(filter_input(INPUT_POST, "id"));
		if((new TransService)->cancel($id) === false) {
			echo json_encode(["status" => 404, "message" => "Failed"]);
			exit;
		}
		echo json_encode(["status" => 200, "message" => "Successful"]);
	}
}