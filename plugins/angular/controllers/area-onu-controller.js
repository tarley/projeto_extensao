angular.module('cadastraProjeto').controller('AreaOnu', function ($scope, $http) {
    
    $http.get('api/ConceitoExtensao/buscarAtivos.php?idTipoConceito=2').then(function(response) {
            if(response.data.sucesso) {
                $scope.onu = response.data.conteudo;
            } else {
                alert(response.data.mensagem)
            }
       }, function(response) {
           alert("Erro: " + response.statusText);
       });

});