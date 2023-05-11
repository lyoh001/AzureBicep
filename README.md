# Azure - BICEP
## Overview
This repository contains Azure Bicep code for deploying various Azure resources as Infrastructure as Code. The code in this repository will deploy the following resources:
- Resource Group
- Azure Monitoring via Eventgrid & event subscription
- API Management
- Automation Account
- CosmosDb
- Data Factory v2.0
- Data Lake Store
- Databricks
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

## Usage
To deploy these resources using Azure Bicep, you will need to provide the following information in your deployment:

- Azure Tenant ID: tenant-id
- Azure Subscription ID: subscription-id
- Azure Client ID: client-id

You can securely store these values by using GitHub Secrets or other secure methods. Here is an example of how to reference these values in your Bicep deployment:

```
tenant-id: ${{ secrets.AZURE_TENANT_ID }}
subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
client-id: ${{ secrets.AZURE_CLIENT_ID }}
```

## References
- [Azure OpenID Connect](https://learn.microsoft.com/en-us/azure/active-directory/workload-identities/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp)

- [Azure Bicep](https://github.com/Azure/bicep/)

Feel free to explore the code and customize it according to your specific requirements. If you have any questions or need further assistance, please refer to the references or reach out for support.