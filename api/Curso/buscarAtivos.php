<?php
    try {
        require_once '../Utils/Init.php';
        
        $dados = R::find('curso', 'ativo = ?', [1]);

        respostaJson($dados);
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>