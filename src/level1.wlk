import wollok.game.*
import elementos.*
import auto.*
import vehiculos.*
import fondos.*
import score.*

object level1 {
	
	//instancias de vehiculos enemigos para el level 1
	const enemigo1 = new AutoRojo( position = game.at(4,6))
	const enemigo2 = new Camion( position = game.at(3,7))
	const enemigo3 = new AutoAmarillo( position = game.at(6,5))
	const enemigo4 = new AutoAzul( position = game.at(8,3))
	const enemigo5 = new AutoAzul( position = game.at(8,4))
	//coleccion de los vehiculos enemigos
	const autosEnemigos = [enemigo1, enemigo2, enemigo3, enemigo4, enemigo5]
	//instancias de elementos en pantalla del level 1
	const elemento1 = new Arbusto(velocidad= 300, position = game.at(9,7))
	const elemento2 = new Arbusto(velocidad= 300, position = game.at(10,5))
	const elemento3 = new Arbusto(velocidad= 300, position = game.at(9,3))
	const elemento4 = new Arbusto(velocidad= 300, position = game.at(1,2))
	const elemento5 = new Arbusto(velocidad= 300, position = game.at(2,7))
	const elemento6 = new Super(velocidad= 200, position = game.at(1,8))
	const fuel1 = new Fuel(velocidad= 300, position = game.at(5,8))
	const fuel2 = new Fuel(velocidad= 300, position = game.at(7,8))
	//coleccion de elementos del level 1
	const elementos = [elemento1, elemento2, elemento3, elemento4, elemento5, elemento6]
	//instancias de banderas de referencia ambos level
	const bandera1 = new Bandera(image= "banderaLargada.png", position = game.at(0,0))
	const bandera2 = new Bandera(image= "banderaLlegada.png", position = game.at(0,7))
	
	method posicionarReferencia(){
		game.addVisual(referencia)
		referencia.iniciar()
		referencia.mostrarCuandoLlega()
	}
	method posicionarAutosEnemigos(){
		autosEnemigos.forEach{enemigo => game.addVisual(enemigo)}
	}
	method iniciarAutosEnemigos(){
		game.schedule(3000, {autosEnemigos.forEach{enemigo => enemigo.iniciar()}})
	}
	method pararVehiculos(){
		autosEnemigos.forEach{enemigo => enemigo.parar()}
	}
	method borrarVehiculos(){
		autosEnemigos.forEach{enemigo => game.removeVisual(enemigo)}
	}
		
	method posicionarElementos(){
		elementos.forEach{elemento => game.addVisual(elemento)}
	}
	method iniciarElementos(){	
		game.schedule(3000, {elementos.forEach{elemento => elemento.iniciar()}})
	}
	method pararElementos(){
		elementos.forEach{elemento => elemento.parar()}
	}
	method borrarElementos(){
		elementos.forEach{elemento => game.removeVisual(elemento)}	
	}
	
	method posicionarAuto(){
		game.addVisual(auto)
		auto.posicionarVidas()
		//asignamos teclas para mover al auto en el tablero
		game.schedule(3000,{
			keyboard.right().onPressDo{if(auto.estaEnRuta())auto.moverseALaDerecha() else auto.volverARuta()}
			keyboard.left().onPressDo{if(auto.estaEnRuta())auto.moverseALaIzquierda() else auto.volverARuta()}
			auto.encenderMotor()
		})
		
		game.onCollideDo(auto,{vehiculo => vehiculo.chocar()})
	}
	
	method posicionarBanderas(){
		game.addVisual(bandera1)
		game.addVisual(bandera2)
	}
	
	//Los sonidos cuando empieza la carrera
	method audioLargada(){
		game.sound("largada1.mp3").play()
		game.schedule(1000, {game.sound("largada1.mp3").play()})
		game.schedule(2000, {game.sound("largada1.mp3").play()})
		game.schedule(3000, {game.sound("largada2.mp3").play()})
	}
	
	method cargasDeCombustible(){
		game.addVisual(fuel1)
		game.addVisual(fuel2)
		fuel1.inicializar(5,8)
		fuel2.inicializar(7,8)
		game.schedule(10000, { fuel1.iniciar() })
		game.schedule(15000, { fuel2.iniciar() })
	}
	
	method configurarPantallaLevel1(){
		//sacamos el object mano
		game.removeVisual(mano)
		//configuramos fondo del juego en level 1
		fondo.cambiarFondo("fondoLevel1.png")
		// Iniciamos personajes de ambos level
		referencia.reiniciar()
		self.posicionarAuto()
		self.posicionarBanderas()
		auto.cargarVidas()
		//self.iniciarFuel()
		game.schedule(3000, { score.iniciar() } )
		self.audioLargada()
    	// Iniciamos los personajes de level1
		self.posicionarAutosEnemigos()
		self.iniciarAutosEnemigos()
		self.posicionarElementos()
		self.iniciarElementos()
		self.posicionarReferencia()
		self.cargasDeCombustible()
		
	}
}