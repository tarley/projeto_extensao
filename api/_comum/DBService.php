<?php

include 'config.php';
include 'rb.php';

header("Access-Control-Allow-Origin: *");
header("Content-type: application/json; charset=utf-8");

R::setup('mysql:host=' . HOST . ';dbname=' . DBNAME,USERNAME,PASSWORD);

?>