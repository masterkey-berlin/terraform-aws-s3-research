# aws-s3-research.md

## Rolle des AWS Providers
Der AWS Provider in Terraform fungiert als Brücke zwischen Terraform und den AWS-APIs. Er ermöglicht die deklarative Verwaltung von AWS-Ressourcen, indem er Terraform-Anweisungen in API-Aufrufe umsetzt.

## Konfiguration des AWS Providers
```hcl
provider "aws" {
  region = "eu-central-1"
}
Argumente:

region
: Legt die Zielregion für alle Ressourcen fest, um sie geografisch zu organisieren und Latenz zu minimieren.
Authentifizierung:
Verwendet werden AWS CLI Credentials oder Umgebungsvariablen, um die Authentifizierung sicherzustellen, ohne Keys direkt im Code zu speichern.

aws_s3_bucket Ressource
Repräsentiert einen S3-Bucket in AWS, der Objekte speichern kann.

Gefundene Dokumentation
Wo?
HashiCorp Terraform Registry: hashicorp/aws
Unterschied Argument Reference vs. Attribute Reference
Argument Reference: Parameter, die beim Erstellen der Ressource gesetzt werden (z.B.
bucket
,
tags
).
Attribute Reference: Werte, die nach der Erstellung von AWS zurückgegeben werden und ausgelesen werden können (z.B.
arn
,
id
,
bucket_domain_name
).
Umgesetztes Beispiel (main.tf)
resource "aws_s3_bucket" "example" {
  bucket = "mein-beispiel-bucket"
  tags = {
    Environment = "Dev"
  }
}

output "bucket_arn" {
  value = aws_s3_bucket.example.arn
}
Erklärung:
Der Output gibt die ARN des Buckets aus, was nützlich ist, um den Bucket eindeutig zu identifizieren oder in anderen Ressourcen zu referenzieren. ```

## Argument Reference
- **bucket** (erforderlich): Name des S3 Buckets
- **acl** (optional, veraltet): Zugriffskontrolleinstellungen (besser via Policies oder Block Public Access)
- **tags** (optional): Schlüssel-Wert-Paare für die Kategorisierung
- **versioning** (optional): Versionierungseinstellungen (z.B. `enabled = true`)

### Attribute Reference
- **id**: Eindeutige ID des Buckets
- **arn**: Amazon Resource Name des Buckets
- **bucket_domain_name**: Standard-Domainname des Buckets
- **bucket_regional_domain_name**: Regionale Domainname des Buckets