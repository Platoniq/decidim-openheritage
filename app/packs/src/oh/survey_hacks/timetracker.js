import 'clockpicker/dist/jquery-clockpicker.js';

$(document).ready(function(){
	var user = $('li>a[href="/account"]').first().text()
	$("#questionnaire_tos_agreement").prop("checked", true);

	$("label.questionnaire-question").each(function() {
		var $div = $(this).closest("div");
		var $input = $div.find('input');
		var d = new Date();
		if($(this).text().match(/name/i)) {
			$input.val(user).prop("readonly", true);
		}
		if($(this).text().match(/date/i)) {
			$input.val(d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear())
		}
		if($(this).text().match(/time/i)) {
			$input.clockpicker({
			    placement: 'bottom',
			    align: 'right',
			    autoclose: true,
			    'default': (d.getHours() + ":"  + d.getMinutes())
			});
		}
	});
});