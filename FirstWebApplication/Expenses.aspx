<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Expenses.aspx.cs" ClientIDMode="Static" EnableEventValidation="false" Inherits="FirstWebApplication.Expenses" MasterPageFile="~/UsersMasterPage.Master"%>

<asp:Content ID="ConExpenses" ContentPlaceHolderID="head" runat="server">
    <!DOCTYPE html>

    <link rel="stylesheet" type="text/css" href="bootstrap.css">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <script src="jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="Custom.css">
        <body>
            <form id="form1" runat="server" style="background-color:darkcyan;">
                <div class="row" runat="server">
                    <div class="col-md-3">
                        <label id="lblDataYear" runat="server"> Select the Date/Year</label>
                    </div>
                    <div class='col-sm-3'>
                        <input id="txtDateTimePicker" runat="server" placeholder="Select the Expenses Date"/>
                    </div>
                </div>

                <div class="row" runat="server">
                    <div class="col-md-3">
                        <label id="lblFriendsType" runat="server">Friends Type</label>
                    </div>

                    <div class="col-md-3">
                        <select id="drpFriendsType" runat="server" style="text-size-adjust:10px">
                                      <option value="SelectStatus">-- Friends Type --</option>
                                      <option value="roommate">Roommate</option>
                                      <option value="coworker">Co-Worker</option>
                        </select>
                    </div>
                </div>
                 <div class="row" runat="server">
                    <div class="col-md-3" runat="server">
                        <label id="lblExpenseAmount" runat="server">Enter the Expenses Amount</label>
                    </div>
                    <div class="col-md-3" runat="server">
                        <input id="txtEnterAmount" runat="server" placeholder="Enter the Expenses Amount" />
                    </div>
                </div>
                 <div class="row" runat="server">
                    <div class="col-md-3">
                        <label id="lblFriendsName" runat="server">Split With </label>
                    </div>

                    <div class="col-md-3">
                     <asp:CheckBoxList id="ckFriendsName" runat="Server">    
                                               
                     </asp:CheckBoxList>
                    </div>
                </div>
                <div class="row" runat="server">
                    <div class="col-md-3" runat="server">
                        <label id="lblComments" runat="server">Comments</label>
                    </div>
                    <div class="col-md-3" runat="server">
                       <%-- <input id="txtComments" runat="server" placeholder="Description" />--%>
                        <asp:TextBox id="txtComments" style="Z-INDEX: 101; LEFT: 14px; OVERFLOW: hidden; POSITION: absolute; TOP: 3px" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
                <div class="row" runat="server">
                    <div class="col-md-6 margintop10px text-center">
                         <asp:button  id="btnSubmitExpenses" cssClass="btnSubmit"  runat="server"  Text="Submit Expenses"/>           
                        <%--<asp:Button ID="Button1" runat="server"  Text="Add Expenses" />--%>
                    </div>
                </div>
            </form>
           <div class="row" style="position:absolute;top:550px;width:100%">
               <div class="col-md-6">
                <form id="fHistory" style="position: absolute;left: 24px;width: 95%;background-color:darkcyan">
                    <table class="table" style="width:100%">
                      <thead>
                        <tr>
                          <th scope="col">Sl No</th>
                          <th scope="col">Date</th>
                          <th scope="col">Friends Type</th>
                          <th scope="col">Expense Amount</th>
                          <th scope="col">Description</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <th scope="row">1</th>
                          <td>Mark</td>
                          <td>Otto</td>
                          <td>@mdo</td>
                          <td>@mdo</td>
                        </tr>
                        <tr>
                          <th scope="row">2</th>
                          <td>Jacob</td>
                          <td>Thornton</td>
                          <td>@fat</td>
                          <td>@mdo</td>
                        </tr>
                        <tr>
                          <th scope="row">3</th>
                          <td>Larry</td>
                          <td>the Bird</td>
                          <td>@twitter</td>
                          <td>@mdo</td>
                        </tr>
                      </tbody>
                    </table>
                </form>
               </div>

               <div class="col-md-6">
                   <form style="width:100%; background-color:darkcyan; width:100%; padding:10px 10px 138px 20px">
                         <div class="row">
                             <div class="col-md-6">
                                 <p class="text-left">Left aligned text on all viewport sizes</p>
                             </div>
                          </div>
                    </form>
                </div>
            
            </div>
        </body>
    </html>


 <script type="text/javascript"> </script>
    <script>
        $(document).ready(function () {
            //alert("Inside Selected Dropdown");
            $("#drpFriendsType").change(function () {
                var drpValue = $("#drpFriendsType").val();
                if (drpValue == "roommate") {
                    alert("Inside Selected Dropdown");
                    var jsonData = JSON.stringify({});
                    $.ajax({

                        type: "POST",
                        url: "Expenses.aspx/getFriendsDetails",
                        data: jsonData,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: OnSuccess(),
                        Error: OnErrorCall
                    });

                    function OnSuccess(data) {
                        data = data.d;
                        alert(data);
                        $("#ckFriendsName").append("Karthik");
                        console.log('JSON return data', data);
                        Console.log('Check');
                        alert("Inside Selected Dropdown2");                        
                        $.each(data, function (key, value) {
                            $("#ckFriendsName").append($("<option></option>").val
                            (value.ID).html(value.FirstName));
                        });
                    }

                }
                function OnErrorCall(response) {

                }
            })})                   
        </script>

 </asp:content>
