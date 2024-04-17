public  class AccountTriggerHandler {

    public void beforeInsert(List<Account> newAccounts) {

        //Update Type to Prospect if Blank
        for (Account acc : newAccounts) {
            if (String.isBlank(acc.Type)) {
                Acc.Type = 'Prospect';
            }
        }
        //Copy Shipping Address to Billing Address
        for (Account acc : newAccounts) {
            acc.BillingStreet = acc.ShippingStreet;
            acc.BillingCity = acc.ShippingCity;
            acc.BillingState = acc.ShippingState;
            acc.BillingPostalCode = acc.ShippingPostalCode;
            acc.BillingCountry = acc.ShippingCountry;
        }

        //Change Rating to Hot if Phone, Website and Fax are populated
        for (Account Acc : newAccounts) {
            if (!String.isEmpty(acc.Phone) && !String.isEmpty(acc.Website) && !String.isEmpty(acc.Fax)) {
                acc.Rating = 'Hot';
            }
        }
    }

    public void beforeUpdate(List<Account> newAccounts, Map<Id, Account>  oldAccountMap) {

    }

    public void afterInsert(List<Account> newAccounts) {
    
           //Create Associated Contacts
           List<Contact> contactsToInsert = new List<Contact>();
           for (Account acc : newAccounts) {
            Contact newContact = new Contact(AccountId = acc.Id, LastName = 'DefaultContact', Email = 'default@email.com');
            contactsToInsert.add(newContact);
        }
        insert contactsToInsert;
    }

    public void afterUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {

    }
}