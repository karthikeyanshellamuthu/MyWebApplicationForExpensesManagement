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

namespace FirstWebApplication
{
    public partial class UsersList : System.Web.UI.Page
    {
  
       CommonUtil _Util = new CommonUtil();
       protected void Page_Load(object sender, EventArgs e)
        {
            
           if(!IsPostBack)
           {
               //ListUsers();
               loadGriData();
           }           
        }
       private void loadGriData()
       {
           SqlConnection objSqlCon = _Util.ConnString();
           objSqlCon.Open();
           string slqString = "SELECT ID, EmailID, Password, FirstName, LastName, DateOfEntry, CreatedBy, CASE WHEN Status = 1 THEN 'Active' ELSE 'In Active' END AS Status FROM loginDetails WHERE ISNULL(isDeleted,0) =0 order by FirstName;";

           SqlDataAdapter sqlDA = new SqlDataAdapter(slqString, objSqlCon);
           DataTable dtDetails = new DataTable();

           sqlDA.Fill(dtDetails);
           grid1.DataSource = dtDetails;
           Session["loginDetails"] = dtDetails;
           grid1.DataBind();           
                     
       }

       protected void Users_AddNewUser(object sender, EventArgs e)
        {
            Response.Redirect("~/ManageUsers.aspx");         

        }

       protected void grid1_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
       {
           grid1.PageIndex = e.NewPageIndex;
           loadGriData();
       }

       protected void gridView_Sorting(object sender, GridViewSortEventArgs e)
       {
           DataTable dt = (DataTable)Session["loginDetails"];
           dt.DefaultView.Sort = e.SortExpression // column name
               + " " + SortDir(e.SortExpression); // sort direction
           grid1.DataSource = dt;
           grid1.DataBind();
       }

       private string SortDir(string sColumn)
       {
           string sDir = "asc"; // ascending by default
           string sPreviousColumnSorted = ViewState["SortColumn"] != null
               ? ViewState["SortColumn"].ToString()
               : "";

           if (sPreviousColumnSorted == sColumn) // same column clicked? revert sort direction
               sDir = ViewState["SortDir"].ToString() == "asc"
                   ? "desc"
                   : "asc";
           else
               ViewState["SortColumn"] = sColumn; // store current column clicked

           ViewState["SortDir"] = sDir; // store current direction

           return sDir;
       }

       protected void Search_Filter(object sender, EventArgs e)
       {
           Console.WriteLine("Inside Button Click");
           int iStatus = 0;
           String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           SqlConnection objSqlCon = new SqlConnection(sConnectionString);
           SqlCommand cmd = new SqlCommand(objSqlCon.ConnectionString);
           cmd.CommandText = "UserFilter";
           cmd.CommandType = CommandType.StoredProcedure;
           cmd.Connection = objSqlCon;
           //iStatus = 1;
           if (dpnfilterStatus.Value == "SelectStatus")
           {
               iStatus = 3;
           }           
           else if(dpnfilterStatus.Value == "Active")
           {
               iStatus = 1;
           }
           else if (dpnfilterStatus.Value != "InActive")
           {
               iStatus = 0;
           }
           else
           {

           }
           cmd.Parameters.AddWithValue("@EmailID", filterEmailAddress.Value);
           cmd.Parameters.AddWithValue("@FirstName", filterFirstName.Value);
           cmd.Parameters.AddWithValue("@LastName", filterLastName.Value);
           cmd.Parameters.AddWithValue("@CreatedBy", filterCreatedBy.Value);
           cmd.Parameters.AddWithValue("@Status", iStatus);
               objSqlCon.Open();
               SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
               DataTable dtDetails = new DataTable();
               sqlDA.Fill(dtDetails);
               grid1.DataSource = dtDetails;
               Session["loginDetails"] = dtDetails;
               grid1.DataBind();
               objSqlCon.Close();       
       }
       protected void Cancel_Filter(object sender, EventArgs e)
       {
           loadGriData();
       }
       public void ListUsers()
       {
           List<UserDetails> Users = new List<UserDetails>();

           SqlConnection objSqlCon = _Util.ConnString();
           string slqString = "SELECT ID, EmailID, Password, FirstName, LastName, DateOfEntry, CreatedBy FROM loginDetails WHERE ISNULL(isDeleted,0) =0 order by FirstName;";
           SqlCommand sqlCmd = new SqlCommand(slqString, objSqlCon);
           SqlDataReader sqlDR;
           //DataTable dtDetails = new DataTable();

           using(objSqlCon)
           {
               objSqlCon.Open();
               using(sqlDR = sqlCmd.ExecuteReader())
               {
                while(sqlDR.Read())
                   {
                       Users.Add(new UserDetails(){ID = Convert.ToInt32(sqlDR["ID"]),
                                                   EmailId = sqlDR["EmailID"].ToString(),
                                                   Password = sqlDR["Password"].ToString(),
                                                   FirstName = sqlDR["FirstName"].ToString(),
                                                   LastName = sqlDR["LastName"].ToString(),
                                                   DateOfEntry = Convert.ToDateTime(sqlDR["DateOfEntry"]),
                                                   CreatedBy = sqlDR["CreatedBy"].ToString()
                       });
                   }
                   objSqlCon.Close();
               }
           }
       }
    
     [WebMethod]

       public static string cDeleteUser(deleteUserDetails deleteUserDetails)
       {           
          String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
          SqlConnection objSqlCon = new SqlConnection(sConnectionString);
                  
            try 
            {
                using (SqlConnection sqlCon = objSqlCon)
                {
                    using(SqlCommand cmd = new SqlCommand(sqlCon.ConnectionString))
                    {
                        cmd.CommandText = "DeleteUser";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = sqlCon;
                        cmd.Parameters.AddWithValue("@ID", deleteUserDetails.ID);
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
     
    }

 }