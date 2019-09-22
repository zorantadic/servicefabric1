<#
    This script is a part of Pluralsight's "Azure Service Fabric Programming Models" course. Module 6.
#>

$PackageLocation = "C:\dev\pluralsight-azureservicefabric-programmingmodels\M6\ECommerce\pkg\Debug"
$ApplicationImagePath = "ECommercePackage"
$ApplicationTypeName = "ECommerceType"
$ApplicationInstanceName = "fabric:/MyEcommerceApp"
$ApplicationVersion = "1.0.0"

# 1. Connect to Local Cluster
Connect-ServiceFabricCluster

# 2. Test application package is valid
Test-ServiceFabricApplicationPackage -ApplicationPackagePath $PackageLocation

# 3. Upload application package

# But first, get image store connection string
Import-Module "$ENV:ProgramFiles\Microsoft SDKs\Service Fabric\Tools\PSModule\ServiceFabricSDK\ServiceFabricSDK.psm1"
$clusterManifest = Get-ServiceFabricClusterManifest
$connectionString = Get-ImageStoreConnectionStringFromClusterManifest -ClusterManifest $clusterManifest

# Finally, upload the package
Copy-ServiceFabricApplicationPackage `
    -ApplicationPackagePath $PackageLocation `
    -ApplicationPackagePathInImageStore $ApplicationImagePath `
    -ImageStoreConnectionString $connectionString

# 4. Register application package
# This is where you will see application type in SFE
Register-ServiceFabricApplicationType -ApplicationPathInImageStore $ApplicationImagePath

# 5. Create application instance
New-ServiceFabricApplication `
    -ApplicationName $ApplicationInstanceName `
    -ApplicationTypeName $ApplicationTypeName `
    -ApplicationTypeVersion $ApplicationVersion


