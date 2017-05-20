<?php
    try {
        require_once '../Utils/Init.php';
        
        if(empty($_GET['nome'])) {
            respostaJsonErro('Parametro GET nome não informado.');
        }
        
        $nome = $_GET['nome'];
        
        $dados = R::find('curso', 'ativo = ? AND nome LIKE ?', [1, "%$nome%"]);
        
        respostaJson($dados);
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>