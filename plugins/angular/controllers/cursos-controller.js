angular.module('cadastraProjeto').controller('ListaCursos', function ($scope, $http) {
    
    $http.get('api/curso/buscarAtivos.php').then(function(response) {
            if(response.data.sucesso) {
                $scope.cursos = response.data.conteudo;
            } else {
                alert(response.data.mensagem)
            }
       }, function(response) {
           alert("Erro: " + response.statusText);
       });

});