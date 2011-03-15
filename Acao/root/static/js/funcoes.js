jQuery(document).ready(function() {

	//$("table tbody tr:nth-child(even)").addClass("striped");

});

function createInput(name) {
    var labelText = name.split('.');
    
    var frag = document.createDocumentFragment();
    var dt = document.createElement('dt');
    var dd = document.createElement('dd');
    var newLabel = document.createElement('label');

    newLabel.innerHTML = labelText[1];
    newLabel.htmlFor = name;
    
    dt.appendChild(newLabel);
    
    var newInput = document.createElement('input');
    newInput.type = 'text';
    newInput.name = name;
    newInput.id = name;

    dd.appendChild(newInput);
    frag.appendChild(dt);
    frag.appendChild(dd);
    
    document.getElementById('form').appendChild(frag);
}

