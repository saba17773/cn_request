
<!DOCTYPE html>
<html>
<head>
	<title>Report</title>
</head>
	<style type="text/css">
		table {
	    border-collapse: collapse;
	    width: 100%;
	    }

	    td, tr, th {
	        padding: 5.5px;
	        /*font-family: "Helvetica";*/
         /* font-family: "Cordia New";*/
	    }
	    .table, .tr, .td {
		    border: 1px solid black;
		}
	</style>

<body>
  <?php //class number to word
  	$sum = 0;
  	foreach ($datajsonT as $value) { 
  		$line=$value->CheckLine;
  		$total=$value->Total;
  		
  			foreach ($datajsonL as $value) {
  				$sum += $value->Amount;
  			}
  			$show_total = $sum;

  				if ($line==0) {
  					$show_total = $total;
  				}

  	}
  	$total_sub = substr($show_total, -2);
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

      	function toWords($amount, $major = MAJOR, $minor = MINOR)
      	{   
          $this->__toWords__((int)($amount), $major);
          $whole_number_part = $this->words;
          #$right_of_decimal = (int)(($amount-(int)$amount) * 100);
          $strform = number_format($amount,2);
          $right_of_decimal = (int)substr($strform, strpos($strform,'.')+1);
          $this->__toWords__($right_of_decimal, $minor);
          $this->words = $whole_number_part . ' ' . $this->words;
      	}

      	function __toWords__($amount, $major)
      	{
          $this->major  = $major;
          #$this->minor  = $minor;
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

      	function _build($n)
      	{
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
  ?>

  	<table width="100%">
	  	<tr>
	  		<td colspan="3">
	  			<?php foreach ($datajsonT as $value) { 
	  				$numaddress = $value->Address;
	  			} ?>
	  			<?php if (strlen($numaddress)>50) { ?>
	  			<?php }else{ ?>
	  			<?php } ?>
	  		</td>
	  	</tr>
  	</table>
  	
  	<table>
  	
  	<tr>
  		<td colspan="7">
  		<?php foreach ($datajsonT as $value) { 
  			if ($value->Type=="CN") {
  				$type_show = "credit";
  			}else{
  				$type_show = "debit";
  			}
  		} ?>
  			We have a <font color="red"><?php echo $type_show ?></font> of your account as follow
  		</td>
  	</tr>
  	
  	<tr class="tr">
  		<td colspan="3" class="td" align="center">
  			<b>Description</b>
  		</td>
  		<td colspan="2" class="td" align="center">
  			<b>Currency</b>
  		</td>
  		<td colspan="2" class="td" align="center">
  			<b>Amount</b>
  		</td>
  	</tr>
  	<!-- noline -->
  	<?php foreach ($datajsonT as $value) { 
  		$line=$value->CheckLine;
  		$total=$value->Total;
  		if ($line==0) {
  	?>
  	<tr class="tr">
  		<td colspan="3" class="td">
  		<b><?php echo $value->subjname;?></b>
  		</td>
  		<td colspan="2" class="td" align="center">
  			<?php echo $value->CurrencyName; ?>
  		</td>
  		<td colspan="2" class="td" align="right">
  			<?php echo number_format($value->Total, 2, '.', ','); ?>
  		</td>
  	</tr>
  	<?php if (isset($value->Remark)) { ?>
  	<tr class="tr">
  		<td colspan="3" class="td">
  			<?php $txtremarktrans= str_replace("\n", "<br>\n", "$value->Remark"); 
  					echo $txtremarktrans; ?>
  		</td>
  		<td colspan="2" class="td" align="center">
  			
  		</td>
  		<td colspan="2" class="td" align="right">

  		</td>
  	</tr>
  	<?php } ?>
  	} ?>
  	<?php } } ?>
  	<!-- haveline -->
  	<?php $i=1; $x=17;
          foreach ($datajsonL as $value) {  ?>
  		<?php 	
  				if ($value->subjectname!=$subject) {
  					  	$subject = ""; 
  					  	$subject = $value->subjectname; 
  			?>
  			<tr class="tr">
  				<td colspan="3" class="td">
  				<b><?php echo $value->subjectname;?></b>
  				</td>
  				<td colspan="2" class="td" align="center">

  				</td>
  				<td colspan="2" class="td" align="right">

  				</td>
  			</tr> 
  		<?php } ?>
  		<?php if ($value->RemarkDescription==null) { ?>
  			<tr class="tr">
  				<td colspan="3" class="td">
  					<?php echo $value->Description; ?>
  				</td>
  				<td colspan="2" class="td" align="center">
  					<?php echo $value->CurrencyName; ?>
  				</td>
  				<td colspan="2" class="td" align="right">
  					<?php echo number_format($value->Amount, 2, '.', ','); ?>
  				</td>
  			</tr>
      <?php if ($i==$x) { $x=($i+20);?>
        <tr>
          
        </tr>
      <?php } ?>
  		<?php }else{ ?>
  			<tr class="tr">
  				<td colspan="3" class="td">
  					<?php echo $value->Description; ?>
  				</td>
  				<td colspan="2" class="td" align="center">
  					<?php echo $value->CurrencyName; ?>
  				</td>
  				<td colspan="2" class="td" align="right">
  					<?php echo number_format($value->Amount, 2, '.', ','); ?>
  				</td>
  			</tr>
  			<tr class="tr">
  				<td colspan="3" class="td">
  					<?php $txtremark= str_replace("\n", "<br>\n", "$value->RemarkDescription"); 
  					echo $txtremark; ?>
  				</td>
  				<td colspan="2" class="td">
  					
  				</td>
  				<td colspan="2" class="td">
  				
  				</td>
  			</tr>
  		<?php } ?>
  	
  	<?php $i++;} ?>

  	<tr class="tr">
  		<td colspan="3" class="td">
  			<b>GrandTotal : 
  			<?php 
  				 $obj    = new toWords($show_total);
  				 echo $obj->words;
  			?> 
  			</b>
  		</td>
  		<td colspan="2" class="td" align="center"><b>
  			<?php foreach ($datajsonT as $value) {
  					echo $value->CurrencyName;
  				}
  			 ?></b>
  		</td>
  		<td colspan="2" class="td" align="right"><b>
  			<?php 
  				$sum = 0;
  				foreach ($datajsonL as $value) {
  					$sum += $value->Amount;
  				}
  				if ($line==0) {
  					echo number_format($total, 2, '.', ',');
  				}else{
  					echo number_format($sum, 2, '.', ',');
  				}
  					
  			?></b>
  		</td>
  	</tr>
  		
  	<tr>
  		<td colspan="7">
  			Please notify us at once if there is any irregularity
  		</td>
  	</tr>
  	
  	</table>

</body>

</html>

<?php  
// ini_set('memory_limit','4096M');
ini_set("pcre.backtrack_limit", "10000000");
$pdf = new mPDF('th','A4', 0, '', 8, 8, 115, 15);  
$pdf->SetDisplayMode('fullpage');
$pdf->AliasNbPages();


function txtHeader($new_date,$type_show,$comp,$DebitTransID,$CustomerGroup,$CustomerCodeID,$CustName,$Address){
	$credit = '<table width="100%">
		<tr>
      <td colspan="3">
      <a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;height:150px;" /></a>
      </td>
    </tr>
		<tr>
			<td align="left" width="20%">
			</td>
			<td colspan="3" align="center">
				<h1><b>
				<p><font face="verdana">
				Request for
				<font color="red">'.$type_show.'</font> Note
				</font></p>
				</b></h1>
			</td>
			<td align="right" width="20%">
				<i>Date : '.$new_date.'</i>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				Plant : '.$comp.'
			</td>
		</tr>
		<tr>
			<td colspan="3">
				Type :  '.$type_show.'
			</td>
		</tr>
		<tr>
			<td colspan="3">
				Request No :  '.$DebitTransID.'
			</td>
		</tr>
		<tr>
			<td colspan="5">
				Customer Group : '.$CustomerGroup.'
			</td>
		</tr>
		<tr class="tr">
			<td colspan="7">
				CustCode : '.$CustomerCodeID.'<br>
				Customer Name : '.$CustName.'<br>
				Customer Address :  '.$Address.'
			</td>
		</tr>
		</table>';
	return $credit;
}

function txtPage($datajsonT){
	foreach ($datajsonT as $value) {
		$cb = $value->FullName;
	}
	$txtpage = '<table>
			<tr>
			    <td align="left">
			        <font size="3"><i>CreateBy : '.$cb.'</i></font>
			    </td>
			    <td align="right">
			        <font size="3"><i>page : {PAGENO}/{nb}</i></font>
			    </td>
			</tr>
			</table>';
	return $txtpage;
}

function txtPages($datajsonL,$datajsonT){
	foreach ($datajsonL as $value) {
		$remarkdes = $value->RemarkDescription;
	}
	foreach ($datajsonT as $value) {
	    $remarktrans = $value->Remark;
	}
	
	$numpage = count($datajsonL);
	$remarklen = strlen($remarkdes);
  	$remarklen_t = strlen($remarktrans);
	$txtsignature = '<table>
		<tr>
			<td colspan="7" align="center">

			</td>
		</tr>
		<tr>
	        <td colspan="7" align="center"><br><br>
	          Requested by………………………………………………………………………………<br>
	          ( Global Sales  )<br><br>
	          Date…………/…………/…………<br><br>
	        </td>
      	</tr>
      	<tr>
	        <td colspan="7" align="center"><br><br>
	          Requested by………………………………………………………………………………<br>
	          ( Global Sales Administration Manager )<br><br>
	          Date…………/…………/…………<br><br>
	        </td>
      	</tr>
      	<tr>
	        <td colspan="7" align="center"><br><br>
	          Acknowledged by………………………………………………………………………………<br>
	          ( Global Regional, Sales Manager )<br><br>
	          Date…………/…………/…………<br><br>
	        </td>
      	</tr>
      	<tr>
	        <td colspan="7" align="center"><br><br>
	          Approved by ………………………………………………………………………………<br><br>
	          ( Chief Executive Officer )<br>
	          Date…………/…………/…………<br><br>
	        </td>
      	</tr>
		</table>';	
	return $txtsignature;
	//}
}

$html = ob_get_contents();
ob_end_clean();

$dataheader = txtHeader($new_date,$type_show,$comp,$DebitTransID,$CustomerGroup,$CustomerCodeID,$CustName,$Address);
$pdf->SetHTMLHeader($dataheader);

$datafooter = txtPage($datajsonT);
$pdf->SetHTMLFooter($datafooter);

$pdf->WriteHTML($html);

$pdf->Addpage();
$dataSignature = txtPages($datajsonL,$datajsonT);
$pdf->WriteHTML($dataSignature);

$pdf->Output(); 