
contract ethSend {
	constructor() payable {} // Si no esta marcada con payable, la funcion no puede recivir
    // fondos al momento de inicializar el contrato
    // Y como accedemos a esos fondos?
	receive() external payable {} 


// Eventos
	event SendStatus(bool);
	event CallStatus(bool, bytes);
// Transfer
	function sendViaTransfer(address payable _to) public payable{
	// Lo que hacemos es usar la palabra de payable para indicar
	// que la funcion se va a usar para transferir eth
	_to.transfer(1 ether); // Si ponemos 1 estamos enviando 1 unidad de gas, para enviar un ehter hay que poner 1 ehter


	}

// Send
	function sendViaSend(address payable _to) public payable {
		bool sent = _to.send(1 ether);
		emit SendStatus(sent);
		require(sent == true, "El envio ha fallado"); // si no es true, cortamos la ejecucion
	}

//  Call
	function sendViaCall(address payable _to) public payable {
	// Mediante call llamos a data para  
		(bool success, bytes memory data) = _to.call{ value: 1 ether }("");
		emit CallStatus(success, data);
		require(success == true, "El envio ha fallado");
		
	}

}
