#!/bin/bash
echo "Content-type: text/html"
echo ""
cat <<EOT
<!DOCTYPE html>
<html>
<head>
        <title>kruger upload</title>
</head>
<body>
        <p>Hello! Please enter your name and e-mail address and press the submit button</p>
        <form action="submit.sh" method="get">
                <label>Name</label>
                <input type="text" name="name">
                <br>
                <label>E-mail</label>
                <input type="text" name="email">
                <br>
                <button type="submit">Submit</button>
        </form>
</body>
</html>
<form action="/cgi-bin/echo.cgi" method="post" enctype="multipart/form-data">
    <label for="file">Filename:</label>
    <input type="file" name="file" id="file"><br>
    <input type="submit" name="submit" value="Submit">
</form>
EOT
# POST=$(</dev/stdin)
# echo "$POST" > /tmp/a
