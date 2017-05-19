<?php

require_once "../_comum/DBService.php";

$dados = R::find('curso','ativo=:status',['status' =>1]);

$cursos = [ 
    "cursos" => R::exportAll($dados)];

echo json_encode($cursos);



?>