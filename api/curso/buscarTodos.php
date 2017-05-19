<?php
require_once "../_comum/DBService.php";

$dados = R::find('curso');

$cursos = [ 
    "cursos" => R::exportAll($dados)];

echo json_encode($cursos);

?>