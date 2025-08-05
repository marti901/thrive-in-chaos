# Chaos engineering

This repository contains the source code, PowerPoint slides of the Thrive in chaos session.

## Open issues
Don't have to hard code URL's in YARP.

## Creating infra

The infra structure for the demo is defined in Bicep. The Azure CLI can be used to create the resources needed.

To following command shows how the resources can be deployed with the Azure CLI.
```powershell
az deployment sub create --location <location> --template-file ./infra/main.bicep --parameters resourceGroupName=<resourceGroupName>
```

Example that creates an resource groep 'chaos-demo' and deploys the resources to West Europe.
```powershell
az deployment sub create --location 'West Europe' --template-file ./infra/main.bicep --parameters resourceGroupName='chaos-demo'
```


## Additional resources

### Tools
[Azure Chaos Studio](https://learn.microsoft.com/en-us/azure/chaos-studio/chaos-studio-overview)

[Azure Load Testing](https://learn.microsoft.com/en-us/azure/load-testing/overview-what-is-azure-load-testing)

[Chaos Monkey](https://netflix.github.io/chaosmonkey/)

### Microsoft Learn
[Continuously validate and test mission-critical workloads](https://learn.microsoft.com/en-us/training/modules/continuous-validate-test-mission-critical-workloads/)

### Reading books
Chaos Engineering System Resiliency in Practice - ISBN: 9781492043867

### Reading online
[PRINCIPLES OF CHAOS ENGINEERING](https://principlesofchaos.org/)

[Pioneers of modern incident management](https://books.sorryapp.com/2/incident-communication-101/26/pioneers-of-modern-incident-management)

[Weathering the Unexpected
Failures happen, and resilience drills help organizations prepare for them.](https://queue.acm.org/detail.cfm?id=2371516)

### Videos
[The DiRT on Chaos Engineering at Google • Jason Cahoon • GOTO 2021](https://www.youtube.com/watch?v=6I8Ag9mCEpY)

[John Savill's Technical Training: Azure Chaos Studio](https://www.youtube.com/watch?v=IkEQm6m46Ow)

[Chaos & Intuition Engineering at Netflix • Casey Rosenthal • GOTO 2016](https://www.youtube.com/watch?v=Q4nniyAarbs)