//$('#updatePercentage').slider({});

$(document).ready(function() {
	$('#addUpdateModal').on('shown.bs.modal', function() {
		$("#updatePercent").slider({});
	});
});
