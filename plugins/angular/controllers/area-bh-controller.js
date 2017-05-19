angular.module('cadastraProjeto').controller('AreaBh', function ($scope, $http) {
    
    $http.get('api/ConceitoExtensao/buscarAtivos.php?idTipoConceito=3').then(function(response) {
            if(response.data.sucesso) {
                $scope.bh = response.data.conteudo;
            } else {
                alert(response.data.mensagem)
            }
       }, function(response) {
           alert("Erro: " + response.statusText);
       });

});