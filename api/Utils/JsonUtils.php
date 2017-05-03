<?php
    include 'rb.php';
    
    function setHeader() {
        header("Access-Control-Allow-Origin: *");
        header('Content-Type: application/json; charset=UTF-8');
    }

    function respostaJson($dados) {
        setHeader();
        
        $retorno = ['sucesso' => true, 'conteudo' => R::exportAll($dados)];
        echo json_encode($retorno);
        
        exit;
    }

    function respostaJsonSucesso($msg) {
        setHeader();
        
        $retorno = ['sucesso' => true, 'mensagem' => $msg];
        echo json_encode($retorno);
        
        exit;
    }

    function respostaJsonErro($msg) {
        setHeader();
        
        $retorno = ['sucesso' => false, 'mensagem' => $msg];
        echo json_encode($retorno);
        
        exit;
    }
?>