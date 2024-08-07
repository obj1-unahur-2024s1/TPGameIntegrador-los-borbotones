import elementos.*
import fondos.*
import wollok.game.*
import level1.*
import level2.*

object juego {
	
	method play(){
	
		self.configurarPantalla()
		self.mostrarSelecLevel()
		self.iniciarSonido()
		self.encendiendoMotores()
		game.start()
	}
	
	method configurarPantalla(){
		//titulo
		game.title("ROAD FIGHTERS")
		// límites del tablero de juego
    	game.width(14)                          // le damos ancho al tablero
		game.height(8)							// le damos alto al tablero
		
	}
	method mostrarSelecLevel(){
		
		game.addVisual(fondo)       			// agrega object pantalla Inicial como fondo al tablero
		game.addVisual(mano)
		//asignamos teclas para mover la mano en el tablero
		keyboard.up().onPressDo{mano.moverseArriba()}
		keyboard.down().onPressDo{mano.moverseAbajo()}
		//asignamos level 1 0 2 segun la posicion de mano
		keyboard.enter().onPressDo{ 
			
			if (mano.level()==1) level1.configurarPantallaLevel1() else level2.configurarPantallaLevel2()
		}
	}
	
	method iniciarSonido(){
		game.schedule( 500, { game.sound("audioInicio.mp3").play() } )
	}
	
	//usamos como sonido de fondo al motor del auto. Al que pausamos cada vez que se termina el juego y reanudamos cada vez que comienza.

	method encendiendoMotores(){ game.schedule(500, {motor.inicializar()}) }
}
