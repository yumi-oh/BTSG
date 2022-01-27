
$(function(){
	$('#prdInfo > div').hide();

	$('nav nav-tabs menu li').click(function(){
		var idx=$(this).index();
		$('nav nav-tabs menu li').removeClass('on');
		$('nav nav-tabs menu li').eq(idx).addClass('on');
		$('#prdInfo > div').hide();
		$('#prdInfo > div').eq(idx).show();
	});
	
	$('.detail-cont-more').click(function(){
		$('.pd_detail').slidedown();
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
	});
	
	$('#btn_cancel').click(function(){
		$('#writeReview').hide();
	})
})