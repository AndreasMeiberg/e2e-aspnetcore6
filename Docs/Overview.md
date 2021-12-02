## Overview of features

- :white_check_mark: Build ASP .NET 6 web app, incl. [unit tests][unit-tests] and [code covarage][cc]
- :white_check_mark: Automated build using the [.NET SDK Docker container][container]
- :white_check_mark: [Pull Request templates][pr-template] (Git)
- :white_check_mark: Secret scanning using [Gitleaks][gitleaks] :warning: TODO: NEEDS TESTING
- :white_check_mark: Custom package mirror feed :warning: TODO: NEEDS TO BE CONFIGURED

[unit-tests]:   https://andrewlock.net/exploring-dotnet-6-part-6-supporting-integration-tests-with-webapplicationfactory-in-dotnet-6/
[cc]:           Code-Coverage.md
[container]:    https://github.com/dotnet/dotnet-docker/blob/main/samples/build-in-sdk-container.md
[gitleaks]:     https://github.com/zricethezav/gitleaks
[pr-template]:  ../.azuredevops/pull_request_template.md