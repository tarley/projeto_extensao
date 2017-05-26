<?php
    try {
        require_once '../Utils/Init.php';
        
        if(empty($_SESSION['usuario']))
            respostaJsonErro('Usuário não autenticado.');  
        else
            respostaJson($_SESSION['usuario']);
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>