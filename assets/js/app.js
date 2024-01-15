
jQuery(document).ready(function($) {

	FastClick.attach(document.body);

	$('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
		event.preventDefault(); 
		event.stopPropagation(); 
		$(this).parent().siblings().removeClass('open');
		$(this).parent().toggleClass('open');
	});

	$('.inputs').keydown(function (e) {
	     if (e.which === 13) {
	         var index = $('.inputs').index(this) + 1;
	         $('.inputs').eq(index).focus();
	     }
	 });
});

function setInt(selector) {
	return $(selector).maskMoney({precision: 0});
}