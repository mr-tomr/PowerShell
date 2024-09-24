$domainRoles = Get-ADDomain | Select-Object PDCEmulator, InfrastructureMaster, RIDMaster
$forestRoles = Get-ADForest | Select-Object SchemaMaster, DomainNamingMaster
$allRoles = [PSCustomObject]@{
    PDCEmulator = $domainRoles.PDCEmulator
    InfrastructureMaster = $domainRoles.InfrastructureMaster
    RIDMaster = $domainRoles.RIDMaster
    SchemaMaster = $forestRoles.SchemaMaster
    DomainNamingMaster = $forestRoles.DomainNamingMaster
}
$allRoles
