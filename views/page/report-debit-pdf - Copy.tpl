<?php		

  	$total_sub = substr($Total, -2);
  	if ($total_sub == 00 ) {
  	    define("MAJOR", '');
  	}else{
  		define("MAJOR", 'point');
  	}

  	define("MINOR", '');

  	class toWords
  	{
      	var $pounds;
      	var $pence;
      	var $major;
      	var $minor;
      	var $words = '';
      	var $number;
      	var $magind;
      	var $units = array('', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine');
      	var $teens = array('Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen');
      	var $tens = array('', 'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety');
      	var $mag = array('', 'Thousand', 'Million', 'Billion', 'Trillion');

      	function toWords($amount, $major = MAJOR, $minor = MINOR){   
          	$this->__toWords__((int)($amount), $major);
          	$whole_number_part = $this->words;
          	$strform = number_format($amount,2);
          	$right_of_decimal = (int)substr($strform, strpos($strform,'.')+1);
          	$this->__toWords__($right_of_decimal, $minor);
          	$this->words = $whole_number_part . ' ' . $this->words;
      	}

      	function __toWords__($amount, $major){
          	$this->major  = $major;
          	$this->number = number_format($amount, 2);
          	list($this->pounds, $this->pence) = explode('.', $this->number);
          	$this->words = " $this->major";
          	if ($this->pounds == 0)
	            $this->words = "zero $this->words";

	        else {
              	$groups = explode(',', $this->pounds);
              	$groups = array_reverse($groups);
              	for ($this->magind = 0; $this->magind < count($groups); $this->magind++) {
                  	if (($this->magind == 1) && (strpos($this->words, 'hundred') === false) && ($groups[0] != '000'))
                      $this->words = '  ' . $this->words;
                  	$this->words = $this->_build($groups[$this->magind]) . $this->words;
              	}
          	}
      	}

      	function _build($n){
          	$res = '';
          	$na  = str_pad("$n", 3, "0", STR_PAD_LEFT);
          	if ($na == '000')
            	return '';
          	if ($na{0} != 0)
              	$res = ' ' . $this->units[$na{0}] . ' hundred';
          	if (($na{1} == '0') && ($na{2} == '0'))
              	return $res . ' ' . $this->mag[$this->magind];
      		
      		$res .= $res == '' ? '' : ' ';
      		$t = (int) $na{1};
      		$u = (int) $na{2};
          	switch ($t) {
              	case 0:
                  	$res .= ' ' . $this->units[$u];
                  	break;
              	case 1:
                  	$res .= ' ' . $this->teens[$u];
                  	break;
              	default:
                  	$res .= ' ' . $this->tens[$t] . ' ' . $this->units[$u];
                  	break;
          	}
          	$res .= ' ' . $this->mag[$this->magind];
          	return $res;
      	}

    }

	function txtHeader($new_date,$type_show,$comp,$DebitTransID,$CustomerGroup,$CustomerCodeID,$CustName,$Address){
		$credit .= '<table>';
		
			if ($comp == 'SVO') {
				$credit .= '
				<tr>
			      	<td colspan="3" width="100%">
			      	<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;padding-top:-25;height:90px;" /></a>
			      	</td>
			    </tr>';
			}else if($comp == 'DSC'){
				$credit .= '
				<tr>
			      	<td colspan="3" width="100%">
			      	<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;padding-top:-20;height:85px;" /></a>
			      	</td>
			    </tr>';
			}else if($comp == 'DSL'){
				$credit .= '
				<tr>
			      	<td colspan="3" width="100%">
			      	<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;padding-top:-20;height:85px;" /></a>
			      	</td>
			    </tr>';
			}else if($comp == 'DRB'){
				$credit .= '
				<tr>
			      	<td colspan="3" width="100%">
			      	<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;padding-top:-30;height:95px; width:620px;" /></a>
			      	</td>
			    </tr>';
			}else if($comp == 'STR'){
				$credit .= '
				<tr>
			      	<td colspan="3" width="100%">
			      	<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;padding-top:-20;height:85px; width:650px;" /></a>
			      	</td>
			    </tr>';
			}else if($comp == 'DSI'){
				$credit .= '
				<tr>
			      	<td colspan="3" width="100%">
			      	<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;padding-top:-25;height:90px; width:620px;" /></a>
			      	</td>
			    </tr>';
			}			
		
		$credit .= '	
			<tr class="trx">
				<td class="tdx" align="left" width="20%">
				</td>
				<td class="tdx" colspan="3" align="center" width="60%">
					<h1><b>
					<p><font face="verdana">
					Request for
					<font color="red">'.$type_show.'</font> Note
					</font></p>
					</b></h1>
				</td>
				<td class="tdx" align="right" width="20%">
					<i>Date : '.$new_date.'</i>
				</td>
			</tr>
			<tr class="trx">
				<td class="tdx" colspan="3">
					Plant : '.$comp.'
				</td>
			</tr>
			<tr class="trx">
				<td class="tdx" colspan="3">
					Type :  '.$type_show.'
				</td>
			</tr>
			<tr class="trx">
				<td class="tdx" colspan="3">
					Request No :  '.$DebitTransID.'
				</td>
			</tr>
			<tr class="trx">
				<td class="tdx" colspan="5">
					Customer Group : '.$CustomerGroup.'
				</td>
			</tr>
			<tr class="tr">
				<td class="tdx" colspan="7">
					CustCode : '.$CustomerCodeID.'<br>
					Customer Name : '.$CustName.'<br>
					Customer Address :  '.$Address.'
				</td>
			</tr>';

		$credit .= '</table>';

		return $credit;
	}

	function txtBody($datajsonT,$datajsonL,$Total){

		$body .= '<table>';
		$body .= '<tr><td colspan="7">';
		
		if ($datajsonT[0]->Type=="CN") {
			$type_show = "credit";
		}else{
			$type_show = "debit";
		}
		
		$body .= 'We have a <font color="red">';
		$body .= $type_show;
		$body .= '</font>';
		$body .= ' of your account as follow';
		$body .= '</td></tr>';

		$body .= '<tr class="tr">';
		$body .= '<td colspan="3" align="center" class="td"><b>Description</b></td>';
		$body .= '<td colspan="2" align="center" class="td"><b>Currency</b></td>';
		$body .= '<td colspan="2" align="center" class="td"><b>Amount</b></td>';
		$body .= '</tr>';
			
		$body .= '<tr class="tr">';	
		$body .= '<td colspan="3" class="td"><b>'.$datajsonT[0]->subjname.'</b></td>';

		if ($datajsonT[0]->CheckLine==1) {
			$body .= '<td colspan="2" align="center" class="td"></td>';
			$body .= '<td colspan="2" align="center" class="td"></td>';
		}else{
			$body .= '<td colspan="2" align="center" class="td">'.$datajsonT[0]->CurrencyName.'</td>';
			$body .= '<td colspan="2" align="center" class="td">'.number_format($datajsonT[0]->Total, 2, '.', ',').'</td>';
		}

		if (isset($datajsonT[0]->Remark)) {
			$body .= '<tr>';
			$body .= '<td colspan="3" class="td">'.str_replace("\n", "<br>\n", $datajsonT[0]->Remark).'</td>';
			$body .= '<td colspan="2" class="td"></td>';
			$body .= '<td colspan="2" class="td"></td>';
			$body .= '</tr>';
		}
		
	  	$body .= '</tr>';

		if ($datajsonT[0]->CheckLine==1) {

			foreach ($datajsonL as $kl => $vl) {
				$body .= '<tr>';
				$body .= '<td colspan="3" class="td">'.$vl->Description.'</td>';
  				$body .= '<td colspan="2" class="td" align="center">'.$vl->CurrencyName.'</td>';
  				$body .= '<td colspan="2" class="td" align="right">'.number_format($vl->Amount, 2, '.', ',').'</td>';
  				$body .= '</tr>';

  				if ($vl->RemarkDescription) {
  					$body .= '<tr>';
					$body .= '<td colspan="3" class="td">'.str_replace("\n", "<br>\n", $vl->RemarkDescription).'</td>';
	  				$body .= '<td colspan="2" class="td" align="center"></td>';
	  				$body .= '<td colspan="2" class="td" align="right"></td>';
	  				$body .= '</tr>';
  				}
			}

		}

		$obj  = new toWords($Total);
  		$txtTotal = $obj->words;

		$body .= '<tr>';
		$body .= '<td colspan="3" class="td"><b>GrandTotal : '.$txtTotal.'</b></td>';
		$body .= '<td colspan="2" class="td" align="center"><b>'.$datajsonT[0]->CurrencyName.'</b></td>';
		$body .= '<td colspan="2" class="td" align="right"><b>'.number_format($Total, 2, '.', ',').'</b></td>';
		$body .= '</tr>';

		$body .= '<tr><td colspan="7">Please notify us at once if there is any irregularity</td></tr>';
		$body .= '</table>';

		return $body;
	}

	function txtSignature(){
		$txtsignature = '
			<table>
				<tr>
					<td colspan="7" align="center">

					</td>
				</tr>
				<tr>
			        <td colspan="7" align="center" class="tds"><br><br>
			          Requested by………………………………………………………………………………<br>
			          ( Global Sales  )<br><br>
			          Date…………/…………/…………<br><br>
			        </td>
		      	</tr>
		      	<tr>
			        <td colspan="7" align="center" class="tds"><br><br>
			          Requested by………………………………………………………………………………<br>
			          ( Global Sales Administration Manager )<br><br>
			          Date…………/…………/…………<br><br>
			        </td>
		      	</tr>
		      	<tr>
			        <td colspan="7" align="center" class="tds"><br><br>
			          Acknowledged by………………………………………………………………………………<br>
			          ( Global Regional, Sales Manager )<br><br>
			          Date…………/…………/…………<br><br>
			        </td>
		      	</tr>
		      	<tr>
			        <td colspan="7" align="center" class="tds"><br><br>
			          Approved by ………………………………………………………………………………<br>
			          ( Chief Marketing Officer )<br><br>
			          Date…………/…………/…………<br><br>
			        </td>
		      	</tr>
		      	<tr>
			        <td colspan="7" align="center" class="tds"><br><br>
			          Approved by ………………………………………………………………………………<br>
			          ( Chief Executive Officer )<br><br>
			          Date…………/…………/…………<br><br>
			        </td>
		      	</tr>
			</table>';	
		return $txtsignature;
	}

	function txtPage($datajsonT){
		foreach ($datajsonT as $value) {
			$cb = $value->FullName;
		}
		$txtpage .= 
			'<table>
				<tr>
				    <td align="left">
				        <i>CreateBy : '.$cb.'</i>
				    </td>
				    <td align="right">
				        <i>page : {PAGENO}/{nb}</i>
				    </td>
				</tr>
			</table>';
		return $txtpage;
	}

	function checkAddpage($datajsonT,$datajsonL){
		if ($datajsonT[0]->CheckLine==0) {
			if (strlen($datajsonT[0]->Remark)>500) {
				return 'OUTPAGE';
			}else{
				return 'INPAGE';
			}
		}else{
			$rowLines = count($datajsonL);
			$countRemark = 0;
			foreach ($datajsonL as $kl => $vl) {
				if (strlen($vl->RemarkDescription)>0) {
					$countRemark += strlen($vl->RemarkDescription);
				}
			}

			if ($rowLines > 10) {
				return 'OUTPAGE';
			}else{
				if ($rowLines == 9 && $countRemark > 0) {
					return 'OUTPAGE';
				}
				if ($rowLines == 8 && $countRemark > 50) {
					return 'OUTPAGE';
				}
				if ($rowLines == 7 && $countRemark > 150) {
					return 'OUTPAGE';
				}
				if ($rowLines == 6 && $countRemark > 200) {
					return 'OUTPAGE';
				}
				if ($rowLines == 5 && $countRemark > 250) {
					return 'OUTPAGE';
				}
				if ($rowLines == 4 && $countRemark > 300) {
					return 'OUTPAGE';
				}
				if ($rowLines == 3 && $countRemark > 350) {
					return 'OUTPAGE';
				}
				if ($rowLines == 2 && $countRemark > 450) {
					return 'OUTPAGE';
				}
				if ($rowLines == 1 && $countRemark > 500) {
					return 'OUTPAGE';
				}
				return 'INPAGE';
			}

		}
	}

ini_set("pcre.backtrack_limit", "10000000");
$pdf = new mPDF('th','A4', 0, '', 5, 5, 85, 15);  
$pdf->SetDisplayMode('fullpage');
$pdf->AliasNbPages();

$html = ob_get_contents();
ob_end_clean();

$dataheader = txtHeader($new_date,$type_show,$comp,$DebitTransID,$CustomerGroup,$CustomerCodeID,$CustName,$Address);
$pdf->SetHTMLHeader($dataheader);

$pdf->WriteHTML(
	'<style type="text/css">
		table {
	    	border-collapse: collapse;
	    	width: 100%;
	    }

	    td, tr, th {
	        padding: 5.5px;
	        font-size: 12.5px;
	        font-family: "Cordia New";
	    }
	    .table, .tr, .td {
		    border: 1px solid black;
		    font-size: 12.5px;
		    font-family: "verdana";
		}
		.tdx, .trx, .thx {
	        padding: 5.5px;
	        font-size: 12.5px;
	        font-family: "verdana";
	    }
		.tables, .trs, .tds {
			padding: 5px;
		    font-size: 11.5px;
		    font-family: "verdana";
		}
		
	</style>'
);

$dataBody = txtBody($datajsonT,$datajsonL,$Total);
$pdf->WriteHTML($dataBody);

$datafooter = txtPage($datajsonT);

$pdf->SetHTMLFooter($datafooter);

$addpage = checkAddpage($datajsonT,$datajsonL);
if ($addpage=='OUTPAGE') {
	$pdf->Addpage();
}

$dataSignature = txtSignature($datajsonL,$datajsonT);
$pdf->WriteHTML($dataSignature);

$pdf->Output(); 