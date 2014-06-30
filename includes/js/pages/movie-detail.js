$(document).ready(function(){
	$('.update, .path-input').hide();
	$(document)
		.on('click', '#search', function(event){
			if(!$('#search_term').val().length) return;
			$.ajax({
				url: '/admin/movieSearch',
				type: 'post',
				data: {search_term: $('#search_term').val()},
				cache: false,
				success: function(data){
					$('#ajax').html(data);
				}
			});
		})
		.on('click', '.rename', function(event){
			$('.update, .path-input').show();
			$('.path-text, .rename').hide();
		})
		.on('click', '.update-cancel', function(event){
			$('.update, .path-input').hide();
			$('.path-text, .rename').show();
		})
		.on('click', '.update-confirm', function(event){
			var oldPath = $('.path-text').html();
			var newPath = $('#new-path').val();
			$.ajax({
				url: '/admin/renamePath',
				type: 'post',
				data: {
					oldPath: oldPath,
					newPath: newPath
				},
				cache: false,
				success: function(data){
					if(data.success) document.location = 'admin/movies';
					alert('Error updating directory');
				}
			});
		})
})