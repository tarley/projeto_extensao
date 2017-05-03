<?php
    include 'Config.php';
    include 'JsonUtils.php';
    
    R::setup('mysql:host=' . HOST . ';dbname=' . DBNAME, USERNAME, PASSWORD);
?>