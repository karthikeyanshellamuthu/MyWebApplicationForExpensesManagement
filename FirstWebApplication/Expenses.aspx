<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Expenses.aspx.cs" ClientIDMode="Static" EnableEventValidation="false" Inherits="FirstWebApplication.Expenses" MasterPageFile="~/UsersMasterPage.Master"%>

<asp:Content ID="ConExpenses" ContentPlaceHolderID="head" runat="server">
    <!DOCTYPE html>
     <script type="text/javascript" src="CommonJSFunctions.js"></script>
    <link rel="stylesheet" type="text/css" href="Bootstrap.css">
    <%--<script type="text/javascript" src="jquery-3.2.1.min.js"></script>--%>    
    <%--<script type="text/javascript" src="js/jquery-ui.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="Custom.css">
    <html xmlns="http://www.w3.org/1999/xhtml">     

        <body>
            <div class="ExpensesForm">
            <form id="form1" runat="server" style="align-content:center; background-color :darkcyan;">
                <div class="row" runat="server">
                    <div class="col-md-3">
                        <label id="lblDataYear" runat="server"> Select the Date/Year</label>
                    </div>
                    <div class='col-sm-3'>
                        <input id="txtCalendar" class="DatePicker" runat="server" Req="true"/>
                           <%-- <asp:Calendar ID="Calendar2" runat="server" Enabled="True"
                                TargetControlID="TextBoxIDHere" PopupButtonID="CalenderImageIDHere" OnSelectionChanged="Calendar1_SelectionChanged" Format="MM/dd/yyyy">
                            </asp:Calendar>  --%>                                    
                    </div>                    
                </div>

                <div class="row" runat="server">
                    <div class="col-md-3">
                        <label id="lblFriendsType" runat="server">Friends Type</label>
                    </div>

                    <div class="col-md-3">
                        <select id="drpFriendsType" runat="server" style="text-size-adjust:10px" Req="true">
                                      <option value= 0 >-- Friends Type --</option>
                                      <option value= 1 >Roommate</option>
                                      <option value= 2 >Co-Worker</option>
                        </select>
                    </div>
                </div>
                 <div class="row" runat="server">
                    <div class="col-md-3" runat="server">
                        <label id="lblExpenseAmount" runat="server">Enter the Expenses Amount</label>
                    </div>
                    <div class="col-md-3" runat="server">
                        <input id="txtEnterAmount" runat="server" placeholder="Enter the Expenses Amount" Req="true"/>
                    </div>
                </div>
                 <div class="row" runat="server">
                    <div class="col-md-3">
                        <label id="lblFriendsName" runat="server">Split With </label>
                    </div>
                    <div class="col-md-3">
                         <div id="ckFriendsName" Req="true"></div>
                    </div>
                 </div>
                <div class="row" runat="server">
                    <div class="col-md-3" runat="server">
                        <label id="lblComments" runat="server">Comments</label>
                    </div>
                    <div class="col-md-3" runat="server">
                       <%-- <input id="txtComments" runat="server" placeholder="Description" />--%>
                        <asp:TextBox id="txtComments" style="Z-INDEX: 101; LEFT: 14px; OVERFLOW: hidden; POSITION: absolute; TOP: -3px" runat="server" TextMode="MultiLine" Req="true"></asp:TextBox>
                    </div>
                </div>

              <div class="row" runat="server">
                    <div class="col-md-3" runat="server">
                        <label id="lblScreenshots" runat="server">Do you want to attach Image ?</label>
                    </div>
                    <div class="col-md-3" runat="server">
                       <%-- <input id="txtComments" runat="server" placeholder="Description" />--%>
                        <%--<asp:TextBox id="TextBox1" style="Z-INDEX: 101; LEFT: 14px; OVERFLOW: hidden; POSITION: absolute; TOP: 3px" runat="server" TextMode="MultiLine" Req="true"></asp:TextBox>--%>
                       <%-- <asp:RadioButtonList ID="rblScreenshot" name="ScreenshotRadioButton" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem id="rListYes" Text="Yes" Value="1" />
                            <asp:ListItem id="rListNo" Text="No" Value="2" />
                        </asp:RadioButtonList>  --%>         
                        <div class="Yes">
                        <input type="radio" id="RdYes" />           
                            <label id="lbl" for="RdYes">YES</label>
                        </div>                    
                        <div class="NO">
                        <input type="radio" id="RdNo" />           
                            <label id="lbl" for="RdNo">NO</label>
                        </div>  
                    </div>
                </div>

                  <div class="row" runat="server">
                    <div class="col-md-3" runat="server">
                        <label id="Label1" runat="server"></label>
                    </div>
                    <div class="col-md-3" runat="server">
                          <%--<input id="upload" style="Z-INDEX: 102; LEFT: 104px; WIDTH: 100px; HEIGHT: 35px" type="file" Text="Submit" size="28" name="UploadImage" runat="server" Req="true"/>--%>                            
                        <asp:FileUpload ID="upload" text="Choose Image" runat="server" Req="true"/>
                    </div>                      
                </div>

                <div class="row" runat="server">
                    <div class="col-md-6 margintop10px text-center">
                         
                        <input type="button"  class="btnSubmit" id="btnSubmitExpenses" value="Submit Expenses" />
                        <%--<asp:button  id="btnSubmitExpenses" cssClass="btnSubmit"  runat="server"  Text="Submit Expenses" onclick="Submit_Expenses"/>    --%>    
                          
                        <input type="button"  class="btnReset" id="btnResetExpenses" value="Reset Expenses" />   
                    </div>
                </div>
            </form>
           <div class="row" style="position:absolute;top:550px;width:100%">
               <div class="col-md-6" id = "narrorColumn">
                <form id="ExpensesHistory" style="position: absolute;left: 26px;width: 99%;background-color:#e91e63">
                    <table id= "tblExpensesHistory" class="table" style="width:95%">
                      <thead>
                      </thead>
                    </table>
                </form>
               </div>

               <div class="col-md-6">
                   <form style="width:100%; background-color:e91e63; width:95%; padding:7px 0px 22px 5px; position: absolute;left: 40px;" >
                         <div class="row">
                             <div class="col-md-6">
                                 <p class="text-left">Left aligned text on all viewport sizes</p>
                             </div>
                          </div>
                    </form>
                </div>
            
            </div>
          </div>
        </body>
    </html>


<script src="jquery-3.2.1.min.js"></script>       
<script type="text/javascript" src="jquery-ui.js"></script>   
<script> 
    $(document).ready(function () {
        GetExpensesJsonData();
        $('body').on('click', 'img#iDeleteExpenses.idDeleteExp', function () {
            var deleteExpenses = {};
            deleteExpenses.ID = $(this).attr("loginid");
            manageExpensesHistory(deleteExpenses.ID);
        });

        $('body').on('click', 'img#iUpdateExpenses.iUpdateExp', function () {
            var editExpenses = {};
            editExpenses.ID = $(this).attr("loginid");
            EditExpensesHistory(editExpenses.ID);
        });

        $("#txtCalendar").datepicker();
        $("#drpFriendsType").change(function () {
            displayCheckBox();
            //var drpValue = $("#drpFriendsType").val();
            //if (drpValue == 1) {
            //    var jsonData = JSON.stringify({});
            //    $.ajax({
            //        type: "POST",
            //        url: "Expenses.aspx/getFriendsDetails",
            //        data: jsonData,
            //        contentType: "application/json; charset=utf-8",
            //        datatype: "json",
            //        success: function (data) {
            //            OnSuccess(data.d)
            //        },
            //        Error: function () {
            //            alert('Error');
            //        }
            //    });

            //    function OnSuccess(GetJSONData) {
            //        var ParseJSON = JSON.parse(GetJSONData);
            //        var sAppend = "";
            //        $("#ckFriendsName").show();
            //            $.each(ParseJSON, function (key, value) {
            //                sAppend += "<input id='ckFriendsName_" + key + "' type='checkbox' name='ctl00$head$ckFriendsName$ckFriendsName_0' class='clCheckBox' value='" + value.ID + "'><label for='ckFriendsName_" + key + "'>" + value.FirstName + "</label>";
            //            });
            //            $("#ckFriendsName").append(sAppend);
            //    }
            //}
            //function OnErrorCall(response) {
            //}
        });

        function displayCheckBox()
        {
            var drpValue = $("#drpFriendsType").val();
            if (drpValue == 1) {
                var jsonData = JSON.stringify({});
                $.ajax({
                    type: "POST",
                    url: "Expenses.aspx/getFriendsDetails",
                    data: jsonData,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        OnSuccess(data.d)
                    },
                    Error: function () {
                        alert('Error');
                    }
                });

                function OnSuccess(GetJSONData) {
                    var ParseJSON = JSON.parse(GetJSONData);
                    var sAppend = "";
                    $("#ckFriendsName").show();
                    $.each(ParseJSON, function (key, value) {
                        sAppend += "<input id='ckFriendsName_" + key + "' type='checkbox' name='ctl00$head$ckFriendsName$ckFriendsName_0' class='clCheckBox' value='" + value.ID + "'><label for='ckFriendsName_" + key + "'>" + value.FirstName + "</label>";
                    });
                    $("#ckFriendsName").append(sAppend);
                }
            }
            function OnErrorCall(response) {
            }
        }



        $('#RdNo').prop('checked', true);
        var vLength = "";
        var vCount = "";
        //GetExpensesJsonData();
        $('#upload').hide();
        $('#RdYes').change(function () {
            $('#upload').show();
            $('#RdNo').prop('checked', false);
        });

        $('#RdNo').change(function () {
            $('#upload').hide();
            $('#RdYes').prop('checked', false);
        });

        $("#upload").change(function () {
            var fileUpload = $("#upload").get(0);
            var files = fileUpload.files;
            console.log('File upload', files);
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }

            $.ajax({
                url: "FileUploader.ashx",
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function (result) { alert(result); },
                error: function (err) {
                    console.log(err)
                }
            });
        });

        $("#btnResetExpenses").click(function () {
            clearningwebelements();
        });

        //This jquery is to highlight if there is a empty field in the form
        $("#btnSubmitExpenses").click(function () {
            //GetExpensesJsonData();
            var vTextStatus = inputTypeTextBoxValidation();
            var vSelectStatus = inputTypeSelectValidation();
            var vCheckBoxStatus = inputCheckBoxValidation();
            var vCheckTextArea = inputTypeTextAreaValidation();
            var vInputFile = inputTypeFileValidation();

            if (vTextStatus == true && vSelectStatus == true && vCheckBoxStatus == true && vCheckTextArea == true && vInputFile == true)
            {  
                sendDataToInsertIntoTable();
                GetExpensesJsonData();
            }
            else
            {
                return false;
            }
        });


        function inputTypeTextBoxValidation() {
            var vStatus = true;
            $('.ExpensesForm input[type=text]').each(function () {
                var vCurrentObject = $(this)
                if ((vCurrentObject.val().trim() == null || vCurrentObject.val().trim() == "") && (vCurrentObject.attr("Req") == "true")) {
                    vCurrentObject.addClass("ErrorFound");
                    vStatus = false;
                }
            });
            return vStatus;
        }

        function inputTypeSelectValidation() {
            var vStatus = true;
            $('.ExpensesForm select').each(function () {
                var vCurrentObject = $(this)
                if ((vCurrentObject.find('option:selected').attr("value") == 0) && (vCurrentObject.attr("Req") == "true")) {
                    vCurrentObject.addClass("ErrorFound");
                    vStatus = false;
                }
            });
            return vStatus;
        }

        function inputCheckBoxValidation() {
            vStatus = true;
            var allVals = [];
            var getcheckboxLength = $('.clCheckBox:checked').length;

            if (getcheckboxLength > 0) {
                $("input[class =  clCheckBox]:checked").each(function () {
                    allVals.push($(this).next('label').text());
                });
                console.log("Checked Values:", allVals);
            }
            else {
                $('.clCheckBox').addClass("ErrorUncheckedChecboxed");
                vStatus = false;
            }
            return vStatus;
        }
        //Get the split with values from checked box

        function GetSplitWithValues() {
            vStatus = true;
            var allVals = [];
            var getcheckboxLength = $('.clCheckBox:checked').length;

            if (getcheckboxLength > 0) {
                $("input[class =  clCheckBox]:checked").each(function () {

                    allVals.push($(this).attr('value'));
                });
            }
            console.log("Checked Split with values:", allVals);
            return allVals;
        }

        //Validating the text aread empty box
        function inputTypeTextAreaValidation() {
            var vStatus = true;
            $('.ExpensesForm textarea').each(function () {
                var vCurrentObject = $(this)
                console.log("vObject", vCurrentObject);
                if ((vCurrentObject.val().trim() == null || vCurrentObject.val().trim() == "") && (vCurrentObject.attr("Req") == "true")) {
                    console.log("If condition true");
                    vCurrentObject.addClass("ErrorFound");
                    vStatus = false;
                }
            });
            return vStatus;
        }

        function sendDataToInsertIntoTable() {
            var GetSplitedValue = GetSplitWithValues();
            GetSplitedValue = GetSplitedValue.toString();
            var ExpensesDetails = {};
            var SessionName = "<%:Session["sesUserName"].ToString()%>";
            SessionName = SessionName.split(' ');
            ExpensesDetails.ExpensesDate = $("#txtCalendar").val();
            ExpensesDetails.FriendsType = $("#drpFriendsType").find('option:selected').text();
            ExpensesDetails.ExpensesAmount = $("#txtEnterAmount").val();
            ExpensesDetails.Comments = $("#txtComments").val();
            ExpensesDetails.FirstName = SessionName[0];
            ExpensesDetails.LastName = SessionName[1];
            ExpensesDetails.Bills = $("#upload").val();
            ExpensesDetails.SplitWith = GetSplitedValue;
            console.log("Image Value inside Insert into Table", $("#upload").val());
            console.log("First name and Last Name:", ExpensesDetails);

            var jsonData = JSON.stringify({ ExpensesDetails: ExpensesDetails });
            $.ajax({
                type: "POST",
                url: "Expenses.aspx/cInsertExpenses",
                data: jsonData,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: OnSuccess,
                Error: OnErrorCall
            });

            function OnSuccess(response) {
                var result = response.d;
                console.log(result)
                if (result == "Success") {
                    //clearTextBoxes();
                }
            }
            function OnErrorCall(response) {

            }
        }

        function GetExpensesJsonData() {
            var jsonData = JSON.stringify({});
            $.ajax({
                type: "POST",
                url: "Expenses.aspx/getExpensesHistory",
                data: jsonData,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    $("#tblExpensesHistory > tr").remove();
                    OnSuccessBindExpensesHistory(data.d)
                    clearningwebelements();
                },
                Error: function () {
                    alert("Json Return failure");
                    alert('Error');
                }
            });
        }

        function OnSuccessBindExpensesHistory(GetJSONData) {

            //if (GetJSONData.length <2)
            //{   alert("Inside Json Data");
            //    $("#tblExpensesHistory").hide();
            //}
            var ParseJSON = JSON.parse(GetJSONData);
            var sAppend = '';
            sAppend += "<tr> <th scope=col >Sl No</th> <th scope= col >Date</th>  <th scope=col>Added User First Name</th> <th scope=col>Added User Last Name</th> <th scope=col>Expense Amount</th>";
            sAppend+=  "<th scope= col >Split With</th> <th scope=col>Comments</th> <th scope=col>Modified On</th> <th scope=col>View Bill</th> <th scope=col>Action</th> </tr>";
                 
            $.each(ParseJSON, function (key, value) {
                sAppend += "<tr>";
                sAppend += "<td Sl No ='" + key + "'>" + parseInt(key +1)  + "</td>";
                sAppend += "<td Date ='" + key + "'>" + value.AddedOnDate + "</td>";
                sAppend += "<td Added User First Name ='" + key + "'>" + value.AddedUserFirstName + "</td>";
                sAppend += "<td Added User Last Name ='" + key + "'>" + value.AddedUserLastName + "</td>";
                sAppend += "<td Expenses Amount='" + key + "'>" + value.expensesAmount + "</td>";
                sAppend += "<td Split With ='" + key + "'>" + value.SplitWith + "</td>";
                sAppend += "<td Comments='" + key + "'>" + value.Comments + "</td>";
                sAppend += "<td Modified On ='" + key + "'>" + value.AddedOnDate + "</td>";
                sAppend += '<td><a href=javascript:; id=btnDelete><img id=iDeleteExpenses  LoginID=' + value.ID + ' class= idDeleteExp src=/images/Delete.png width=20px height=20px/></td></a>';
                sAppend += '<td><a href= javascript:; id=btnEdit><img id=iUpdateExpenses LoginID=' + value.ID + ' class= iUpdateExp src=/images/edit.png width=20px height=20px/></td></a>';
                sAppend += "</tr>";
            });
            $("#tblExpensesHistory").append(sAppend);
        }
        

        function inputTypeFileValidation() {
            var vStatus = true;
            $('.ExpensesForm input[type=file]').each(function () {
                var vCurrentObject = $(this)
                if ((vCurrentObject.val().trim() == null || vCurrentObject.val().trim() == "") && (vCurrentObject.attr("Req") == "true")) {
                    vCurrentObject.addClass("ErrorFound");
                    vStatus = false;
                }
            });
            return vStatus;
        }

        function manageExpensesHistory(getID) {          
            var r = confirm("Do you want to delete this Expenses ?");
            if (r == true)
            {
                txt = "Yes";                
                var deleteExpenses = {};
                deleteExpenses.ID = getID;
                var jsonData = JSON.stringify({ deleteExpenses: deleteExpenses });
                $.ajax({
                    type: "POST",
                    url: "Expenses.aspx/cdeleteExpenses",
                    data: jsonData,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        $("#tblExpensesHistory > tr").remove();
                        OnSuccessBindExpensesHistory(data.d);                    
                    },
                    Error: function () {
                        alert("Json Return failure");
                        alert('Error');
                    }
                });                  
                 
            }
            else
            {
                txt = "No";
                return false;
            }
        };

        function  EditExpensesHistory(editExpenses)
        {
            
            var editexpenses = {};
            editexpenses.ID = editExpenses;
            console.log("ID:",editexpenses.ID);
            var jsonData = JSON.stringify({ editexpenses: editexpenses });
            $.ajax({
                type: "POST",
                url: "Expenses.aspx/cEditExpenses",
                data: jsonData,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function OnSuccess(data) {
                    
                    var ParseJSON = JSON.parse(data.d);
                    var sAppend = "";
                    $(window).scrollTop(0);
                    $.each(ParseJSON, function (key, value) {
                        console.log("Json Data:", value);
                        $("#txtCalendar").val(value.AddedOn);
                        $("#txtEnterAmount").val(value.ExpenseAmount);
                        $("#txtComments").val(value.Comments);
                        console.log("Roommates:", value.FriendsType);
                        if((value.FriendsType).toString() == 'Roommates')
                        {
                            $("#drpFriendsType").val('1');
                            $('#ckFriendsName').show();
                            displayCheckBox();
                        }
                        else
                        {
                            $("#drpFriendsType").val('0');
                        }
                        //sAppend += "<input id='txtCalendar_" + key + "' type='textbox' name='ctl00$head$txtCalendar' class='DatePicker hasDatepicker' value='" + value.AddedOn + "'>";
                    });              
                },
                Error: function () {
                    alert("Json Return failure");
                    alert('Error');
                }
        }); 
    }
            
    }); 
        </script>
 </asp:content>
