param owner string
param location string
param subscriptionName string
param sqlServerName string
param sqlDbName string
param adminAADGroup string
param adminAADGroupId string
param tenantId string
param logAnalyticsWorkspaceId string
param sqlDbSkuName string
param sqlDbSkuTier string

//sql server
resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  tags: {
    owner: owner
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: true
      login: adminAADGroup
      principalType: 'Group'
      sid: adminAADGroupId
      tenantId: tenantId
    }
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    version: '12.0'
  }
}

//sql db
resource sqldb 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: sqlDbName
  location: location
  tags: {
    owner: owner
  }
  sku: {
    name: sqlDbSkuName
    tier: sqlDbSkuTier
  }
  parent: sqlServer
  properties: {
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    collation: 'SQL_Latin1_General_CP1_CI_AS'    
  }
}

// sql db diagnostic settings
resource sqldb_diagnosticsSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'sqldb_diagnosticsSettings'
  scope: sqldb
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        categoryGroup: 'audit'
        enabled: true
      }
      {
        categoryGroup: 'allLogs'
        enabled: true
      }
    ]
  }
  dependsOn: [
    sqldb
  ]
}

// sql server audit settings to LAW
resource SqlServer_DiagnosticSettings 'Microsoft.Sql/servers/databases/providers/diagnosticSettings@2021-05-01-preview' ={
  name: '${sqlServer.name}/master/microsoft.insights/LogAnalytics'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs:[
      {
        category: 'SQLSecurityAuditEvents'
        enabled: true
      }
    ]
  }
  dependsOn: [
    sqldb
  ]
}
