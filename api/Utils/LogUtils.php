<?php
    function logInfo($data) {
        $req_dump = print_r($data, TRUE);
        $fp = fopen('php_info.log', 'a');
        fwrite($fp, $req_dump);
        fclose($fp);
    }
?>