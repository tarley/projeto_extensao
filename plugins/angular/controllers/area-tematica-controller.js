angular.module('cadastraProjeto').controller('AreaTematica', function ($scope, $http) {
    
    $http.get('api/ConceitoExtensao/buscarAtivos.php?tipo_conceito_id=1').then(function(response) {
            if(response.data.sucesso) {
                $scope.area = response.data.conteudo;
            } else {
                alert(response.data.mensagem)
            }
       }, function(response) {
           alert("Erro: " + response.statusText);
       });

});