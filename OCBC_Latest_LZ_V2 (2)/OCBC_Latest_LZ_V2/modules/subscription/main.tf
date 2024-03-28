data "azurerm_billing_enrollment_account_scope" "bill_scope" {
  billing_account_name    = var.billingac_id
  enrollment_account_name = var.enrollmentac_id
}

resource "azurerm_subscription" "subscription" {
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.bill_scope.id
}