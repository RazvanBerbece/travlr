define('DB_SERVER', 'sql200.epizy.com');
define('DB_USERNAME', 'epiz_25116592');
define('DB_PASSWORD', 'nHy8I5FndL9D1w');
define('DB_DATABASE', 'epiz_25116592_travlr');

$connection = mysql_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD) or die(mysql_error());
$database = mysql_select_db(DB_DATABASE) or die(mysql_error());
