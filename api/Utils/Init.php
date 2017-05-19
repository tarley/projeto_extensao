<?php
    include 'Config.php';
    include 'JsonUtils.php';
    include 'LogUtils.php';
    
    R::setup('mysql:host=' . HOST . ';dbname=' . DBNAME, USERNAME, PASSWORD);
?>