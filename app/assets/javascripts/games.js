window.onload = function(){generateQuestion();}
function generateQuestion(){
	var numerator = document.getElementById('numerator');
	numerator.innerHTML = "1";
	var sign = document.getElementById('sign');
	sign.innerHTML = "*";
	var denominator = document.getElementById('denominator');
	denominator.innerHTML = "2";
}

function checkAnswer(){
	var answer = document.getElementById('input');
	if(answer.value == 2) send_stuff();
	answer.value = "";
	generateQuestion();
}
function send_stuff(){
$.ajax({
	url:'games/correct',
	type: 'POST'
	})
}
