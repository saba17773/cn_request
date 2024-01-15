<?php 
  ob_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<style type="text/css">
	table {
    border-collapse: collapse;
    width: 100%;
    }

    td, tr, th {
        padding: 5.5px;
        font-family: "Helvetica";
    }
    .table, .tr, .td {
	    border: 1px solid black;
	}
	

</style>
</head>
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
  			<!-- <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> -->
  			<?php }else{ ?>
  			<!-- <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> -->
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
          <!-- <td>
            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
          </td> -->
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


function convert_number_to_words($number) {

    $hyphen      = '-';
    $conjunction = ' and ';
    $separator   = ' ';
    $negative    = 'negative ';
    $decimal     = ' point ';
    $dictionary  = array(
        0                   => 'zero',
        1                   => 'one',
        2                   => 'two',
        3                   => 'three',
        4                   => 'four',
        5                   => 'five',
        6                   => 'six',
        7                   => 'seven',
        8                   => 'eight',
        9                   => 'nine',
        10                  => 'ten',
        11                  => 'eleven',
        12                  => 'twelve',
        13                  => 'thirteen',
        14                  => 'fourteen',
        15                  => 'fifteen',
        16                  => 'sixteen',
        17                  => 'seventeen',
        18                  => 'eighteen',
        19                  => 'nineteen',
        20                  => 'twenty',
        30                  => 'thirty',
        40                  => 'fourty',
        50                  => 'fifty',
        60                  => 'sixty',
        70                  => 'seventy',
        80                  => 'eighty',
        90                  => 'ninety',
        100                 => 'hundred',
        1000                => 'thousand',
        1000000             => 'million',
        1000000000          => 'billion',
        1000000000000       => 'trillion',
        1000000000000000    => 'quadrillion',
        1000000000000000000 => 'quintillion'
    );

    if (!is_numeric($number)) {
        return false;
    }

    if (($number >= 0 && (int) $number < 0) || (int) $number < 0 - PHP_INT_MAX) {
        // overflow
        trigger_error(
            'convert_number_to_words only accepts numbers between -' . PHP_INT_MAX . ' and ' . PHP_INT_MAX,
            E_USER_WARNING
        );
        return false;
    }

    if ($number < 0) {
        return $negative . convert_number_to_words(abs($number));
    }

    $string = $fraction = null;

    if (strpos($number, '.') !== false) {
        list($number, $fraction) = explode('.', $number);
    }

    switch (true) {
        case $number < 21:
            $string = $dictionary[$number];
            break;
        case $number < 100:
            $tens   = ((int) ($number / 10)) * 10;
            $units  = $number % 10;
            $string = $dictionary[$tens];
            if ($units) {
                $string .= $hyphen . $dictionary[$units];
            }
            break;
        case $number < 1000:
            $hundreds  = $number / 100;
            $remainder = $number % 100;
            $string = $dictionary[$hundreds] . ' ' . $dictionary[100];
            if ($remainder) {
                $string .= $conjunction . convert_number_to_words($remainder);
            }
            break;
        default:
            $baseUnit = pow(1000, floor(log($number, 1000)));
            $numBaseUnits = (int) ($number / $baseUnit);
            $remainder = $number % $baseUnit;
            $string = convert_number_to_words($numBaseUnits) . ' ' . $dictionary[$baseUnit];
            if ($remainder) {
                $string .= $remainder < 100 ? $conjunction : $separator;
                $string .= convert_number_to_words($remainder);
            }
            break;
    }

    if (null !== $fraction && is_numeric($fraction)) {
        $string .= $decimal;
        $words = array();
        foreach (str_split((string) $fraction) as $number) {
            $words[] = $dictionary[$number];
        }
        $string .= implode(' ', $words);
    }

    return $string;
}

function numtowords($num){ 
  $decones = array( 
              '01' => "Zero One", 
              '02' => "Zero Two", 
              '03' => "Zero Three", 
              '04' => "Zero Four", 
              '05' => "Zero Five", 
              '06' => "Zero Six", 
              '07' => "Zero Seven", 
              '08' => "Zero Eight", 
              '09' => "Zero Nine", 
              10 => "Ten", 
              11 => "Eleven", 
              12 => "Twelve", 
              13 => "Thirteen", 
              14 => "Fourteen", 
              15 => "Fifteen", 
              16 => "Sixteen", 
              17 => "Seventeen", 
              18 => "Eighteen", 
              19 => "Nineteen" 
              );
  $ones = array( 
              0 => " ",
              1 => "One",     
              2 => "Two", 
              3 => "Three", 
              4 => "Four", 
              5 => "Five", 
              6 => "Six", 
              7 => "Seven", 
              8 => "Eight", 
              9 => "Nine", 
              10 => "Ten", 
              11 => "Eleven", 
              12 => "Twelve", 
              13 => "Thirteen", 
              14 => "Fourteen", 
              15 => "Fifteen", 
              16 => "Sixteen", 
              17 => "Seventeen", 
              18 => "Eighteen", 
              19 => "Nineteen" 
              ); 
  $tens = array( 
              0 => "",
              2 => "Twenty", 
              3 => "Thirty", 
              4 => "Forty", 
              5 => "Fifty", 
              6 => "Sixty", 
              7 => "Seventy", 
              8 => "Eighty", 
              9 => "Ninety" 
              ); 
  $hundreds = array( 
              "Hundred", 
              "Thousand", 
              "Million", 
              "Billion", 
              "Trillion", 
              "Quadrillion" 
              ); //limit t quadrillion 
  $num = number_format($num,2,".",","); 
  $num_arr = explode(".",$num); 
  $wholenum = $num_arr[0]; 
  $decnum = $num_arr[1]; 
  $whole_arr = array_reverse(explode(",",$wholenum)); 
  krsort($whole_arr); 
  $rettxt = ""; 
  foreach($whole_arr as $key => $i){ 
      if($i < 20){ 
          $rettxt .= $ones[$i]; 
      }
      elseif($i < 100){ 
          $rettxt .= $tens[substr($i,0,1)]; 
          $rettxt .= " ".$ones[substr($i,1,1)]; 
      }
      elseif($i >= 110 && $i <= 119 ){ 
            $rettxt .= $ones[substr($i,0,1)]." ".$hundreds[0];
            $rettxt .= " ".$ones[substr($i,1,2)]; 
      }
      else{ 
  //     	$txt = $i;
		// $str_txt = substr($txt, -5,2);
  //     	if($str_txt >= 10 && $str_txt <= 19){
  //     	  $rettxt .= $ones[substr($i,0,1)]." ".$hundreds[0]; 
  //         $rettxt .= " ".$ones[substr($i,1,2)]; 
  //         $rettxt .= " ".$ones[substr($i,2,1)]; 
  //     	}else{
          $rettxt .= $ones[substr($i,0,1)]." ".$hundreds[0]; 
          $rettxt .= " ".$tens[substr($i,1,1)]; 
          $rettxt .= " ".$ones[substr($i,1,2)]; 
        //}
      } 
      if($key > 0){ 
          $rettxt .= " ".$hundreds[$key]." "; 
      } 

  } 
  //$rettxt = $rettxt." peso/s";

  if($decnum > 0){ 
      $rettxt .= " point "; 
      if($decnum < 20){ 
          $rettxt .= $decones[$decnum]; 
      }
      elseif($decnum < 100){ 
          $rettxt .= $tens[substr($decnum,0,1)]; 
          $rettxt .= " ".$ones[substr($decnum,1,1)]; 
      }
      //$rettxt = $rettxt." centavo/s"; 
  } 
  return $rettxt;
}

function txtHeader($datajsonT){
	foreach ($datajsonT as $value) {
		$comp = $value->CompanyID;

		if($value->Type=="CN"){
			$type_show="Credit";
		}else{
			$type_show="Debit";
		}
		$old_date_timestamp = strtotime($value->CreateDateTime);
		$new_date = date('d/m/Y',$old_date_timestamp);

	}

	$credit = '<table width="100%">
		<tr>
			<td colspan="3">
			<a class="navbar-brand"><img  src="./assets/_images/logonew/'.$comp.'.jpg" style="padding-left:-10;height:150px; width:auto;" /></a>
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
				Plant : '.$value->CompanyID.'
			</td>
		</tr>
		<tr>
			<td colspan="3">
				Type :  '.$type_show.'
			</td>
		</tr>
		<tr>
			<td colspan="3">
				Request No :  '.$value->DebitTransID.'
			</td>
		</tr>
		<tr>
			<td colspan="5">
				Customer Group : '.$value->CustomerGroup.'
			</td>
		</tr>
		<tr class="tr">
			<td colspan="7">
				CustCode : '.$value->CustomerCodeID.'<br>
				Customer Name : '.$value->CustName.'<br>
				Customer Address :  '.$value->Address.'
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
	// if ($numpage>=2 || $remarklen>=1 || $remarklen_t>120) {
	// $txtsignature = '<table>
	// 		<tr>
	// 			<td colspan="7" align="center">
	// 			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	// 			</td>
	// 		</tr>
 //      <tr>
 //        <td colspan="7" align="center"><br><br>
 //          Requested by………………………………………………………………………………<br>
 //          ( Sales Administration )<br><br>
 //          Date…………/…………/…………<br><br>
 //        </td>
 //      </tr>
	// 		<tr>
	// 			<td colspan="7" align="center"><br><br>
	// 				Requested by………………………………………………………………………………<br>
	// 				( Regional, Sales Manager )<br><br>
	// 				Date…………/…………/…………<br><br>
	// 			</td>
	// 		</tr>
	// 		<tr>
	// 			<td colspan="7" align="center"><br><br>
	// 				Acknowledged by………………………………………………………………………………<br>
	// 				( Global, Sales Manager )<br><br>
	// 				Date…………/…………/…………<br><br>
	// 			</td>
	// 		</tr>
	// 		<tr>
	// 			<td colspan="7" align="center"><br><br>
	// 				Approved by ………………………………………………………………………………<br><br>
	// 				( Director, Global Business )<br>
	// 				Date…………/…………/…………<br><br>
	// 			</td>
	// 		</tr>
	// 	</table>';	
	//return $txtsignature;
	// }else{
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

// include("../assets/mpdf60/mpdf.php");
$html = ob_get_contents();
ob_end_clean();
$pdf = new mPDF('th','A4', 0, '', 8, 8, 115, 15);  
// $pdf = new mPDF('th','A4', 0, '', 8, 8, 35, 25);  
$pdf->SetDisplayMode('fullpage');

$dataheader = txtHeader($datajsonT);
$pdf->SetHTMLHeader($dataheader);

$datafooter = txtPage($datajsonT);
$pdf->SetHTMLFooter($datafooter);

$pdf->WriteHTML($txtpage);
$pdf->WriteHTML($html);

$pdf->Addpage();
$dataSignature = txtPages($datajsonL,$datajsonT);
$pdf->WriteHTML($dataSignature);
$pdf->Output(); 
?>