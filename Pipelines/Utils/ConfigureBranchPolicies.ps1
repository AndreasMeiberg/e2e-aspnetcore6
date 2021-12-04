# Docs: https://docs.microsoft.com/en-us/cli/azure/repos/policy/approver-count?view=azure-cli-latest&WT.mc_id=DOP-MVP-21138

$branch = 'refs/head/main'

# Approver count policy
az repos policy approver-count create --branch $branch --enabled:true --blocking:true --minimum-approver-count:1 --creator-vote-counts:yes --reset-on-source-push:true

