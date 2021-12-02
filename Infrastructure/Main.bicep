// File        : main.bicep
// Author      : Neno Loje
// Created     : November 30, 2021
// Description : This file describes the Azure resources for this project.

@description('Region for all resources.')
param location string = resourceGroup().location

@minLength(2)
@maxLength(55)
param appName string

@minLength(2)
@maxLength(55)
param slotName string = 'Staging'

@minLength(2)
param sku string = 'S1'

@minLength(2)
param linuxFxVersion string = 'DOTNETCORE|6.0'

var webAppName = toLower(appName)
// var appServicePlanName = toLower('${appName}-plan')

module webApp './Modules/BasicLinuxWebAppWithSlot.bicep' = {
  name: 'webApp'
  params: {
    webAppName: webAppName
    slotName: slotName
    sku: sku
    location: location
    linuxFxVersion: linuxFxVersion
    clientAffinityEnabled: false
    alwaysOn: true
  }
}

output defaultHostname string = webApp.outputs.defaultHostname
output slotDefaultHostname string = webApp.outputs.slotDefaultHostname
