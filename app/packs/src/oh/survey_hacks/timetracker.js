import 'clockpicker/dist/jquery-clockpicker.js';

$(document).ready(function(){
  const user = $('li>a[href="/account"]').first().text();
  $("#questionnaire_tos_agreement").prop("checked", true);

  $("label.questionnaire-question").each(function() {
    const $div = $(this).closest("div");
		const $input = $div.find('input');
    const d = new Date();
    if ($(this).text().match(/name/i)) {
      $input.val(user).prop("readonly", true);
    }
    if ($(this).text().match(/date/i)) {
      $input.val(d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear())
    }
    if ($(this).text().match(/time/i)) {
      $input.clockpicker({
        placement: 'bottom',
        align: 'right',
        autoclose: true,
        'default': (d.getHours() + ":"  + d.getMinutes())
      });
    }
  });
});
