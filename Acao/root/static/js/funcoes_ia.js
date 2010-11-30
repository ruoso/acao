jQuery(document).ready(function() {

//http://tablesorter.com/
//$("#volumetable").tablesorter();


//grid.columnsizing
try{
alert($("#volumetable").columnSizing(
	{
				viewResize : true, 
				viewGhost : true
				}
);
}catch(e){alert(e)};

/*
try{
$("#volumetable")
			.columnSizing({
				viewResize : true, 
				viewGhost : true
				})
			.end();
}catch(e){alert(e)};


/*$("#volumetable").columnSizing({
				viewResize : false, 
				viewGhost : false, 
				selectCells : "tr:first>*:not(:first)"
				})
			.end()
*/



/*Ingrid
	$("#volumetable").ingrid({ 
			height: 350,

sorting: false,
			paging: true
		});

			/*Usando FlexiGrid
			$("#volumetable").flexigrid
			(
			{
			colModel : [
				{display: 'Volume', name : 'Volume', align: 'center'},
				{display: 'Criação', name : 'Criação', align: 'left'},

				{display: 'Fechamento', name : 'Fechamento', hide: false},
				{display: 'Arquivamento', name : 'Arquivamento', sortable : true, align: 'right'},
				{display: 'Estado', name : 'Estado', sortable : false, align: 'right'},
				{display: 'Classificação', name : 'Classificação', sortable : false, align: 'right'},
				{display: 'Localização', name : 'Localização', sortable : false, align: 'right'},
				{display: 'Vol. Físico', name : 'Vol. Físico', sortable : false, align: 'right'},
				{display: 'Ação', name : 'Ação', sortable : false, align: 'right'},

				]
			}
			);		
		*/

									

});
