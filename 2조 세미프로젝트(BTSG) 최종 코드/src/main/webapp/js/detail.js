	
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
		$('#btn_review').show();
	})
});

$(function(){
	var review = $('.reviewList');	
	
	$(review).find('tr').each(function(idx, el){
		$(el).find('#review_con').hide();
		$(el).find('#moreview').on('click' , function(){
		$(this).siblings('#review_con').slideToggle();	
		});
	})	
});