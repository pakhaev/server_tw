<?php
$cfg['blowfish_secret'] = 'abcdefghijklmnopqrstuvwxyz0123456789'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

$i = 0;

$i++;
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
?>

