public  class GetContacts {
    @auraenabled(cacheable=true)
    public static List<Contact>fetchContacts() {
        return [SELECT Id,Name,Phone, Email, AccountId From Contact LIMIT 10];
    }
}