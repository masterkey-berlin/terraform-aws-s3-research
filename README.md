## AWS Provider für Terraform - Recherche und Beispiel
Dieses Projekt dokumentiert die Recherche zum AWS Provider in Terraform, die Konfiguration eines S3 Buckets sowie die Nutzung der offiziellen Provider-Dokumentation.

## Rolle des AWS Providers in Terraform
Der AWS Provider ermöglicht Terraform, AWS-Ressourcen wie S3 Buckets, EC2-Instanzen, Lambda-Funktionen usw. zu verwalten. Er übersetzt Terraform-Konfigurationen in API-Aufrufe an AWS, um die Infrastruktur zu erstellen, zu ändern oder zu löschen.

## Konfiguration des AWS Providers
In der
main.tf
wurde der Provider wie folgt konfiguriert:

provider "aws" {
  region = "eu-central-1"
}
Region: Gibt an, in welcher AWS-Region die Ressourcen erstellt werden sollen. Hier wurde
eu-central-1
(Frankfurt) gewählt.
Authentifizierung: Die Zugangsdaten werden nicht im Code gespeichert, sondern über Umgebungsvariablen (
AWS_ACCESS_KEY_ID
,
AWS_SECRET_ACCESS_KEY
) oder die AWS CLI-Konfiguration bereitgestellt, um Sicherheit zu gewährleisten.
aws_s3_bucket Ressource
Die Ressource
aws_s3_bucket
repräsentiert einen Amazon S3 Bucket in AWS. In der Konfiguration wurde ein Bucket mit einem eindeutigen Namen erstellt, z.B.
my-research-bucket-12345
.

Wichtige Argumente (Argument Reference)
bucket
(Pflicht): Der globale, eindeutige Name des Buckets.
Weitere optionale Parameter steuern z.B. Versionierung, Verschlüsselung, Zugriffsrechte.
Attribute (Attribute Reference)
arn
: Der Amazon Resource Name des Buckets.
id
: Die eindeutige ID des Buckets.
bucket_regional_domain_name
: Der regionale Domain-Name des Buckets.
Nutzung der Dokumentation
Die offizielle Dokumentation wurde auf Terraform Registry gefunden.

Argument Reference: Beschreibt die Konfigurationsparameter, die beim Erstellen der Ressource notwendig sind.
Attribute Reference: Zeigt, welche Werte nach der Erstellung zur Verfügung stehen.
Beispiel-Code (Kurzfassung)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "my_research_bucket" {
  bucket = "my-research-bucket-12345"
}

output "bucket_arn" {
  value = aws_s3_bucket.my_research_bucket.arn
}
## Zusammenfassung

Dieses Projekt zeigt, wie der AWS Provider in Terraform konfiguriert wird, wie eine AWS-Ressource (S3 Bucket) definiert wird und welche Informationen die Dokumentation bereitstellt. Die praktische Umsetzung erfolgt durch Terraform-Workflows zur Erstellung und Löschung des Buckets.

Hinweis: Alle sensiblen Zugangsdaten sind in Umgebungsvariablen oder AWS CLI-Konfigurationsdateien gespeichert und nicht im Code sichtbar.


## Terraform Projekt: AWS VPC mit EC2 Instanz

Dieses Teilprojekt demonstriert die Erstellung einer einfachen AWS-Infrastruktur bestehend aus einem Virtual Private Cloud (VPC), einem öffentlichen Subnetz, einer Sicherheitsgruppe (Security Group) für SSH-Zugriff und einer EC2-Instanz. Alle Ressourcen werden deklarativ mit Terraform verwaltet.

**Ziele:**
*   Praktische Anwendung von Terraform zur Bereitstellung abhängiger AWS-Ressourcen.
*   Verständnis des Terraform-Workflows (init, plan, apply, destroy) im Cloud-Kontext.

## Terraform: Deployment einer AWS EC2-Umgebung

Dieses Projekt nutzt Terraform, um eine minimale, lauffähige Umgebung in AWS zu provisionieren. Es werden folgende Hauptressourcen erstellt:
*   Virtual Private Cloud (VPC)
*   Öffentliches Subnetz
*   Sicherheitsgruppe (erlaubt SSH)
*   EC2 Instanz (t2.micro)

Die vollständige Terraform-Konfiguration und eine detailliertere Dokumentation der Umsetzung findet sich im Verzeichnis:
➡️ (./terraform/aws-vpc-ec2/solution_reflection.md and images)