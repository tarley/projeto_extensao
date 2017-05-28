<?php
    include 'Config.php';
    include 'JsonUtils.php';
    include 'LogUtils.php';
    
    session_start();
    
    if(!$ignorarSeguranca && empty($_SESSION['usuario'])) {
        respostaJsonErro('Usuário não autenticado.');
    }
    
    if(!$ignorarConexao) {
        R::setup('mysql:host=' . HOST . ';dbname=' . DBNAME, USERNAME, PASSWORD);
    }
?>