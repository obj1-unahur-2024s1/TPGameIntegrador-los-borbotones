import elementos.*
import vehiculos.*
import auto.*
import wollok.game.*

object juego {
	
	method play(){
	
		self.configurarPantalla()
	
		game.start()
	}
	
	method configurarPantalla(){
		
		game.title("Autitos game")
		// límites del tablero de juego
		//game.cellSize(100)
    	game.width(14)                          // le damos ancho al tablero
		game.height(8)							// le damos alto al tablero
		// fondo
		game.boardGround("fondo.png")       		// agrega imagen de fondo al tablero
		
    	// Iniciamos los personajes
		self.posicionarAutosEnemigos()
		self.posicionarElementos()
		self.posicionarAuto()
		self.posicionarBanderas()
		
	}
	
	method posicionarAutosEnemigos(){
		
		const enemigo1 = new AutoRojo( position = game.at(4,6))
		const enemigo2 = new Camion( position = game.at(3,7))
		const enemigo3 = new AutoAmarillo( position = game.at(6,5))
		const enemigo4 = new AutoAzul( position = game.at(8,3))
		const enemigo5 = new AutoAzul( position = game.at(8,4))
		
		const autosEnemigos = [enemigo1, enemigo2, enemigo3, enemigo4, enemigo5]
		
		autosEnemigos.forEach{enemigo => game.addVisual(enemigo)}
		autosEnemigos.forEach{enemigo => enemigo.iniciar()}
	}
		
	method posicionarElementos(){
		const elemento1 = new Arbusto(velocidad= 300, position = game.at(9,7))
		const elemento2 = new Arbusto(velocidad= 300, position = game.at(10,5))
		const elemento3 = new Arbusto(velocidad= 300, position = game.at(9,3))
		const elemento4 = new Arbusto(velocidad= 300, position = game.at(1,2))
		const elemento5 = new Arbusto(velocidad= 300, position = game.at(2,7))
		const elemento6 = new Super(velocidad= 200, position = game.at(1,8))
		const elemento7 = new Referencia(velocidad= 6000, position = game.at(0,1))
		const elemento8 = new Fuel(velocidad= 300, position = game.at(5,8))
		const vida1 = new Vida (velocidad = 0,position= game.at(2,10))
		const vida2 = new Vida (velocidad = 0,position= game.at(2,11))
		const vida3 = new Vida (velocidad = 0,position= game.at(2,12))
		
		const elementos = [elemento1, elemento2, elemento3, elemento4, elemento5, elemento6, elemento7, elemento8]
		const vidas = [vida1, vida2, vida3]
		
		elementos.forEach{elemento => game.addVisual(elemento)}
		elementos.forEach{elemento => elemento.iniciar()}
		vidas.forEach{vida => game.addVisual(vida)}
		//elemento7.mostrarLlegada()
	}
	
	method posicionarAuto(){
		
		game.addVisual(auto)
		//asignamos teclas para mover al auto en el tablero
		keyboard.right().onPressDo{auto.moverseALaDerecha()}
		keyboard.left().onPressDo{auto.moverseALaIzquierda()}
		//keyboard.up().onPressDo{auto.moverseArriba()}
		//keyboard.down().onPressDo{auto.moverseAbajo()}
		
		game.onCollideDo(auto,{vehiculo => vehiculo.chocar()})
	}
	
	method posicionarBanderas(){
		const bandera1 = new Bandera(image= "banderaLargada.png", position = game.at(0,0))
		const bandera2 = new Bandera(image= "banderaLlegada.png", position = game.at(0,7))
		game.addVisual(bandera1)
		game.addVisual(bandera2)
	}
	
}
