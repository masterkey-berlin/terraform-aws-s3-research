 ## Reflexionsfragen 

 ## Welche AWS-Ressourcen (Typen) hast du erstellt? 
 
 (aws_vpc, aws_subnet, aws_security_group, aws_instance)

## Abhängigkeiten: 

Beschreibe, wie z.B. vpc_id = aws_vpc.my_vpc.id eine implizite Abhängigkeit erzeugt. Terraform versteht, dass aws_vpc.my_vpc zuerst erstellt werden muss.

## Rolle der Sicherheitsgruppe:
 Firewall auf Instanzebene; SSH-Regel erlaubt Fernzugriff für Management/Setup.

## Vergleich plan/apply Output:
 Bei S3 nur 1 Ressource; hier mehrere, voneinander abhängige Ressourcen. Der Plan zeigt die Erstellungsreihenfolge.

## terraform.tfstate: 
Nach apply enthält er Details der erstellten AWS-Ressourcen. Nach destroy sind diese Ressourcen daraus entfernt (der State selbst bleibt als Datei (lokal) oder Objekt (remote) bestehen, ist aber "leer" bzgl. dieser Ressourcen).