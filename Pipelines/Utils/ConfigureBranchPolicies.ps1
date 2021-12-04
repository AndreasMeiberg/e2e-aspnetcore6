# Docs: https://docs.microsoft.com/en-us/cli/azure/repos/policy/approver-count?view=azure-cli-latest&WT.mc_id=DOP-MVP-21138

$repo = "e2e-aspnetcore6"
$branch = 'refs/head/main'

# Approver count policy
az repos policy approver-count create `
  --repository-id $repo `
  --branch $branch `
  --enabled true `
  --blocking true `
  --minimum-approver-count 1 `
  --creator-vote-counts true `
  --reset-on-source-push true `
  --allow-downvotes true
