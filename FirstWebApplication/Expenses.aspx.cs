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

        //protected void bindCheckBoxList()
        //{
        //    String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
        //    SqlConnection objSqlCon = new SqlConnection(sConnectionString);
        //    objSqlCon.Open();

        //    SqlCommand cmd = new SqlCommand();
        //    cmd.CommandText = "Select * from LoginDetails";
        //    cmd.Connection = objSqlCon;
        //    SqlDataReader sqlDR = cmd.ExecuteReader();
        //    ckFriendsName.DataSource = sqlDR;
        //    ckFriendsName.DataTextField = "FirstName";
        //    ckFriendsName.DataBind();         
        //}

       public string ReturnJsonString(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }  

       [WebMethod]
       public string getFriendsDetails()
       {
           String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
           SqlConnection objSqlCon = new SqlConnection(sConnectionString);

           try
           {
               using (SqlConnection sqlCon = objSqlCon)
               {
                   using (SqlCommand cmd = new SqlCommand(sqlCon.ConnectionString))
                   {
                       cmd.CommandText = "Select ID, FirstName from LoginDetails";
                       cmd.Connection = sqlCon;
                       sqlCon.Open();
                       SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                       DataTable dtDetails = new DataTable();
                       sqlDA.Fill(dtDetails);
                       string returnJsonString;
                       returnJsonString = ReturnJsonString(dtDetails);
                       return returnJsonString;

                       //System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                       // List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                       // Dictionary<string, object> row;
                       // foreach (DataRow dr in dtDetails.Rows)
                       // {
                       //     row = new Dictionary<string, object>();
                       //     foreach (DataColumn col in dtDetails.Columns)
                       //     {
                       //         row.Add(col.ColumnName, dr[col]);
                       //     }
                       //     rows.Add(row);
                       // }
                       // return serializer.Serialize(rows);
                       // //return "Success";    
                        sqlCon.Close();
                   }                
               }

           }
           catch (Exception ac)
           {
               return "Error";
           }
       }       

       }
    }
