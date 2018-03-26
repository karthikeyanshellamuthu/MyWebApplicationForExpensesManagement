using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Security.Cryptography;



namespace FirstWebApplication
{
    public class CommonUtil
    {
                
     String sPWEncryptStatus = ConfigurationManager.AppSettings["PwEncryptStatus"].ToString();
     public  SqlConnection ConnString()
     {
        String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
       
        SqlConnection objSqlCon = new SqlConnection(sConnectionString);
        return objSqlCon;
      }
     public  string Encryptdata(string password)
     {
         if(sPWEncryptStatus=="Yes")
         {
             string strmsg = string.Empty;
             byte[] encode = new byte[password.Length];
             encode = Encoding.UTF8.GetBytes(password);
             strmsg = Convert.ToBase64String(encode);
             return strmsg;
         }
         else
         {
             return password;
         }
     }
     public string Decryptdata(string encryptpwd)
     {
         string decryptpwd = string.Empty;
         UTF8Encoding encodepwd = new UTF8Encoding();
         Decoder Decode = encodepwd.GetDecoder();
         byte[] todecode_byte = Convert.FromBase64String(encryptpwd);
         int charCount = Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
         char[] decoded_char = new char[charCount];
         Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
         decryptpwd = new String(decoded_char);
         return decryptpwd;
     } 

}

    public class deleteUserDetails
    {
        public int ID { get; set; }

    }


    public class deleteExpenses
    {        public int ID { get; set; }
    }

    public class editExpenses
    {
        public int ID { get; set; }
    }



    public class UserDetails
    {
        public int ID { get; set; }
        public string EmailId { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfEntry { get; set; }
        public string CreatedBy { get; set; }

    }
    

    public class ExpensesDetails
    {
        public DateTime ExpensesDate { get; set; }
        public string FriendsType { get; set; }
        public float ExpensesAmount { get; set; }
        public string Comments { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public String Bills { get; set; }
        public string FileName { get; set; }
        public string SplitWith { get; set; }
    }


    public class getExpensesHistory
    {
        public int ContributionUserID { get; set; }
        public float ExpenseAmount { get; set; }
        public String Bills { get; set; }
        public string Password { get; set; }
        public string AddedUserFirstName { get; set; }
        public string AddedUserLastName { get; set; }
        public string Comments { get; set; }
        public DateTime AddedOn { get; set; }
        public string SplitWith { get; set; }
    }

    public class EditExpenses
    {
        public int ID { get; set; }
        public DateTime ExpensesDate { get; set; }
        public string FriendsType { get; set; }
        public float ExpenseAmount { get; set; }
        public string Comments { get; set; }
        public String Bills { get; set; }
        public string FileName { get; set; }
        public string SplitWith { get; set; }
    }

}