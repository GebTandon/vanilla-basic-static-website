#!/bin/bash

shift  $((OPTIND-1))

if [[ "${DRY_RUN}" == "" ]]; then
    echo "Executing T4 import!!"
else
    echo "T4 import command to be executed:- "
fi

pushd terraform &> /dev/null
${DRY_RUN} terraform import azurerm_resource_group.resource_group2 "/subscriptions/0a29e980-4c21-4962-95d2-2bf201b2e927/resourceGroups/Andronix"
${DRY_RUN} terraform import azurerm_key_vault.ya3secrets "/subscriptions/0a29e980-4c21-4962-95d2-2bf201b2e927/resourceGroups/ya3/providers/Microsoft.KeyVault/vaults/ya3secrets"
# ... some more resources to be imported!!

popd &> /dev/null
