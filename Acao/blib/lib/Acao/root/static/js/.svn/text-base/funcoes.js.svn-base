jQuery(document).ready(function() {
	
	$('select.autocomplete').select_autocomplete();
	
	$('input.maskData').datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy', showOn: 'button', buttonImage: '../../template/img/calendar.png', buttonImageOnly: true
	});
	$('input.maskData').datepicker($.datepicker.regional['pt-BR']);
	
	$('input.maskMoeda').setMask({mask : '99,999.999.99', type : 'reverse', defaultValue: '000'});
	$('input.maskCnpj').setMask('cnpj');
	$('input.maskCpf').setMask('cpf');
	$('input.maskCep').setMask('cep');
	$('input.maskNumeros').setMask({mask:'9', type:'repeat'});
	$('input.maskData').setMask('date');
	$('input.maskFone').setMask('phone');
	$('input[name=txtDiasVigencia]').setMask({mask:'9', type:'repeat', maxLength:4});
	$('input[name=txtPrazoAvisoPrevio]').setMask({mask:'9', type:'repeat', maxLength:3});
	$('input:text').addClass('required');
	$('textarea').addClass('required');
	$('input.opcional').removeClass('required');
	$('textarea.opcional').removeClass('required');
	//$('input.maskData').val('00/00/0000');
	//alert($('input.maskData').val());
	//if ($('input.maskData').val.(is(":contains('')"))){ 
	//	$('input.maskData').val('00/00/0000')
	//}
		
	// Bruno: tá aqui a solução claudemirton:
	$( 'form' ).each(function( intIndex ){ $( this ).validate(); });
	
	// Script para ativar a verificacao de cpf da tela de historico
	if ( document.getElementById( 'txtCpf' ) && document.getElementById( 'nomeOriginal' ) && document.getElementById( 'contatoOriginal' ) )
		verificarAlteracaoCpf();
		
});
/*
var enMarcara = {"cep":0, "data":1, "telefone":2, "telefoneddd":3, "numero":4}; //enumerador de mascara

function Mascara (formato, campo)
{
    // teste para cep
    if (formato==enMarcara.cep)
    {
        separador = '-';
        conjunto1 = 5;
        if (campo.value.length == conjunto1)
        { campo.value = campo.value + separador; }
    }

    // teste para data
    if (formato==enMarcara.data)
    {
        separador = '/';
        conjunto1 = 2;
        conjunto2 = 5;
        if (campo.value.length == conjunto1)
        { campo.value = campo.value + separador; }
        if (campo.value.length == conjunto2)
        { campo.value = campo.value + separador; }
    }

    // teste para telefone
    if (formato==enMarcara.telefone)
    {
        separador = '-';
        conjunto = 4;
        if (campo.value.length == conjunto)
        { campo.value = campo.value + separador; }
    }

    // teste para telefone com ddd
    if (formato==enMarcara.telefoneddd)
    {
        separador1 = '(';
        separador2 = ')';
        separador3 = '-';
        conjunto1 = 1;
        conjunto2 = 3;
        conjunto3 = 8;
        if (campo.value.length == conjunto1)
        { campo.value = separador1 + campo.value; }
        if (campo.value.length == conjunto2)
        { campo.value = campo.value + separador2; }
        if (campo.value.length == conjunto3)
        { campo.value = campo.value + separador3; }
    }

}

function VerificaData(digData)
{
    var bissexto = 0;
    var data = digData;
    var tam = data.length;

    if (tam == 0)
    { return true; }

    if (tam == 10)
    {
            var dia = data.substr(0,2)
            var mes = data.substr(3,2)
            var ano = data.substr(6,4)

            if ((ano > 1900)||(ano < 2100))
            {
                switch (mes)
                {
                    case '01':
                    case '03':
                    case '05':
                    case '07':
                    case '08':
                    case '10':
                    case '12':
                        if  (dia <= 31)
                        { return true; }
                        break
                    case '04':
                    case '06':
                    case '09':
                    case '11':
                        if (dia <= 30)
                        { return true; }
                        break
                    case '02':
                        // Validando ano Bissexto  fevereiro  dia 
                        if ((ano % 4 == 0) || (ano % 100 == 0) || (ano % 400 == 0))
                        { bissexto = 1; }
                        if ((bissexto == 1) && (dia <= 29))
                        { return true; }
                        if ((bissexto != 1) && (dia <= 28))
                        { return true; }
                        break
            }
        }
    }
    alert("A Data "+data+" nao e valida!");

    return false;
}
*/

function Horas()
{
    var t;
    var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();

    var day   = now.getDate();
    var month = now.getMonth()+1;
    var year  = now.getFullYear();

    if (hours <=9)
    { hours="0"+hours; }
    if (minutes<=9)
    { minutes="0"+minutes; }
    if (seconds<=9)
    { seconds="0"+seconds; }

    if (day <=9)
    { day="0"+day; }
    if (month <=9)
    { month="0"+month; }

    var cdate=day+"/"+month+"/"+year+" "+hours+":"+minutes+":"+seconds;
    document.getElementById("clock").innerHTML = cdate;
    t = setTimeout("Horas()",1000);
}

function VerificaSelecao()
{
    var obj = document.getElementsByTagName("input");
    var cont = 0;
    for (var i=0; i < obj.length; i++) {
        if (obj[i].type == "checkbox")
        if(obj[i].checked == true) cont++;
    }
    if (cont == 0)
    { 
        alert("você deve marcar ao menos 1 checkbox.");
        return false;
    }
    if (cont > 1) 
    {
        alert("você só deve editar 1 registro de cada vez.");
        return false;
    }
    return true;
}
/*
function ValidaCamposObrigatorios(form)
{
    for (i=0;i<form.length;i++)
    {
        if (form[i].title=='*')
        {
            var nome;
            if (form[i].name.substr(0, 3) == "ddl" && form[i].value == "0")
            {
                nome = form[i].name;
                alert("O campo " + nome.substr(3) + " é obrigatório.");
                form[i].focus();
                return false;
            } else
            if (form[i].value == "")
            {
                nome = form[i].name;
                alert("O campo " + nome.substr(3) + " é obrigatório.");
                form[i].focus();
                return false;
            }
        }
    }
    return true;
}
*/
function checkedAll (id, checked)
{
    var el = document.getElementsByName(id);
    for (var i = 0; i <el.length; i++)
    { el[i].checked = checked; }
}

function verificarAlteracaoCpf(){
	var object = document.getElementById( 'txtCpf' );
	var cpf = document.getElementById( 'cpfOriginal' ).firstChild.nodeValue;
	var nome = document.getElementById( 'nomeOriginal' ).firstChild.nodeValue;
	var contato = document.getElementById( 'contatoOriginal' ).firstChild.nodeValue;
	var cpfnovo = object.value;
	if ( cpf == cpfnovo ){
		document.getElementById( 'txtNome' ).disabled = true;
		document.getElementById( 'txtContato' ).disabled = true;
		document.getElementById( 'txtNome' ).value = nome;
		document.getElementById( 'txtContato' ).value = contato;
	} else {
		document.getElementById( 'txtNome' ).disabled = false;
		document.getElementById( 'txtContato' ).disabled = false;
		document.getElementById( 'txtNome' ).value = '';
		document.getElementById( 'txtContato' ).value = '';
	}
}
/*
function validaFormAuto(form)
{
    var teste = form[0].ddlOrgaoID.value;
    alert("estou aqui" + teste);
                     for (i=0;i<form.length;i++)
                {
                    
                  if (form[i].value == "")
                  {
                    
                    if (form[i].id.length > 0)
                      {
                        var nome = form[i].name.substring(3,form[i].name.length);
                        var orgao = form[i].id;
                        alert("O campo [" + orgao + "] é necessário.");
                        form[i].focus();
                        return false
                      }
                    }

          }
    
return true
}
*/
