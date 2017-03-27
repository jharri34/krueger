<html>
 <head>
  <title>Krueger Upload</title>
 </head>
	 <body>
		<form action="upload.php" method="post" enctype="multipart/form-data">
			Sample:<input type="text" name="sample" />
			Attachment:<input type="text" name="attachment" />
			State:<input type="text" name="state" />
			Ploidy:<input type="text" name="ploidy" />
			 File: <input name="userfile" type="file" />
    			<input type="submit" value="Send File" />
		</form> 
	 </body>
</html>
