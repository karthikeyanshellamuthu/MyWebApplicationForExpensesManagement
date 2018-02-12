<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FirstWebForm.aspx.cs" Inherits="FirstWebApplication.FirstWebForm" %>
<link rel="stylesheet" type="text/css" href="Custom.css">
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery-3.2.1.min.js"></script>
    
</head>
<body id="LoginHomeBody">

    <Div class="row">

            <form id="form1" runat="server">
               
                <div class="col-md-6">

                <div class="loginForm">
                       
                              <label id="lblLoginHere" class="clsLoginHere">Login Here</label>

                              <div>
                                   <label id="error" class="label" runat="server"></label>
                              </div>
                            <div>
                                <label id="email" class="label" >Enter Your Email Address</label>
                                <asp:TextBox ID="address" CssClass="txtemailaddress" runat="server" autofocus="autofocus" Placeholder="Enter your Email Address"> </asp:TextBox>
                             </div>
            
                            <div>
                                <label id="password" class="label">Enter Your Password</label>
                                <%--<asp:TextBox ID="txtpassword" CssClass="txtemailaddress"></asp:TextBox>--%>
                                <asp:TextBox ID="txtpassword" CssClass="txtePassword" TextMode="Password" runat="server" Placeholder="Enter your Password"> </asp:TextBox>
                             </div>

                          <asp:ScriptManager runat="server" ID="sc">

                          </asp:ScriptManager>
          
                       <asp:UpdatePanel runat="server" ID="up1" UpdateMode="Conditional">
                           <ContentTemplate>
                   
                                 <div class="">
                                    <asp:Button ID="submit" CssClass="clsButton AlignBtn" OnClick="submit_Click" runat="server" Text="Login" />
                                    <label id="lblLoginError" class="clsLoginErrorMessage" runat="server"></label>
                                 </div>
                               </ContentTemplate>
                           </asp:UpdatePanel>
                </div>
                </div>
            </form>
        </Div>    
</body>

</html>

<script type="text/javascript">
    $(document).ready(function()
    {
        
        $('#submit').click(function () {

            var vEmail = $('#address').val();
            var vPassword = $('#txtpassword').val();

            if (vEmail == null || vPassword == null || vEmail == "" || vPassword == "")
            {
                alert("Email Address or Password can't be empty")
                $('#address').focus();
                return false;
            }           
        })        
    })     
    
</script>
