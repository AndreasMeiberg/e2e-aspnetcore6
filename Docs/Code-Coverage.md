# Code coverage analysis

## Introduction

Code coverage analysis helps to find gaps in the automated tests and highlights trends.

## Parts of the solution

- A runsettings file: [Application/aspnet-core-sample.UnitTests/CodeCoverage.runsettings][cc-rs]
- Test projects have a reference to `coverlet.collector` package
- Changes to build pipeline:
  * Add arguments to **dotnet test**: `--settings $(Build.SourcesDirectory)/Application/aspnet-core-sample.UnitTests/CodeCoverage.runsettings --collect:"XPlat Code Coverage" -- RunConfiguration.DisableAppDomain=true`
  * Add steps to create and upload Code Coverage report:
    ``` YAML
    # https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/build/dotnet-core-cli
    - task: DotNetCoreCLI@2
      displayName: Install ReportGenerator tool
      inputs:
        command: custom
        custom: tool
        arguments: install --tool-path . dotnet-reportgenerator-globaltool
    
    - script: ./reportgenerator -reports:$(Agent.TempDirectory)/**/coverage.cobertura.xml -targetdir:$(Build.SourcesDirectory)/coverlet/reports -reporttypes:"Cobertura"
      displayName: Create reports
    
    # https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/test/publish-code-coverage-results
    - task: PublishCodeCoverageResults@1
      displayName: 'Publish code coverage'
      inputs:
        codeCoverageTool: Cobertura
        summaryFileLocation: $(Build.SourcesDirectory)/coverlet/reports/Cobertura.xml  
    ```

[cc-rs]: https://dev.azure.com/nenoalm/E2E/_git/e2e-aspnetcore6?path=/Application/aspnet-core-sample.UnitTests/CodeCoverage.runsettings&version=GBmain
