<?php

?>

<!DOCTYPE html>
<html>

<body>

    <h2>HTML Forms</h2>

    <form action="processors/whatsapp_api_processor.php">
        <label for="fname">App Id:</label><br>
        <input type="text" id="app_id" name="app_id" value="John"><br>
        <label for="lname">App Secret:</label><br>
        <input type="text" id="app_secret" name="app_secret" value="Doe"><br><br>
        <input type="submit" value="Submit">
    </form>

    <p>If you click the "Submit" button, the form-data will be sent to a page called "/action_page.php".</p>

</body>

</html>