/*datepicker*/
$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		changeYear: true,
		changeMonth:true,
		yearSuffix : '년'
});

$(function() {
	$('#datepicker').datepicker({
		minDate: new Date('2021-11-11'),
		maxDate: new Date('2021-12-13')
	   
	});
});
	
$(function(){

	$('.nav li').click(function(){
		var idx=$(this).index();
		$('.nav li').removeClass('on');
		$('.nav li').eq(idx).addClass('on');
		$('#prdInfo > div').hide();
		$('#prdInfo > div').eq(idx).show();
	})
	
	$('#btn a.buy').click(function(){
			location.href="goods_purchase.jsp";
	})
		
});

$(function(){
	$('#writeReview').hide();
	$('#btn_review').click(function(){
		$('#btn_review').hide();
		$('#writeReview').show();
	})
	
	$('#btn_cancel').click(function(){
		$('#writeReview').hide();
	})
});

$(function(){
	$('#review_con').hide();
	$('#moreview').click(function(){
		$('#review_con').slidedown();
	})
});