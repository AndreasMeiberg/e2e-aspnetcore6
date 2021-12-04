---
applies-to: Azure App Service (web apps)
---

# Deployment slots

## Introduction

Deployment slots are a feature of Microsoft Azure, specifically the App Service.

Using a deployment slot allows us to **test the app before it comes live for actual users**, and just switch the slots when we think it's ready to  put it into production.

Further advantages include:

- Allows for **rollback** (switching back to the previous slot)
- **Redirect** certain amount of users/traffic to the new version (slot)
- Reduces **startup times** bymaking sure the app is fully loaded

## Part of the solution

- Bicep file: [windows-webapp-slots-template.json](/Infrastructure/Modules/BasicLinuxWebAppWithSlot.bicep) with one additional parameter **SlotName** (typically: `staging`)
- Changes to build and deployment pipelines to point to the new ARM template
- Changes to `Deploy.yml`:
  * Added task `AzureAppServiceManage@0` to swap the staging slot with the production slot.
  * Repeated call to `SmokeTest.ps1` to run tests against staging as well as production slots.

## Open issues

- Should we run the functional UI tests before swapping slots (right now they run after the fact only)