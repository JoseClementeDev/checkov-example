# Ejemplos de Escaneo de IaC con Checkov

Este repositorio proporciona ejemplos prácticos de cómo implementar escaneos de seguridad en infraestructura como código utilizando Checkov. Incluye ejemplos para:

- CloudFormation
- Terraform
- Escaneos locales
- Integración con Jenkins

## Requisitos Previos

- Python 3.7+
- Checkov
- Docker (para ejecutar el pipeline de Jenkins)
- Jenkins (opcional, solo para ejecutar el pipeline de CI/CD)

## Instalación

Instalar Checkov:
```bash
pip install checkov
```

Para más opciones de instalación, consulta la [documentación oficial de instalación](https://www.checkov.io/2.Basics/Installing%20Checkov.html).

## Uso

### Preparación

1. Clonar el repositorio:
```bash
git clone https://github.com/tu-usuario/checkov-iac-scanning-examples.git
cd checkov-iac-scanning-examples
```

### Escaneo Local

Para escanear los ejemplos localmente, puedes usar el script proporcionado:

```bash
./scripts/scan.sh
```

O ejecutar Checkov directamente:

```bash
# Escaneo básico
checkov -d ./cloudformation
checkov -d ./terraform

# Escaneo mostrando solo problemas (oculta configuraciones correctas)
checkov -d ./cloudformation --quiet
checkov -d ./terraform --quiet

# Escaneo con reporte en formato JSON
checkov -d ./cloudformation --output json > cloudformation-report.json
checkov -d ./terraform --output json > terraform-report.json

# Escaneo mostrando solo problemas y guardando reporte
checkov -d ./cloudformation --quiet --output json > cloudformation-errors.json
checkov -d ./terraform --quiet --output json > terraform-errors.json
```

### Integración con Jenkins

El proyecto incluye un `Jenkinsfile` en el directorio `jenkins/` que demuestra cómo integrar Checkov en un pipeline de CI/CD.

## Estructura del Proyecto

```shell
.
├── cloudformation/                   # Ejemplos de CloudFormation
│   ├── secure-ec2.yaml               # Ejemplo seguro de EC2
│   └── vulnerable-ec2.yaml           # Ejemplo vulnerable de EC2
├── terraform/                        # Ejemplos de Terraform
│   ├── secure-ec2.tf                 # Ejemplo seguro de EC2
│   └── vulnerable-ec2.tf             # Ejemplo vulnerable de EC2
├── jenkins/                          # Configuración de Jenkins
│   └── Jenkinsfile                   # Pipeline de Jenkins
├── scripts/                          # Scripts de automatización
│   └── scan.sh                       # Script para escaneo local
└── README.md                         # Documentación del proyecto
```

## Ejemplos

### CloudFormation

- [secure-ec2.yaml](cloudformation/secure-ec2.yaml): Ejemplo de una configuración segura de EC2 con:
  - Security groups apropiados
  - IAM roles con permisos mínimos
  - S3 bucket con encriptación
  - Políticas de contraseña fuertes

- [vulnerable-ec2.yaml](cloudformation/vulnerable-ec2.yaml): Ejemplo de una configuración vulnerable con:
  - EC2 sin grupo de seguridad
  - S3 bucket público
  - IAM user con permisos excesivos

### Terraform

- [secure-ec2.tf](terraform/secure-ec2.tf): Ejemplo de una configuración segura de EC2 con:
  - Security groups apropiados
  - IAM roles con permisos mínimos
  - S3 bucket con encriptación
  - Políticas de contraseña fuertes

- [vulnerable-ec2.tf](terraform/vulnerable-ec2.tf): Ejemplo de una configuración vulnerable con:
  - EC2 sin grupo de seguridad
  - S3 bucket público
  - IAM user con permisos excesivos

## Referencias

- [Documentación oficial de Checkov](https://www.checkov.io/)
- [Repositorio de GitHub](https://github.com/bridgecrewio/checkov)