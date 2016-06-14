public with sharing class Contact_Search {
	public String contactName {get; set;}
	public void searchContacts() {
		system.debug('---------'+contactName);
		Contact[] contactList = [Select Id, Name From Contact];
		system.debug('---------'+contactList);
	}
}