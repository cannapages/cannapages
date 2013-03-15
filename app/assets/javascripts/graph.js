$(document).ready( function() {
		var dispensary_strains = []

		$('test').each( function(i,e){
		index = (dispensary_strains.push({}) - 1)
		current_strain = dispensary_strains[index]
		current_strain['name'] = $(e).attr('name')
		current_strain['dispensary'] = $(e).attr('dispensary')
		current_strain['thc'] = $(e).attr('thc')
		current_strain['cbd'] = $(e).attr('cbd')
		current_strain['cbn'] = $(e).attr('cbn')
		current_strain['total'] = $(e).attr('total')
		} );
		
		$.each(dispensary_strains, function(i, e){
			// Load the Visualization API and the piechart package.
		  	google.load('visualization', '1.0', {'packages':['corechart']});

		  	// Set a callback to run when the Google Visualization API is loaded.
		  	google.setOnLoadCallback(drawChart);

		  	function drawChart() {

		      	// Create the data table.

		      	var data = new google.visualization.DataTable();
		      	data.addColumn('string', 'Cannabinoid');
		      	data.addColumn('number', 'Percentage');
		      	data.addRows([
		        		['THC: '+e.thc+'%',parseInt(e.thc)],
		        		['CBD: '+e.cbd+'%',parseInt(e.cbd)],
		        		['CBN: '+e.cbn+'%',parseInt(e.cbn)],
		      	]);         

		  		// Set chart options
		      	var options = {'title': e.name,
		                     	'width':500	,
		                     	'height':300};

		      	// Instantiate and draw our chart, passing in some options.
		      	var chart = new google.visualization.PieChart(document.getElementById(i));
		      	chart.draw(data, options);
		    }

		});
	}
)