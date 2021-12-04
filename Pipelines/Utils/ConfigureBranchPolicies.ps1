# File     : ConfigureBranchPolicies.ps1
# Docs     : https://docs.microsoft.com/en-us/cli/azure/repos/policy?WT.mc_id=DOP-MVP-21138
# Requires : "Edit Policies" permission on the branch

$repoId = $env:BUILD_REPOSITORY_ID
$branch = 'refs/heads/main'

# Approver count policy
az repos policy approver-count create `
  --repository-id $repoId `
  --branch $branch `
  --enabled true `
  --blocking true `
  --minimum-approver-count 1 `
  --creator-vote-counts true `
  --reset-on-source-push true `
  --allow-downvotes true
