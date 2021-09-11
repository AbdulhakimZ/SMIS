
function RenderActions(RenderActionstring) {
    $("#OpenDialog").load(RenderActionstring);
};

function RenderEditActions(RenderActionstring) {
    $("#EditOpenDialog").load(RenderActionstring);
};
function RenderDeleteActions(RenderActionstring) {
    $("#DeleteOpenDialog").load(RenderActionstring);
};
function Clean() {
    $('#modalCreate').find('textarea,input').val('');
};


function ValidateInputs() {
    var flag = true;
    var nameInput = $('#Name');

    if ($.trim(nameInput.val()) != '') {
        nameInput.closest('.form-group').removeClass('has-error');
        flag = true;
    }
    if ($.trim(nameInput.val()) === '') {
        nameInput.closest('.form-group').addClass('has-error');
  
        flag = false;
    }
    return flag;
};