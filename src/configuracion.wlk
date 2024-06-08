import elementos.*
import fondos.*
import wollok.game.*
import level1.*
import level2.*

object juego {
	
	method play(){
	
		self.configurarPantalla()
		self.mostrarSelecLevel()
	
		game.start()
	}
	
	method configurarPantalla(){
		//titulo
		game.title("Autitos game")
		// límites del tablero de juego
		//game.cellSize(100)
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
		keyboard.enter().onPressDo{ if (mano.level()==1) level1.configurarPantallaLevel1() else level2.configurarPantallaLevel2()}
		
	}
	
	
}
