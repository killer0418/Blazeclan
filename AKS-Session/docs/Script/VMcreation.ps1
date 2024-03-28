Set-AzContext -SubscriptionId $vmParams.value[12]
$vmConfig = New-AzVMConfig -VMName $vmParams.value[0] -VMSize $vmParams.value[1]
$cred = New-Object System.Management.Automation.PSCredential ($vmParams.value[2], ($vmParams.value[3] | ConvertTo-SecureString -AsPlainText -Force))
    Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmParams.value[0] -Credential $cred
    Set-AzVMSourceImage -VM $vmConfig -PublisherName $vmParams.value[4] -Offer $vmParams.value[5] -Skus $vmParams.value[6] $vmParams.value[7]
$vnet = Get-AzVirtualNetwork -Name $vmParams.value[8] -ResourceGroupName $vmParams.value[10]
    $subnet = Get-AzVirtualNetworkSubnetConfig -Name $vmParams.value[9] -VirtualNetwork $vnet
    $pip = New-AzPublicIpAddress -Name "$($vmParams.value[0])-pip" -ResourceGroupName $vmParams.value[10] -Location $vmParams.value[11] -AllocationMethod Static
    $nic = New-AzNetworkInterface -Name "$($vmParams.value[0])-nic" -ResourceGroupName $vmParams.value[10] -Location $vmParams.value[11] -SubnetId $subnet.Id -PublicIpAddressId $pip.Id
    Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id
$osDiskConfig = New-AzDiskConfig -CreateOption FromImage -DiskSizeGB 128 -AccountType "Standard_LRS"
New-AzVM -ResourceGroupName $vmParams.value[10] -Location $vmParams.value[11] -VM $vmConfig