
function clearningwebelements()
{
    clearTextBoxes();
    clearMultiTextboxes();
    clearDropDowns();
    UnCheckCheckbox();
function clearTextBoxes() {
        $('#form1 input[type=text]').each(function () {
        var vCurrentObject = $(this)
        vCurrentObject.val("");       
        });
}

function clearMultiTextboxes() {
    $('.ExpensesForm textarea').each(function () {
        var vCurrentObject = $(this)
        vCurrentObject.val("");
    });
}

function clearDropDowns() {
    $('.ExpensesForm select').each(function () {
        var vCurrentObject = $(this)
        vCurrentObject.val(0);
    });
}

    function UnCheckCheckbox() {
    $('.clCheckBox').each(function () {
        if($(this).is(':checked') == true)
        {
            $(this).prop('checked',false)
        }
    });
    $('#ckFriendsName').hide();
   }
}



