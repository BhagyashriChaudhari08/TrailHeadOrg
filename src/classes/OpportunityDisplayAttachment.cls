public with sharing class OpportunityDisplayAttachment {
  public String contactName {get; set;}
  public OpportunityDisplayAttachment() {
      Attachment atmnt = [Select Id From Attachment where Id = '00P280000057jfj'];
      system.debug('---------'+atmnt);
  }
  public void searchContacts() {
    system.debug('---------'+contactName);
    Contact[] contactList = [Select Id, Name From Contact];
    system.debug('---------'+contactList);
  }
}