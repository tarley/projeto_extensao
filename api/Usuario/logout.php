<?php
    try {
        $ignorarSeguranca = true;
        $ignorarConexao = true;
        
        require_once '../Utils/Init.php';
        
        session_unset();
        
        respostaJsonSucesso('Logout concluido com sucesso!');
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>