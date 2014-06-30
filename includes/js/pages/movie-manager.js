$(document).ready(function(){
	$('#movie-list')
		.on('click', '.item', function(event){
			var parent = $(this).closest('tr');
			var id = parent.data('id');
			document.location = '/admin/movieDetail/' + id;
		})
});