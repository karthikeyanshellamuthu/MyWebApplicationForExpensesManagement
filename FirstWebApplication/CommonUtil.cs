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



}