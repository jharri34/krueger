<?php

ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(-1);
echo '<pre>'.print_r($_FILES).'</pre>';
// $total = count($_FILES[sample][name]);
// for ($i=0; $i<$total; $i++){
//   $tempfile = $_FILES['userfile']['tmp_name'][$i]
//   $fullpath = '/home/kruegerdata/'.$_FILES['userfile']['name'][$i]
//   print_r("tempfile=".$tempfile);
//   print_r("fullpath=".$fullpath);
//   move_uploaded_file($tempfile,$fullpath);
// }
foreach($_FILES['files']['name'] as $positon => $filename){
  $tempfile = $_FILES['files']['tmp_name']['$positon'];
  $file_size = $_FILES['files']['size']['$positon'];
  $file_error = $_FILES['files']['error']['$positon'];
  $location = '/home/kruegerdata/'.$_FILES['userfile']['name'];
  if(move_uploaded_file($tempfile,$location){
    print_r($location);
    print_r($file_size);
  } else {
    print_r($file_error);
  }
}
$sample = $_POST['sample'];
$attachment = $_POST['attachment'];
$state = $_POST['state'];
$ploidy = $_POST['ploidy'];
#$tempfile = $_FILES['userfile']['tmp_name'];
#$fullpath = '/home/kruegerdata/'.$_FILES['userfile']['name'];
#move_uploaded_file($tempfile,$fullpath);

?>
