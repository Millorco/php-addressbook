<?php
//no space before <?
  include"login_config.php";
  require_once __DIR__ . DIRECTORY_SEPARATOR . ".." . DIRECTORY_SEPARATOR . "include" . DIRECTORY_SEPARATOR . "mysqli.database.php";

   if(!isset($db_access)) {
     $db_access = new MysqliDatabase();
   }

   // connect to the server
   $db_link = $db_access->connect( $db_host, $db_username, $db_password )
      or die( "Error! Could not connect to database: " . $db_access->error() );

   // Share the connection with the legacy mysql_* calls (mysql_shim.php)
   $GLOBALS['mysql_mysqli_link'] = $db_link;

   // select the database
   $db_access->selectDb( $db )
      or die( "Error! Could not select the database: " . $db_access->error() );

   $db_access->setCharset("utf8mb4");

?>
