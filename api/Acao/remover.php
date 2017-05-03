<?php
    try {
        require_once '../Utils/Init.php';
        
        respostaJsonErro("Metodo não implementado");
        
        R::wipe('acao');

        respostaJsonSucesso('Exclusao realizada com sucesso!');
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>