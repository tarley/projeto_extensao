<?php
    try {
        require_once '../Utils/Init.php';
        
        $dados = R::find('tipo_acao');
        
        respostaJson($dados);
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>