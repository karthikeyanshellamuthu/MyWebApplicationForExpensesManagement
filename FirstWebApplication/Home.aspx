<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="FirstWebApplication.Home" MasterPageFile="~/UsersMasterPage.Master" %>

<%--<%@ Page Title="Home.aspx" Language="C#" MasterPageFile="~/UsersMasterPage.Master" AutoEventWireup="false" CodeBehind="Home.aspx.cs" Inherits="FirstWebApplication.Home" %>  --%>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="Custom.css">
    <html xmlns="http://www.w3.org/1999/xhtml">

<body id="HomeBody">
    <div>
    <div>
        <label id="greetings" class="lblmessage" runat="server" style="position:absolute; left:1%;color:antiquewhite" >Hi <%:Session["sesUserName"].ToString() %></label>
    </div>
    </div>
</body>
</html>
    <!-- content -->
</asp:Content>



