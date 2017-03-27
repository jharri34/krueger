<?php

ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(-1);
$sample = $_POST['sample'];
$attachment = $_POST['attachment'];
$state = $_POST['state'];
$ploidy = $_POST['ploidy'];
$fullpath = '/home/kruegerdata/'.$_FILES['userfile']['name'];
$tempfile = $_FILES['userfile']['tmp_name'];
print_r("$sample \n $attachment \n $state \n $ploidy \n");
print_r("$tempfile \n");
print_r("$fullpath \n");
move_uploaded_file($tempfile,$fullpath);

?>
