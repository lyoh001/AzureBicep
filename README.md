# Azure - BICEP
## 1. Introduction
### 1.1	Overview

Azure Bicep will deploy the following resources.
- Resource Group
- Azure Monitoring via Eventgrid & event subscription
- API Management
- Automation Account
- CosmosDb
- Data Factory v2.0
- Eventhub namespace & Eventhub
- Function App
    - Function Storage Account
    - Function App Service Plan
    - Function App
    - Function App Insights
- Key Vault
- Log Analytics Workspace
- Logic Apps
- Machine Learning Workspace Compute
- MySQL Flexible Server
- Recovery Services Vault
- Servicebus namespace & queue
- Static Web Apps
- Stream Analytics
- Storage Account
- Stream Analytics
- Virtual Machine (Ubuntu 20.04 LTS)
- Virtual Machine (Windows Server)
- Vnet (Subnets & NSG)
- Web App
    - Web App Service Plan
    - Web App
    - Web App Insights

```
AZURE_CREDENTIALS
{
    "clientId": "GUID",
    "clientSecret": "SECRET",
    "tenantId": "GUID"
}
```

Ref: [Azure Bicep](https://github.com/Azure/bicep/)

Ref: [Azure OpenID Connect](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
