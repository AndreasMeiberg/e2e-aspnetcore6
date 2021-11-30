// File        : main.bicep
// Author      : Neno Loje
// Created     : November 30, 2021
// Description : This file describes the Azure resources for this project.

@description('Region for all resources.')
param location string = resourceGroup().location

@minLength(2)
@maxLength(55)
param appName string

var webAppName = toLower('${appName}')
// var appServicePlanName = toLower('${appName}-plan')

module webApp './Modules/BasicLinuxWebApp.bicep' = {
  name: 'webApp'
  params: {
    webAppName: webAppName
    sku: 'S1'
    location: location
    linuxFxVersion: 'DOTNET|6.0'
  }
}
