# update-security-groups-in-aws-via-script

ESPAÑOL

En mi caso, necesité el script para actualizar las ips del servicio de envío de correos.
Uno de los problemas que nos encontramos con AWS y el equipo de seguridad (de la empresa donde trabajo) es que no podemos tener abierto el puerto 587 a todo el mundo (0.0.0.0/0). Para ello, tenemos que saber que IPs usan los del servicio de envío de mails (que tambien es de AWS) y añadirlas al SG de la instancia. 
 
El segundo problema es que esas IPs van cambiando cada X. 
 
Lo que hacemos es montar un CRON para que ejecute un script al día. El script elimina del SG las IPs antiguas y añade las IPs nuevas. 
 
-----------------------------------------------------------------------------------------------------------------------------------------

ENGLISH

In my case, I needed the script to update the ips of the mailing service. One of the problems that we find with AWS and the security team (of the company where I work) is that we cannot have port 587 open to everyone (0.0.0.0/0). To do this, we have to know which IPs are used by the mailing service (which is also from AWS) and add them to the SG of the instance.

The second problem is that those IPs change every X.

What we do is set up a CRON to run a script a day. The script removes the old IPs from the SG and adds the new IPs.
