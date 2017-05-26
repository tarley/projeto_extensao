<?php
    try {
        require_once '../Utils/Init.php';
        
        if(empty($_POST['username']))
            respostaJsonErro('Usuário não informado');
            
        if(empty($_POST['password']))
            respostaJsonErro('Senha não informada.');    
        
        
        //$dados = R::find('usuario', '', [$_POST['username']]);
        
        if(1==1)
            respostaJsonErro('Usuário ou senha inválido.');  
        
        respostaJsonSucesso('Autenticação realizada com sucesso!');
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>