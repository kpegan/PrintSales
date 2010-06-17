$(document).ready(function() {
   // do stuff when DOM is ready
   $("#new_job input").change(function() {
   	calculatePrice();
   });
});

function calculatePrice() {
	var p_area = $("#job_paper_width").val() * $("#job_paper_height").val() / 144; 
	var i_area = $("#job_image_width").val() * $("#job_image_height").val() / 144;

	
	p_price = parseFloat($("#paper_price").text().replace(/\$/i,""));
	i_price = parseFloat($("#ink_price").text().replace(/\$/i,""));
	p_cost = p_area * p_price;
	i_cost = i_area * i_price;
	print_cost = p_cost + i_cost;
	total = $("#job_quantity").val() * print_cost;
	
	$("#paper_area").text(p_area.toFixed(2) + " sq. ft.");
	$("#image_area").text(i_area.toFixed(2) + " sq. ft.");
	$("#paper_cost").text("$" + p_cost.toFixed(2));
	$("#ink_cost").text("$" + i_cost.toFixed(2));
	$("#print_cost").text("$" + print_cost.toFixed(2));
	$("#total").text("$" + total.toFixed(2));
}