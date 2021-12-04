## Overview of features

- :white_check_mark: Build ASP .NET 6 web app, incl. [unit tests][unit-tests] and [code covarage][/Code-Coverage]
- :white_check_mark: Automated build using the [.NET SDK Docker container][container]
- :white_check_mark: [Multi-stage pipelines](/Multi%2Dstage-Pipeline) (Azure Pipelines YAML 🚀)
- :white_check_mark: [Infrastructure as Code](/Infrastructure-as-code) (Azure Resource Manager templates), incl. ARM template validation (as part of build)
- :white_check_mark: Deployment to Azure (Azure App Service)
- :white_check_mark: Variable substitution (FileTransform task)
- :white_check_mark: [Simple smoke test using PowerShell][smoke-test]
- :white_check_mark: [Functional UI tests][selenium-tests] (Selenium Web Driver)
- :white_check_mark: [Deployment slots](/Deployment-Slots) (Azure App Service)
- :white_check_mark: [Pull Request templates][pr-template] (Git)
- :white_check_mark: [Database build and deployment](/Database-Lifecycle) (SSDT) TODO: DEPLOYMENT STILL NEEDS TO BE ADDED
- :white_check_mark: Secret scanning using [Gitleaks][gitleaks] :warning: TODO: NEEDS TESTING
- :white_check_mark: Custom package mirror feed :warning: TODO: NEEDS TO BE CONFIGURED

[unit-tests]:     https://andrewlock.net/exploring-dotnet-6-part-6-supporting-integration-tests-with-webapplicationfactory-in-dotnet-6/
[container]:      https://github.com/dotnet/dotnet-docker/blob/main/samples/build-in-sdk-container.md
[gitleaks]:       https://github.com/zricethezav/gitleaks
[smoke-test]:     ../Pipelines/DeployScripts/SmokeTest.ps1
[selenium-tests]: ../Application/aspnet-core-sample.FunctionalTests
[pr-template]:    ../.azuredevops/pull_request_template.md