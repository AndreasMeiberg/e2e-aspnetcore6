# Multi-stage pipeline (YAML)

## Pipeline

::: mermaid
 graph LR;
 GitMain[main] -->|CI trigger| BuildWebApp
 GitMain -->|CI trigger| BuildInfra
 GitMain -->|CI trigger| BuildDatabase
 BuildWebApp -->|depends on| EnsureTests
 BuildInfra -->|depends on| EnsureTests
 BuildDatabase -->|depends on| EnsureTests
 subgraph "Build.yml"
   BuildWebApp
   BuildInfra
   BuildDatabase
   EnsureTests
 end
 EnsureTests -->|trigger| DeployInfra
 DeployInfra -->|depends on| DeployWebApp
 DeployWebApp -->|depends on| FunctionalTests
 subgraph "Deploy.yml"
   subgraph "TEST stage"
     DeployInfra
     DeployWebApp
     FunctionalTests
  end
 end
:::

## Overview of Pipelines YAML features

| Feature                                                 | Found in                                                      |
|---------------------------------------------------------|---------------------------------------------------------------|
| How to build a .NET Core 6.x application                | [`Build/Job-BuildWebApp.yml`][buildwebapp-yml]                |
| How to build a SQL Server database project (using SSDT) | [`Build/Job-BuildSQLDB.yml`][buildsqldb-yml]                  |
| CI trigger with path excludes                           | [`Build.yml`][build-yml]                                      |
| Custom run number format ("`name`")                     | [`Build.yml`][build-yml]+[`Deploy.yml`][deploy-yml]           |
| Build pipeline chaining (pipeline trigger)              | [`Deploy.yml`][Deploy-yml]                                    |
| Multi-stage pipeline :warning: with branch filter condition | [`Deploy.yml`][Deploy-yml]                                |
| Deployment jobs and environments                        | [`Deploy/Job-DeployWebApp.ymlp`][deploywebapp-yml]            |
| Download artifact with pattern filter                   | [`Deploy/Job-DeployWebApp.ymlp`][deploywebapp-yml]            |
| :warning: Template expressions (conditionals)           | N/A                                                           |
| Status badges                                           | [`README.md`][../README]                                   |

[build-yml]:         ../Pipelines/Build.yml
[buildwebapp-yml]:   ../Pipelines/Build/Job-BuildWebApp.yml
[buildsqldb-yml]:    ../Pipelines/Build/Job-BuildSQLDB.yml
[deploy-yml]:        ../Pipelines/Deploy.yml
[deploywebapp-yml]:  ../Pipelines/Deploy/Job-DeployWebApp.yml

## Open Issues

- Add a check if the YAML files are formatted correctly (to prevent silent errors where triggers stop working)
