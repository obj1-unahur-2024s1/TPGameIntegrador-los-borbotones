import wollok.game.*
import elementos.*
import auto.*
import vehiculos.*
import fondos.*


object level2{
	
	method configurarPantallaLevel2(){
		//sacamos el object mano
		game.removeVisual(mano)
		//configuramos fondo del juego en level 2
		fondo.cambiarFondo("fondoLevel2.png")
		
    	// Iniciamos los personajes de level2
		//self.posicionarAutosEnemigos()
		//self.posicionarElementos()
		// Iniciamos personajes de ambos level
		//self.posicionarAuto()
		//self.posicionarBanderas()
		
		//self.iniciarFuel()
		
	}
}