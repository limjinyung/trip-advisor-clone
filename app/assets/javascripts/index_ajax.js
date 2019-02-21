
$(document).on('turbolinks:load', function(){
	$("#search-field").on("keyup", function(){
			autocomplete()
		});

		function autocomplete(){
			var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
			const data = {query: document.getElementById("search-field").value, authenticity_token: AUTH_TOKEN}
			$.ajax({
				url: '/search',
				method: 'POST',
				data: data,
				dataType: 'json',
				error: function(){
					console.log("Bug!!!");
				},
				success: function(data){
					$("#list").html("");

					data.forEach(function(element){
						var option = document.createElement("option");
						option.value = element;

						$("#list").append(option)
					});
				}
			});
		}
})