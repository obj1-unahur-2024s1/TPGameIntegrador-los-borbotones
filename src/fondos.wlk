import wollok.game.*

//se crea object fondo para poder cambiarlo durante el juego
object fondo {
	var fondo= "panallaInicial1.png"
	
	method position()= game.origin()
	method image()= fondo
	// metodo para cambiar imagen de fondo
	method cambiarFondo(nuevo){
		fondo= nuevo
	}
	method mostrarLlegada(){}
}

