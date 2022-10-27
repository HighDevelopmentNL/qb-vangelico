Vangelico = {}
Vangelico.Functions = {}

Vangelico.Functions.OpenPinpad = function() {
    $(".container").fadeIn(300);
}

Vangelico.Functions.ClosePinpad = function(HasPutin) {
    $(".container").fadeOut(300);
    $.post('https://qb-vangelico/PinpadClose', JSON.stringify({
        EnteredCode: HasPutin
    }))
}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27:
            Vangelico.Functions.ClosePinpad(false);
            break;
        case 49:
            Vangelico.Functions.AddNumber(1);
            break;
        case 50:
            Vangelico.Functions.AddNumber(2);
            break;
        case 51:
            Vangelico.Functions.AddNumber(3);
            break;
        case 52:
            Vangelico.Functions.AddNumber(4);
            break;
        case 53:
            Vangelico.Functions.AddNumber(5);
            break;
        case 54:
            Vangelico.Functions.AddNumber(6);
            break;
        case 55:
            Vangelico.Functions.AddNumber(7);
            break;
        case 56:
            Vangelico.Functions.AddNumber(8);
            break;
        case 57:
            Vangelico.Functions.AddNumber(9);
            break;
        case 48:
            Vangelico.Functions.AddNumber(0);
            break;
        case 13:
            var v = $("#PINbox").val();
            if (v == "") {
                $.post('https://qb-vangelico/ClickFail', JSON.stringify({}))
                $.post('https://qb-vangelico/ErrorMessage', JSON.stringify({
                    message: "Please enter the code"
                }))
            } else {
                data = {
                    pin: v
                }
                $("#PINbox").val("");
                $.post('https://qb-vangelico/Click', JSON.stringify({}))
                $.post('https://qb-vangelico/EnterPincode', JSON.stringify({
                    pin: data.pin
                }))
                Vangelico.Functions.ClosePinpad(true);
            };
            break;
    }
});

$(document).ready(function(){
    window.addEventListener('message', function(event){
        switch(event.data.action) {
            case "open":
                Vangelico.Functions.OpenPinpad(event.data);
                break;
            case "close":
                Vangelico.Functions.ClosePinpad(event.data);
                break;
        }
    });
});


$( "#PINcode" ).html(
	"<form action='' method='' name='PINform' id='PINform' autocomplete='off' draggable='true'>" +
		"<input id='PINbox' type='password' value='' name='PINbox' disabled />" +
		"<br/>" +
		"<input type='button' class='PINbutton' name='1' value='1' id='1' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton' name='2' value='2' id='2' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton' name='3' value='3' id='3' onClick=addNumber(this); />" +
		"<br>" +
		"<input type='button' class='PINbutton' name='4' value='4' id='4' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton' name='5' value='5' id='5' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton' name='6' value='6' id='6' onClick=addNumber(this); />" +
		"<br>" +
		"<input type='button' class='PINbutton' name='7' value='7' id='7' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton' name='8' value='8' id='8' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton' name='9' value='9' id='9' onClick=addNumber(this); />" +
		"<br>" +
		"<input type='button' class='PINbutton clear' name='-' value='retry' id='-' onClick=clearForm(this); />" +
		"<input type='button' class='PINbutton' name='0' value='0' id='0' onClick=addNumber(this); />" +
		"<input type='button' class='PINbutton enter' name='+' value='enter' id='+' onClick=submitForm(PINbox); />" +
	"</form>"
);

function addNumber(e){
	var v = $("#PINbox").val();
    $("#PINbox").val(v + e.value);
    $.post('https://qb-vangelico/Click', JSON.stringify({}))
}

Vangelico.Functions.AddNumber = function(num) {
	var v = $("#PINbox").val();
	$("#PINbox").val(v + num);
}

function clearForm(e){
    $.post('https://qb-vangelico/Click', JSON.stringify({}))
	$("#PINbox").val("");
}

function submitForm(e) {
	if (e.value == "") {
        $.post('https://qb-vangelico/ClickFail', JSON.stringify({}))
		$.post('https://qb-vangelico/ErrorMessage', JSON.stringify({
            message: "Vul een code in!"
        }))
	} else {
        $.post('https://qb-vangelico/Click', JSON.stringify({}))
        $.post('https://qb-vangelico/EnterPincode', JSON.stringify({
            pin: e.value
        }))
        $("#PINbox").val("");
        Vangelico.Functions.ClosePinpad(true);
	};
};