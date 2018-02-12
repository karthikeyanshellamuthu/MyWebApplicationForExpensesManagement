<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="FirstWebApplication.ManageUsers" MasterPageFile="~/UsersMasterPage.Master" enableEventValidation="false"  %>

<asp:Content ID="MangeUser" ContentPlaceHolderID="head" runat="server">

<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="bootstrap.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<script src="jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="Custom.css">

<%--<head runat="server">
    <title></title>
</head>--%>
<body>
    <div class="FormSection">
      <form id="form1" runat="server" style="background-color:#c6c7c7" >
         <div class="ManagersUsersContainer">           
              <div class="row">                    
                    <div class="col-md-2 offset-4 align-items-md-end">
                        <label id="lblManageFirstName">First Name</label>
                    </div>
                    
                     <div class="col-md-2">
                          <asp:TextBox ID="txtManageFirstName" runat="server" CssClass="cssclsManageUsers" placeholder="First Name"></asp:TextBox>
                    </div>
                    
                    <div class="col-md-2">
                        <label id="FirstNameErrorMsg" class="clsErrorMsg" runat="server" style="color:red"></label>
                    </div>
               </div>

              <div class="row">   
                    <div class="col-md-2 offset-4 align-items-md-end">
                        <label id="lblManageLastName">Last Name</label>
                    </div>

                    <div class="col-md-2">
                        <asp:TextBox ID="txtManageLastName" runat="server" CssClass="cssclsManageUsers" Placeholder="Last Name"></asp:TextBox>
                    </div>         
                    
                    <div class="col-md-2">
                        <label id="LastNameErrorMsg" class="clsErrorMsg" style="color:red"></label>
                    </div>
                </div>


               <div class="row">

                    <div class="col-md-2 offset-4 align-items-md-end">
                        <label id="lblManageEmailAddress">Email Address</label>
                     </div>

                    <div class="col-md-2">
                        <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="cssclsManageUsers" Placeholder="example@gmail.com" ></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label id="EmailAddressErrorMsg" class="clsErrorMsg" style="color:red">Enter Valid Email Address</label>
                    </div>

                </div>

             <div class="row">
                    <div class="col-md-2 offset-4 align-items-md-end">
                        <label id="lblManagePassword">Password</label>
                    </div>

                               
                    <div class="col-md-2">
                        <asp:TextBox ID="txtPassword" Textmode="Password" runat="server" CssClass="cssclsManageUsers" Placeholder="*******"></asp:TextBox>
                    </div>

                    <div  class="col-md-2">
                        <label id="PasswordErrorMsg" class="clsErrorMsg" style="color:red">Enter Valid Password</label>
                    </div>                                 
              </div>

            <div class="row">

                    <div class="col-md-2 offset-4 align-items-md-end">
                        <label id="lblManageConfirmPassword">Confirm Password</label>
                    </div>
                              
                    <div class="col-md-2">
                        <asp:TextBox ID="txtConfirmPassword" Textmode="Password" runat="server" CssClass="cssclsManageUsers" Placeholder="*******"></asp:TextBox>
                    </div>

                    <div  class="col-md-2">
                        <label id="ConfirmPasswordErrorMsg" class="clsErrorMsg" style="color:red">Password not matching</label>
                    </div>
           </div>

            <div class="row">

                    <div class="col-md-2 offset-4 align-items-md-end">
                        <label id="lblCaseStatus" runat="server">Customer Status</label>
                    </div>
                              
                    <div class="col-md-2">
                        <asp:CheckBox id="chkCaseStatus" TextAlign="Right" Text="  Is Active Customer ?" OnCheckedChanged="Check_Clicked" runat="server"/>
                    </div>


                    <div  class="col-md-2">
                        <label id="lblErrorCaseStatus" class="clsErrorCaseMsg" style="display:none" runat="server">Age</label>
                    </div>
             </div>
             
           <div class="row">

                     <div class="col-md-6 offset-1 text-md-right">
                         <asp:Button ID="btnUpdate" runat="server" CssClass="clsButtonNewUser" Text="Update" onclick="clik_Submit" />
                     </div>
            </div>

          <div class="row">
                    <div class="col-md-6 offset-3 text-center">
                        <label id="FinalSubmission" runat="server" style="color: red; display:block;"></label>
                        <label id="lblErrorMessage" runat="server" style="color: red; display:block;"></label>             
                    </div>      
          </div>

      </div>

   </form>
  </div>
 </body>
</html>

<%--Not working--%>
<%--<script type="text/javascript">
    function ChangeColor() {
        document.getElementById('<%= lblErrorMessage%>').style.color = 'Red';
        return false;
    }
    
</script>--%>
    
    <script type="text/javascript"> </script>
    <script>
        $(document).ready(function () {

            //$('#chkCaseStatus').html("Customer is Not Active").show();

            $('#head_FirstNameErrorMsg').hide();
            $('#LastNameErrorMsg').hide();
            $('#EmailAddressErrorMsg').hide();
            $('#PasswordErrorMsg').hide();
            $('#ConfirmPasswordErrorMsg').hide();
            
            var error_FirstName = false;
            var error_LastName = false;
            var error_emailAddress = false;
            var error_password = false;
            var error_confirmPassword = false;
            var FormStatus = false;

            $('#head_txtManageFirstName').focusout(function () {

                check_FirstName();
            });

            $('#head_txtManageLastName').focusout(function () {

                check_LastName();
            });

            $('#head_txtEmailAddress').focusout(function () {

                check_EmailAddress();
                
            });            

            $('#head_txtPassword').focusout(function () {
                check_Password();
               
            });

            $('#head_txtConfirmPassword').focusout(function () {
                check_ConfirmPassword();

            });

            $('#head_btnUpdate').click(function () {
             
                form_Submission();
               
                    if (FormStatus)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
            })

            //If($('#chkCaseStatus').is(':Checked'))
            //    $('#chkCaseStatus').text="Customer is Active";
            //});

            function form_Submission()
            {
                check_FirstName();
                check_LastName();
                check_EmailAddress();
                check_Password();
                check_ConfirmPassword();
               
                console.log(error_FirstName, error_LastName, error_emailAddress, error_password, error_confirmPassword);

                if (error_FirstName == false && error_LastName == false && error_emailAddress == false && error_password == false && error_confirmPassword == false)
                {
                    console.log('Insise the if form Validation->', FormStatus)
                    $('#head_FinalSubmission').hide();
                    FormStatus = true;
                }
                else
                {
                    $('#head_FinalSubmission').text("Complete the above fields before submitting !").show();
                    $('#lblErrorMessage').hide();
                    console.log('Insise the else form Validation:', FormStatus)
                    FormStatus = false;
                }
                
            }


            function check_FirstName() {
                var vFirstName = $("#head_txtManageFirstName").val().trim();
                var vFirstNameLength = $('#head_txtManageFirstName').val().length;

                if (vFirstName == null || vFirstName == "") {
                    $('#head_FirstNameErrorMsg').text("First Name can't be empty !!!");
                    $('#head_FirstNameErrorMsg').show();
                    error_FirstName = true;                    
                }
                else if (vFirstNameLength < 3) {
                    $('#head_FirstNameErrorMsg').text("First Name can't too small !!!");
                    $('#head_FirstNameErrorMsg').show();
                    error_FirstName = true;
                }
                else if (vFirstNameLength > 20) {
                    $('#head_FirstNameErrorMsg').text("First Name can't too big !!!");
                    $('#head_FirstNameErrorMsg').show();
                    error_FirstName = true;
                }

                else {
                    $('#head_FirstNameErrorMsg').hide();
                    error_FirstName = false;                }
            }


            function check_LastName() {
                var vLastName = $("#head_txtManageLastName").val().trim();
                var vLastNameLength = $('#head_txtManageLastName').val().length;

                if (vLastName == null || vLastName == "") {
                    $('#LastNameErrorMsg').text("Last Name can't be empty");
                    $('#LastNameErrorMsg').show();
                    error_LastName = true;
                }
                else if (vLastNameLength < 3) {
                    $('#LastNameErrorMsg').text("Last Name can't be too small !!!");
                    $('#LastNameErrorMsg').show();
                    error_LastName = true;

                }
                else if (vLastNameLength > 20) {
                    $('#LastNameErrorMsg').text("Last Name can't be too big !!!");
                    $('#LastNameErrorMsg').show();
                     error_LastName = true;
                }

                else {
                    $('#LastNameErrorMsg').hide();
                    error_LastName = false;
                }
            }

            function check_EmailAddress() {
                var vEmailAddress = $("#head_txtEmailAddress").val().trim();
                var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);

                if (vEmailAddress == null || vEmailAddress == "") {
                    $('#EmailAddressErrorMsg').text("Enter the email address !!!");
                    $('#EmailAddressErrorMsg').show();
                    error_emailAddress = true;
                }

                else if (pattern.test(vEmailAddress)) {
                    $('#EmailAddressErrorMsg').hide();
                    error_emailAddress = false;
                }
                else {
                    $('#EmailAddressErrorMsg').text("Invalid Email Address !!!");
                    $('#EmailAddressErrorMsg').show();
                    error_emailAddress = true;
                }
            }


            function check_Password() {
                var vPassword = $("#head_txtPassword").val().trim();
                var vPasswordLength = $('#head_txtPassword').val().length;

                if (vPassword == null || vPassword == "") {
                    $('#PasswordErrorMsg').text("Password can't be empty !!!");
                    $('#PasswordErrorMsg').show();
                    error_password = true;
                }
                else if (vPasswordLength < 3) {
                    $('#PasswordErrorMsg').text("Enter the password more than 8 characters !!!");
                    $('#PasswordErrorMsg').show();
                    error_password = true;
                }

                else {
                    $('#PasswordErrorMsg').hide();
                    error_password = false;

                }
            }

            function check_ConfirmPassword() {
                var vConfirmPassword = $("#head_txtConfirmPassword").val().trim();
                var vPassword = $("#head_txtPassword").val().trim();
                var vConfirmPasswordLength = $('#head_txtConfirmPassword').val().length;

                if (vConfirmPassword == null || vConfirmPassword == "") {
                    $('#ConfirmPasswordErrorMsg').text("Confirm Password can't be empty !!!");
                    $('#ConfirmPasswordErrorMsg').show();
                    error_confirmPassword = true;
                }
                else if (vConfirmPassword != vPassword) {
                    $('#ConfirmPasswordErrorMsg').text("Password Didn't match !!!");
                    $('#ConfirmPasswordErrorMsg').show();
                    error_confirmPassword = true;
                }

                else {
                    $('#ConfirmPasswordErrorMsg').hide();
                    error_confirmPassword = false;
                }
            }


        })
         
    </script>

  </asp:content>

