angular.module('cadastraProjeto').controller('AreaTematica', function ($scope, $http) {
    
    $http.get('api/ConceitoExtensao/buscarAtivos.php?idTipoConceito=1').then(function(response) {
            if(response.data.sucesso) {
                $scope.area = response.data.conteudo;
            } else {
                alert(response.data.mensagem)
            }
       }, function(response) {
           alert("Erro: " + response.statusText);
       });

});