global class ContactShareController
{  
   webservice static string shareContact(string conId)
   {
       ContactShare con = new ContactShare();
       con.ContactId = conId;
       con.ContactAccessLevel = 'Edit';
       con.RowCause = 'Manual';
       con.UserOrGroupId = '00528000000kIX8';
       
       Database.SaveResult sr = Database.insert(con,false);
       string strMsg = '';
        
       if(!sr.isSuccess())
       {
            Database.Error err = sr.getErrors()[0];     
            strMsg = 'Unable to grant sharing access due to following exception: ' + err.getMessage();               
       }
       else
       {
            strMsg = 'Shared with ' + con.id;
       }    
       system.debug('-----------'+strMsg);
       return strMsg;
   }
}