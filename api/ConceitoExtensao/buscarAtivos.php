<?php
    try {
        require_once '../Utils/Init.php';
        
        if(empty($_GET['idTipoConceito'])) {
            respostaJsonErro('Parametro GET idTipoConceito não informado.');
        }
        
        $idTipoConceito = $_GET['idTipoConceito'];
        
        $tipoConceito = R::find('tipo_conceito', 'id= ?', [$idTipoConceito]);
        
        $dados = R::find('conceito', 
            'ativo = ? AND tipo_conceito_id = ?', [1, $_GET['idTipoConceito']]);
        
        foreach($dados as $areaTematica) {
            unset($areaTematica['tipo_conceito_id']);
            $areaTematica['tipo_conceito'] = $tipoConceito;
        }
        
        respostaJson($dados);
    } catch(Exception $e) {
        respostaJsonErro($e->getMessage());
    }
?>