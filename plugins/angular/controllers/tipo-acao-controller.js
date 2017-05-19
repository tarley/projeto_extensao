angular.module('cadastraProjeto').controller('TipoAcao', function ($scope, $http) {
    
    $http.get('api/TipoAcao/buscarTodos.php').then(function(response) {
            if(response.data.sucesso) {
                $scope.tiposAcao = response.data.conteudo;
            } else {
                alert(response.data.mensagem)
            }
       }, function(response) {
           alert("Erro: " + response.statusText);
       });

});
