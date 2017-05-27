<?php
    try {
        require_once '../Utils/Init.php';
        
        $_POST = json_decode(file_get_contents('php://input'), true);
        logInfo($_POST);
        
        if(empty($_POST['username']) || (empty($_POST['password']))){ 
            respostaJsonErro('Usuário ou senha  não informados');
        }
      
        $usuario = R::findOne('usuario', 'email = :email AND senha = :password', 
                 [':email' => $_POST['username'], ':password' => SHA1($_POST['password'])]);
        
        if(empty($usuario)){
            respostaJsonErro('Usuário ou senha inválido.'); 
        }
        
        $_SESSION['usuario'] = $usuario;
        respostaJson($usuario);

    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>