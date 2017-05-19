<?php
    try {
        require_once '../Utils/Init.php';
        
        respostaJsonErro("Metodo não implementado");
        
        if(!isset($_GET['titulo'])) {
            respostaJsonErro('Titulo não informado.');
        }
        
        $titulo = $_GET['titulo'];

        $situacao = R::findone('situacao', 'id = :id', [':id' => 1]);
        $tipo_acao = R::findone('tipo_acao', 'id = :id', [':id' => 1]);
        $curso = R::findone('curso', 'id = :id', [':id' => 1]);
        
        
        $acao = R::dispense('acao');
        $acao->titulo = $titulo;
        $acao->situacao = $situacao;
        $acao->tipo_acao = $tipo_acao;
        $acao->curso = $curso;
    
        $id = R::store($acao);

        respostaJsonSucesso('Ação cadastrada com sucesso!');
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>