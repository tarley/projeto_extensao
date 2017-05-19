<?php
    try {
        require_once '../Utils/Init.php';
        
        if(empty($_GET['id']))
            respostaJsonErro('Identificador da situação não informado.');
        
        $dados = R::findOne('situacao', 'id = :id', [':id' => $_GET['id']]);
        
        respostaJson($dados);
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>