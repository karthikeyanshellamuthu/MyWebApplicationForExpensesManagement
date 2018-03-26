using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;
using System.Drawing;


namespace FirstWebApplication
{
    public partial class Expenses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                //bindCheckBoxList();
            }
        }
                
       public static string ReturnJsonString(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

        protected void Submit_Expenses(object sender, EventArgs e)
         {

           // //System.IO.Path.GetFileName(upload.PostedFile.FileName);
           // Byte[] imgByte = null;
           // if (upload.HasFile && upload.PostedFile != null)
           // {   HttpPostedFile File = upload.PostedFile;
           //     imgByte = new Byte[File.ContentLength];
           //     File.InputStream.Read(imgByte, 0, File.ContentLength);
           // }
            

           //String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           //SqlConnection objSqlCon = new SqlConnection(sConnectionString);

           //using (SqlConnection sqlCon = objSqlCon)
           //{
           //    using (SqlCommand cmd = new SqlCommand(sqlCon.ConnectionString))
           //    {
           //        cmd.CommandText = "InsertExpenses";
           //        cmd.CommandType = CommandType.StoredProcedure;
           //        cmd.Connection = sqlCon;
           //        cmd.Parameters.AddWithValue("@AddedOn", Convert.ToDateTime(txtCalendar));
           //        cmd.Parameters.AddWithValue("@Comments", txtComments.ToString());
           //        cmd.Parameters.AddWithValue("@Bills", imgByte);
           //        cmd.Parameters.AddWithValue("@FirstName", "Karthikeyan");
           //        cmd.Parameters.AddWithValue("@LastName", "Shellamuthuu");

           //        cmd.Parameters.AddWithValue("@FriendsType", drpFriendsType.Value.ToString());
           //        cmd.Parameters.AddWithValue("@ExpensesAmount", Convert.ToDecimal(txtEnterAmount));
           //        cmd.Parameters.AddWithValue("@splitedUsers", "Splited Users List");
           //        sqlCon.Open();
           //        cmd.ExecuteNonQuery();
           //    }
           //    sqlCon.Close();
           //}
       }
   
       [WebMethod]
       public static string getFriendsDetails()
       {
           String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           SqlConnection objSqlCon = new SqlConnection(sConnectionString);

           try
           {
               using (SqlConnection sqlCon = objSqlCon)
               {
                   using (SqlCommand cmd = new SqlCommand(sqlCon.ConnectionString))
                   {
                       cmd.CommandText = "Select ID, FirstName from LoginDetails where FriendsType = 'Roommates';";
                       cmd.Connection = sqlCon;
                       sqlCon.Open();
                       SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                       DataTable dtDetails = new DataTable();
                       sqlDA.Fill(dtDetails);
                       string returnJsonString;
                       returnJsonString = ReturnJsonString(dtDetails);
                       return returnJsonString;                        
                       sqlCon.Close();
                   }                
               }

           }
           catch (Exception ac)
           {
               return "Error";
           }
       }
       

       [WebMethod]
       public static string cInsertExpenses(ExpensesDetails ExpensesDetails)
       {           
          String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
          SqlConnection objSqlCon = new SqlConnection(sConnectionString);

          //Byte[] imgByte = null;
          //if (upload.HasFile && upload.PostedFile != null)
          //{
          //    HttpPostedFile File = upload.PostedFile;
          //    imgByte = new Byte[File.ContentLength];
          //    File.InputStream.Read(imgByte, 0, File.ContentLength);
          //}

            try 
            {
                using (SqlConnection sqlCon = objSqlCon)
                {
                    using(SqlCommand cmd = new SqlCommand(sqlCon.ConnectionString))
                    {
                     
                        cmd.CommandText = "InsertExpenses";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = sqlCon;
                        cmd.Parameters.AddWithValue("@AddedOn", ExpensesDetails.ExpensesDate.ToShortDateString());
                        cmd.Parameters.AddWithValue("@Comments", ExpensesDetails.Comments);
                        cmd.Parameters.AddWithValue("@Bills", ConvertImgbyte(ExpensesDetails.Bills));
                        cmd.Parameters.AddWithValue("@AddedUserFirstName", ExpensesDetails.FirstName);
                        cmd.Parameters.AddWithValue("@AddedUserLastName", ExpensesDetails.LastName);
                        cmd.Parameters.AddWithValue("@ExpenseAmount", ExpensesDetails.ExpensesAmount);
                        cmd.Parameters.AddWithValue("@SplitWith", ExpensesDetails.SplitWith);
                        sqlCon.Open();
                        cmd.ExecuteNonQuery();
                   }                    
                    sqlCon.Close();
                }
                return "Success";
            }
            catch(Exception ac)
            {
                return "Error";
            }                             
       }

        public static byte[]  ConvertImgbyte(String FileName)
        {             
            String fileLocation = null;
            String path = @FileName;
            String [] Location = path.Split('\\');
            foreach (var IndividualValue in Location)
            {
                if (IndividualValue == "C:" || IndividualValue == "fakepath")
                {

                }
                else
                {
                    fileLocation = IndividualValue;
                    break;
                }
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile("C:/Users/skart/Documents/visual studio 2013/Projects/FirstWebApplication/FirstWebApplication/Upload Images/" + fileLocation);
            byte[] imageByte = ImageToByteArraybyImageConverter(image);
            return imageByte;
        }

        private static byte[] ImageToByteArraybyImageConverter(System.Drawing.Image image)
        {
            ImageConverter imageConverter = new ImageConverter();
            byte[] imageByte = (byte[])imageConverter.ConvertTo(image, typeof(byte[]));
            return imageByte;
        }
        
       [WebMethod]
       public static string getExpensesHistory()
       {
           String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           SqlConnection objSqlCon = new SqlConnection(sConnectionString);

           try
           {
               using (SqlConnection sqlCon = objSqlCon)
               {
                   using (SqlCommand cmd = new SqlCommand(sqlCon.ConnectionString))
                   {
                       cmd.CommandText = "select LEFT(CONVERT(VARCHAR, AddedOn, 120), 10) as AddedOnDate, AddedUserFirstName, AddedUserLastName,(select top 1 expenseAmount from ExpensesTransactionDetails where ExpensesDetailsID = a.ID) as expensesAmount,( STUFF((SELECT ', ' + Ld.FirstName FROM ExpensesTransactionDetails ET ,loginDetails Ld WHERE ET.ContributionUserID = Ld.ID and a.ID = ET.ExpensesDetailsID FOR XML PATH('')), 1, 1, '')) as SplitWith, Comments, a.ID as ID from ExpensesDetails a where  ISNULL(a.IsDeleted,0) <> 1;";
                       cmd.Connection = sqlCon;
                       sqlCon.Open();
                       SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                       DataTable dtDetails = new DataTable();
                       sqlDA.Fill(dtDetails);
                       string returnJsonString;
                       returnJsonString = ReturnJsonString(dtDetails);
                       sqlCon.Close();
                       return returnJsonString;
                   }
               }

           }
           catch (Exception ac)
           {
               return "Error";
           }
       }

       [WebMethod]
       public static string cdeleteExpenses(deleteExpenses deleteExpenses)
       {
         

           String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           SqlConnection objSqlCon = new SqlConnection(sConnectionString);
           SqlCommand cmd = new SqlCommand(objSqlCon.ConnectionString);
           cmd.CommandText = "deleteExpenses";
           cmd.CommandType = CommandType.StoredProcedure;
           cmd.Connection = objSqlCon;
           try
           {
               using (SqlConnection sqlCon = objSqlCon)
               {       cmd.Connection = sqlCon;
                       cmd.Parameters.AddWithValue("@ID", deleteExpenses.ID);
                       objSqlCon.Open();
                       SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                       DataTable dtDetails = new DataTable();
                       sqlDA.Fill(dtDetails);
                       string returnJsonString;
                       returnJsonString = ReturnJsonString(dtDetails);
                       objSqlCon.Close();
                       return returnJsonString;
               }
               //return "Success";
           }
           catch (Exception ac)
           {
               return "Error";
           }
       }

       [WebMethod]
       public static string cEditExpenses(EditExpenses editexpenses)
       {

           String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           SqlConnection objSqlCon = new SqlConnection(sConnectionString);
           SqlCommand cmd = new SqlCommand(objSqlCon.ConnectionString);
           cmd.CommandText = "spEditExpenses";
           cmd.CommandType = CommandType.StoredProcedure;
           cmd.Connection = objSqlCon;
           try
           {
               using (SqlConnection sqlCon = objSqlCon)
               {
                   cmd.Connection = sqlCon;
                   cmd.Parameters.AddWithValue("@ID", editexpenses.ID);
                   objSqlCon.Open();
                   SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                   DataTable dtDetails = new DataTable();
                   sqlDA.Fill(dtDetails);
                   string returnJsonString;
                   returnJsonString = ReturnJsonString(dtDetails);
                   objSqlCon.Close();
                   return returnJsonString;
               }
           }
           catch (Exception ac)
           {
               return "Error";
           }
       }     

    }
       }


    
