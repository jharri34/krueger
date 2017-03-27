<?php

ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(-1);
$total = count($_FILES[sample][name]);
for ($i=0; $i<$total; $i++){
  $tempfile = $_FILES['userfile']['tmp_name'][$i]
  $fullpath = '/home/kruegerdata'.$_FILES['userfile']['name'][$i]
  move_uploaded_file($tempfile,$fullpath)
}
$sample = $_POST['sample'];
$attachment = $_POST['attachment'];
$state = $_POST['state'];
$ploidy = $_POST['ploidy'];
#$tempfile = $_FILES['userfile']['tmp_name'];
#$fullpath = '/home/kruegerdata/'.$_FILES['userfile']['name'];
print_r("$sample \n $attachment \n $state \n $ploidy \n");
print_r("$tempfile \n");
print_r("$fullpath \n");
#move_uploaded_file($tempfile,$fullpath);

?>
