using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstWebApplication

{
    public partial class FirstWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                address.Text = "xyz@gmail.com";
                txtpassword.Text =null;
            }

        }

        protected void submit_Click(object sender, EventArgs e)
        {
                String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
                SqlConnection objSqlCon = new SqlConnection(sConnectionString);
                List<UserDetails> Users = new List<UserDetails>();
                string slqString = "SELECT ID, EmailID, Password, FirstName, LastName, DateOfEntry, CreatedBy FROM loginDetails WHERE ISNULL(isDeleted,0) =0 order by FirstName;";
                SqlCommand sqlCmd = new SqlCommand(slqString, objSqlCon);
                SqlDataReader sqlDR;
                //DataTable dtDetails = new DataTable();

                using (objSqlCon)
                {
                    objSqlCon.Open();
                    using (sqlDR = sqlCmd.ExecuteReader())
                    {
                        while (sqlDR.Read())
                        {
                            Users.Add(new UserDetails()
                            {
                                ID = Convert.ToInt32(sqlDR["ID"]),
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
            
                var vUserInformation = from r in Users
                                       where r.EmailId == address.Text.ToLower() && r.Password == txtpassword.Text.ToLower()
                                       select r;

                


                    if (vUserInformation.Count() > 0)
                    {
                        var getLoginUserDetails = vUserInformation.FirstOrDefault();
                        Session["sesUserName"] = string.Concat(getLoginUserDetails.FirstName, " ", getLoginUserDetails.LastName);
                        Response.Redirect("~/Home.aspx");                      
                                               
                    }
                    else
                    {
                        lblLoginError.InnerText = "Enter the valid UserName or Password";
                    }
                

        
            //    //ListUsers();
            //    //string slqString = "select * from loginDetails";
            //    //SqlDataAdapter sqlDA = new SqlDataAdapter(slqString, objSqlCon);
            //    //DataTable dtDetails = new DataTable();

            //    //String sEmailID = null;
            //    //String sPassword = null;
            //    //String sFirstName = null;
            //    //String sLastName = null;


            //    try
            //    {
            //        sqlDA.Fill(dtDetails);

            //        foreach (DataRow dr in dtDetails.Rows)
            //        {
            //            sEmailID = dr["EmailID"].ToString();
            //            sPassword = dr["Password"].ToString();
            //            sFirstName = dr["FirstName"].ToString();
            //            sLastName = dr["LastName"].ToString();

            //            if (sEmailID.ToLower() == address.Text.ToLower() && sPassword.ToLower() == txtpassword.Text.ToLower())
            //            {
            //                Session["sesUserName"] = string.Concat(sFirstName," ", sLastName);
            //                Response.Redirect("~/Home.aspx");
            //            }
            //            else
            //            {
            //                lblLoginError.InnerText = "Enter the valid UserName or Password";
            //            }
            //        }
            //    }
            //    catch (SqlException se)
            //    {

            //    }
            //    finally
            //    {
            //        objSqlCon.Close();
            //    }
        }        
    }
}