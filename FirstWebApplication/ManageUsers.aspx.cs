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
    public partial class ManageUsers : System.Web.UI.Page
    {

        public int iCustomerStatus;
        public String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                dataload();
            }

        }

        public void dataload()
        {
            SqlConnection objSqlCon = new SqlConnection(sConnectionString);
            String sID = Request.QueryString["ID"];
            if (sID != null)
            {
                //String sConnectionString = ConfigurationManager.ConnectionStrings["Dbconnection"].ToString();

                objSqlCon.Open();
                string slqString = "select * from LoginDetails where ID=" + sID;

                SqlDataAdapter sqlDA = new SqlDataAdapter(slqString, objSqlCon);
                DataTable dtDetails = new DataTable();
                sqlDA.Fill(dtDetails);

                foreach (DataRow dr in dtDetails.Rows)
                {
                    txtManageFirstName.Text = dr["FirstName"].ToString();
                    txtManageLastName.Text = dr["LastName"].ToString();
                    txtEmailAddress.Text = dr["EmailID"].ToString();
                    txtPassword.Text = dr["password"].ToString();
                    txtConfirmPassword.Text = dr["password"].ToString();
                    int iStatus =Convert.ToInt32(dr["status"]);
                    
                    if(iStatus==1)
                    {
                        chkCaseStatus.Checked = true;
                    }
                    else
                    {
                        chkCaseStatus.Checked = false;
                    }
                    
                    //Below codes can be enabled once once complete the code .

                    //txtPassword.Text = _Util.Decryptdata(dr["password"].ToString());
                    //txtConfirmPassword.Text = _Util.Decryptdata(dr["password"].ToString());
                    //string sDecryptyPassword = _Util.Decryptdata(sEncryptPassword);
                    objSqlCon.Close();
                }
            }
            else
            {
                btnUpdate.Text = "Add New User";
                chkCaseStatus.Visible = false;
                lblCaseStatus.Visible = false;
                lblErrorCaseStatus.Visible = false;
                
            }
        }

        protected void clik_Submit(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
                String sID = Request.QueryString["ID"];
                SqlConnection objSqlCon = new SqlConnection(sConnectionString);
                if (sID != null)
                {
                    //I am not able to use the common valriables that i have declared in the previous methods and if i declare outside the method i am getting the error messages.
                    try
                    {
                        lblErrorMessage.InnerText = "";
                        objSqlCon.Open();
                        string sUserName = ((TextBox)form1.FindControl("txtManageFirstName")).Text;
                        
                        //iCustomerStatus = chkCaseStatus.checked true?1?0;

                        //string sEncryptPassword = _Util.Encryptdata(txtPassword.Text);
                        //string sDecryptyPassword = _Util.Decryptdata(txtPassword.Text);

                        string slqString = "UPDATE LoginDetails SET EmailID ='" + txtEmailAddress.Text.Trim() + "', Password ='" + txtPassword.Text.ToString().Trim() + "', FirstName ='" + txtManageFirstName.Text.Trim() + "', LastName ='" + txtManageLastName.Text.Trim() + "',Status = " + iCustomerStatus + ", DateOfEntry ='" + DateTime.Now.ToString() + "', CreatedBy ='" + Session["sesUserName"].ToString().Trim() + " 'where ID = " + sID.Trim() + ";";
                        SqlCommand cmd = new SqlCommand(slqString, objSqlCon);
                        cmd.ExecuteNonQuery();
                        objSqlCon.Close();
                        //I need to validate whether the update was successfull or not before displaying the message            
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerText = "Your update has been logged in the database !!";
                    }
                    catch
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerText = "Your update has not been logged in the database !!";
                    }
                }
                else
                {
                    try
                    {
                        //Adding new user
                        chkCaseStatus.Visible = false;
                        //iCustomerStatus = 1;
                        //string sEncryptPassword = _Util.Encryptdata(txtPassword.Text);

                        objSqlCon.Open();
                        string slqInsertString = "INSERT INTO loginDetails (EmailID, Password, FirstName, LastName, Status, DateOfEntry, CreatedBy) values ('" + txtEmailAddress.Text + "','" + txtPassword.Text.ToString() + "','" + txtManageFirstName.Text + "','" + txtManageLastName.Text + "'," + 1 + ",'" + DateTime.Now.ToString() + "', '" + Session["sesUserName"].ToString().Trim() + "');";
                        SqlCommand cmd = new SqlCommand(slqInsertString, objSqlCon);
                        cmd.ExecuteNonQuery();
                        objSqlCon.Close();
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerText = "New User has been added!!";
                    }
                    catch
                    {
                        lblErrorMessage.Visible = true;
                        lblErrorMessage.InnerText = "Sorry, There was some issues in adding new user!!";
                    }
                }
            }

        public void Check_Clicked(Object sender, EventArgs e)
        {
            if (chkCaseStatus.Checked)
            {  
                iCustomerStatus = 1;  
            } 
            else
            { 
                iCustomerStatus = 0; 
            }
                 
        }


        //}
    }
}