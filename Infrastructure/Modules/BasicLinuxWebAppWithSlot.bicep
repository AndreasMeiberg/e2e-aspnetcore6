// based on: https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.web/webapp-basic-linux/azuredeploy.json
// Modifications:
// - Removed default parameter for webAppName
// - Changed prefix/suffixes for resource names (see variables section)

@description('Base name of the resource such as web app name and app service plan ')
@minLength(2)
param webAppName string

@minLength(2)
param slotName string

@description('The SKU of App Service Plan ')
param sku string = 'S1'

@description('The Runtime stack of current web app')
param linuxFxVersion string = 'php|7.4'

param alwaysOn bool = false
param clientAffinityEnabled bool = true

@description('Location for all resources.')
param location string = resourceGroup().location

var webAppPortalName_var = webAppName
var appServicePlanName_var = '${webAppName}-plan'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName_var
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true // 'true' for Linux app service plan, 'false' for Windows
  }
}

resource webApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppPortalName_var
  location: location
  kind: 'app,linux'
  properties: {
    enabled: true
    httpsOnly: true
    clientAffinityEnabled: clientAffinityEnabled
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: alwaysOn
      minTlsVersion: '1.2'
    }
  }
}

resource deploymentSlot 'Microsoft.Web/sites/slots@2021-02-01' = {
  parent: webApp
  name: slotName
  location: location
  properties: {
    enabled: true
    httpsOnly: true
    clientAffinityEnabled: clientAffinityEnabled
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: alwaysOn
      minTlsVersion: '1.2'
    }
  }
}

output defaultHostname string = webApp.properties.defaultHostName
output slotDefaultHostname string = deploymentSlot.properties.defaultHostName
