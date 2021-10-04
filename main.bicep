param subscriptionId string
param kvResourceGroup string = 'identity'
param kvName string = 'cm-identity-kv'

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
}

module sql './sql.bicep' = {
  name: 'deploySQL'
  params: {
    administratorLogin: kv.getSecret('sqlAdministratorLogin')
    administratorLoginPassword: kv.getSecret('sqlAdministratorLoginPassword')
  }
}
