<?php

    function validarDadosAcao() {
        if(empty($_POST['tipoAcao']))
            respostaJsonErro('Tipo ação não informado.');
        
        if(empty($_POST['titulo']))
            respostaJsonErro('Titulo não informado.');
        
        if(empty($_POST['descricao']))
            respostaJsonErro('Descrição não informada.');
            
        if(empty($_POST['objetivo']))
            respostaJsonErro('Objetivo não informado.');
            
        if(empty($_POST['publicoAlvo']))
            respostaJsonErro('Publico-alvo não informado.');
        
        if(empty($_POST['local']))
            respostaJsonErro('Local não informado.');
            
        if(empty($_POST['dataInicio']))
            respostaJsonErro('Data de inicio não informada.');    
        
        if(empty($_POST['tipoAcao']))
            respostaJsonErro('Tipo da ação não informado.');
            
        if(empty($_POST['cursoResponsavel']))
            respostaJsonErro('Curso responsavel não informado.');
    }

    try {
        require_once '../Utils/Init.php';
        
        $_POST = json_decode(file_get_contents('php://input'), true);
        logInfo($_POST);
        
        validarDadosAcao();
        
        $acao = R::dispense('acao');
        $acao->titulo = $_POST['titulo'];
        $acao->descricao = $_POST['descricao'];
        $acao->objetivo = $_POST['objetivo'];
        $acao->publico_alvo = $_POST['publicoAlvo'];
        $acao->local = $_POST['local'];
        $acao->dt_inicio = $_POST['dataInicio'];
        $acao->dt_termino = $_POST['dataTermino'];
        $acao->dt_registro = new DateTime('NOW'); // Data de registro é agora
        $acao->tipo_acao = R::findone('tipo_acao', 'id = :id', [':id' => $_POST['tipoAcao']]);
        $acao->situacao = R::findone('situacao', 'id = :id', [':id' => 1]); // Situação pendênte 
        $acao->curso = R::findone('curso', 'id = :id', [':id' => $_POST['cursoResponsavel']]);
        $acao->professor = R::findone('usuario', 'id = :id', [':id' => 3]); // Cadastrado pelo professor Tarley
        
        $id = R::store($acao);

        respostaJsonSucesso('Ação cadastrada com sucesso!');
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>