# script to update the current smtp IP addresses 
 
# Hacemos nslookup a la url para obtener direcciones IPs. 
nslookup [URL-DEL-SERVICIO] > nuevasips.txt
 
# Extraemos las IPs del archivo 
grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' nuevasips.txt > ip.txt
 
# Eliminamos las IPs que no nos sirven. 
sed -n '/127./!p' ip.txt > ip2.txt
 
# La ponemos en formato necesario para las CIDR de los SG de AWS.
awk '{print $0 "/32" }' < ip2.txt > ipnew.txt
 
# Guardamos las IPs en una varibale de terminal.
export newips=$(cat ipnew.txt)
 
# Eliminamos las IPs viejas del SG
group-ID=[ID-DE-TU-SG] 
aws ec2 revoke-security-group-egress --group-id $group-ID --ip-permissions "`aws ec2 describe-security-groups --group-id $group-ID --query 'SecurityGroups[].IpPermissionsEgress[0]'`"
 
# Agregamos las IPs nuevas al SG
while IFS= read -r line; do aws ec2 authorize-security-group-egress --group-id $group-ID --protocol tcp --port 587 --cidr "$line"; done < <(printf '%s\n' "$newips")
 
# Borramos los txt
rm *.txt

# Obviamente hay mucho que mejorar pero como primera versión, funciona. 
# TODO: Añadir como variables puerto y protocolo y añadir descripción a cada IP.
