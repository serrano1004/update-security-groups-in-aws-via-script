# update-security-groups-in-aws-via-script

En mi caso, necesité el script para actualizar las ips del servicio de envío de correos.
Uno de los problemas que nos encontramos con AWS y el equipo de seguridad (de la empresa donde trabajo) es que no podemos tener abierto el puerto 587 a todo el mundo (0.0.0.0/0). Para ello, tenemos que saber que IPs usan los del servicio de envío de mails (que tambien es de AWS) y añadirlas al SG de la instancia. 
 
El segundo problema es que esas IPs van cambiando cada X. 
 
Lo que hacemos es montar un CRON para que ejecute un script al día. El script elimina del SG las IPs antiguas y añade las IPs nuevas. 
 
