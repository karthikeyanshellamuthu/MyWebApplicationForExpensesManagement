<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersList.aspx.cs" ClientIDMode="Static" EnableEventValidation="false" Inherits="FirstWebApplication.UsersList" MasterPageFile="~/UsersMasterPage.Master" %>
   

<%--ClientIDMode="Static" --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="bootstrap.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<script src="jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="Custom.css">

<body id="UserListBody">   
    <form runat="server">       
        <div class="UserSearchContainer" style="width:75%;position:absolute;left:154">             
              <div class="row col-md-13">
                    <div class="col-md-4">
                        <input id="filterFirstName" type='text' runat="server" placeholder="First Name"/>
                    </div>
                    <div class="col-md-4">
                        <input id="filterLastName" type='text' runat="server" placeholder="Last Name"/>
                    </div>

                    <div class="col-md-4">
                        <input id="filterEmailAddress" type='text' runat="server" placeholder="Email Address"/>
                    </div>       
              </div>
                
             <div class="row">
                       <div class="col-md-4">
                             <input id="filterCreatedBy" type='text' runat="server" placeholder="Created By"/>                        
                       </div>
                       <div class="col-md-4">
                             <select id="dpnfilterStatus" runat="server" name="filter" style="width: 205px; height:24px">                              
                                      <option value="SelectStatus">-- Customer Status --</option>
                                      <option value="Active">Active</option>
                                      <option value="InActive">In Active</option>
                               </select>
                       </div>               
                </div>
                <div class="row" style="position:absolute;left:331px">
                       <div class="col-md-6">
                             <button id="btnSearch" onserverclick = "Search_Filter" runat="server" text="Search" style="width: 155px; height:29px">Search</button>
                           <%--<asp:Button id="i123"/>--%>
                       </div> 
                          
                       <div class="col-md-6">
                             <button id="btnCancel" onserverclick = "Cancel_Filter" runat="server" text="cancel" style="width: 155px; height:29px">Cancel</button>
                       </div>   
                </div>
                <div class="row">
                     <div class="col-md-6">
                          <label id="lblSearchResults" runat="server" style="color:red;display:none"> No records to display </label>
                     </div>   
                </div>
            </div>
      
                <asp:Button ID="btnAddNewUser" runat="server" CssClass="btnAddUpdate" Text="Add NewUser" onclick="Users_AddNewUser" NavigateUrl ='<%#string.Format("ManageUsers.aspx?id={0}","N")%>'/>             

                    <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="False" OnSorting="gridView_Sorting" CellPadding="4" PageSize="4" ForeColor="#333333" GridLines="None" AllowPaging="true" AllowSorting="true" OnPageIndexChanging="grid1_OnPageIndexChanging" style="color:#333333;border-collapse:collapse;position:  absolute;left: 10%;top: 44%; width: 80%;"> 
               
                             <AlternatingRowStyle BackColor="White"/>    
                                      <columns> 
                                         <asp:TemplateField HeaderText="ID" SortExpression="ID">  
                                             <ItemTemplate>  
                                                 <asp:Label ID="id" runat="server" Text='<%#Bind("ID") %>'></asp:Label>  
                                             </ItemTemplate>
                                         </asp:TemplateField>  
         
                                          <asp:TemplateField HeaderText="Email Address" SortExpression="EmailID">  
                                             <ItemTemplate>  
                                                 <asp:Label ID="lblemailaddress" runat="server" Text='<%#Bind("EmailID") %>'></asp:Label>  
                                             </ItemTemplate>  
                                         </asp:TemplateField>  
        
                                         <asp:TemplateField HeaderText="First Name" SortExpression="FirstName" >  
                                             <ItemTemplate>  
                                                 <asp:Label ID="lblFirstNameUsersList" runat="server" Text='<%#Bind("FirstName") %>'></asp:Label>  
                                             </ItemTemplate>  
                                         </asp:TemplateField>   

                                          <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">  
                                             <ItemTemplate>  
                                                 <asp:Label ID="lblLastNameUsersList" runat="server" Text='<%#Bind("LastName") %>'></asp:Label>  
                                             </ItemTemplate>  
                                         </asp:TemplateField> 

                                          <asp:TemplateField HeaderText="Date Of Entry" SortExpression="DateOfEntry">  
                                             <ItemTemplate>  
                                                 <asp:Label ID="lblDateOfEntry" runat="server" Text='<%#Bind("DateOfEntry") %>'></asp:Label>  
                                             </ItemTemplate>  
                                          </asp:TemplateField> 

                                         <asp:TemplateField HeaderText="Status" SortExpression="Status">  
                                             <ItemTemplate>  
                                                 <asp:Label ID="lblStatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label>  
                                             </ItemTemplate>  
                                          </asp:TemplateField> 

                                          <asp:TemplateField HeaderText="User Created By" SortExpression="CreatedBy">  
                                             <ItemTemplate>  
                                                 <asp:Label ID="Label1" runat="server" Text='<%#Bind("CreatedBy") %>'></asp:Label>  
                                             </ItemTemplate>  
                                          </asp:TemplateField>          
          
                                         <asp:TemplateField HeaderText="Action">  
           
                                             <ItemTemplate> 
                                                   <asp:Hyperlink id="updateIcon" runat="server" NavigateUrl ='<%#string.Format("ManageUsers.aspx?id={0}", Eval("ID"))%>'> 
                                                  <%-- <asp:Hyperlink runat="server" NavigateUrl ="<%:"ManageUsers.aspx?id="+ Eval("ID")%>"> --%>
                                                       <img id="idUpdateUser" src="/images/edit.png" width="20px" height="20px"/>
                                                   </asp:Hyperlink>
                                                   <asp:Hyperlink id="deleteIcon" runat="server"> 
                                                       <img id="idDeleteUser" class="idDeleteUser" src="/images/Delete.png" UserToDelete='<%#Eval("ID")%>' width="20px" height="20px"/>
                                                   </asp:Hyperlink>
                                             </ItemTemplate> 
              
                                         </asp:TemplateField>         

                                     </columns>  

                                             <EditRowStyle BackColor="#2461BF" />  
                                             <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />  
                                             <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />  
                                             <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />  
                                             <RowStyle BackColor="#EFF3FB" />  
                                             <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />  
                                             <SortedAscendingCellStyle BackColor="#F5F7FB" />  
                                             <SortedAscendingHeaderStyle BackColor="#6D95E1" />  
                                             <SortedDescendingCellStyle BackColor="#E9EBEF" />  
                                             <SortedDescendingHeaderStyle BackColor="#4870BE" />  

             </asp:GridView> 
        </form>   
    </body>
</html>


    
<script type="text/javascript"> </script>
    <script>
        $(document).ready(function () {
                     
            $('#btnAddNewUser').click(function () {
                $('#chkCaseStatus').hide();
                $('#lblCaseStatus').hide();
                $('#lblErrorCaseStatus').hide();
            })  

            $("#btnCancel").click(function () {
                $("#filterFirstName").val("");
                $("#filterLastName").val("");
                $("#filterEmailAddress").val("");
                $("#filterCreatedBy").val("");
                $("#dpnfilterStatus").get(0).selectedIndex = 0;
            })

            $("#btnSearch").click(function () {
                $("#lblSearchResults").hide = true;
            })

            $('.idDeleteUser').click(function () {                                
                var r = confirm("Do you want to delete this user ?");
                if (r == true)
                {
                        txt = "Yes";                
                        var deleteUserDetails = {};
                        deleteUserDetails.ID = $(this).attr("UserToDelete");

                       var jsonData = JSON.stringify({ deleteUserDetails: deleteUserDetails });
                        $.ajax({

                            type: "POST",
                            url: "UsersList.aspx/cDeleteUser",
                            data: jsonData,
                            contentType: "application/json; charset=utf-8",
                            datatype: "json",
                            success: OnSuccess,
                            Error: OnErrorCall
                        });

                    function OnSuccess(response)
                    {
                        var result = response.d;
                        console.log(result)
                        if(result== "Success")
                        {
                            location.reload();
                        }

                    }
                    function OnErrorCall(response)
                    {

                    }
                }
                else
                {
                    txt = "No";
                    return false;
                }
            });                

        });
    </script>

</asp:Content>
