import wollok.game.*
import elementos.*
import auto.*
import vehiculos.*
import fondos.*
import level1.*
import score.*


object level2{
	
	//instancias de vehiculos enemigos para el level 2
	
	const enemigo1 = new AutoRojo( position = game.at(4,6))
	const enemigo2 = new AutoRojo( position = game.at(5,1))
	const enemigo3 = new Camion( position = game.at(3,7))
	const enemigo4 = new Camion( position = game.at(4,2))
	const enemigo5 = new AutoAmarillo( position = game.at(6,5))
	const enemigo6 = new AutoAmarillo( position = game.at(7,5))
	const enemigo7 = new AutoAzul( position = game.at(8,3))
	const enemigo8 = new AutoAzul( position = game.at(8,4))
	const enemigo9 = new AutoAzul( position = game.at(7,4))
	
	//coleccion de los vehiculos enemigos level2
	
	const autosEnemigos = [enemigo1, enemigo2, enemigo3, enemigo4, enemigo5, enemigo6, enemigo7, enemigo8, enemigo9]
	
	//instancias de elementos en pantalla del level 2
	
	const elemento1 = new Piedra(velocidad= 300, position = game.at(9,7))
	const elemento2 = new Piedra(velocidad= 300, position = game.at(10,5))
	const elemento3 = new Piedra(velocidad= 300, position = game.at(9,3))
	const elemento4 = new Piedra(velocidad= 300, position = game.at(1,2))
	const elemento5 = new Piedra(velocidad= 300, position = game.at(2,7))
	
	//coleccion de elementos del level 2
	
	const elementos = [elemento1, elemento2, elemento3, elemento4, elemento5]
	
	method posicionarAutosEnemigos(){
		autosEnemigos.forEach{enemigo => game.addVisual(enemigo)}
	}
	method iniciarAutosEnemigos(){
		game.schedule(3000, { autosEnemigos.forEach{ enemigo => enemigo.iniciar() } })
	}
	method pararVehiculos(){
		autosEnemigos.forEach{ enemigo => enemigo.parar() }
	}
	method borrarVehiculos(){
		autosEnemigos.forEach{enemigo => game.removeVisual(enemigo)}
	}
	method posicionarElementos(){
		elementos.forEach{elemento => game.addVisual(elemento)}
	}
	method iniciarElementos(){	
		game.schedule(3000, { elementos.forEach{elemento => elemento.iniciar() } })
	}
	method pararElementos(){
		elementos.forEach{ elemento => elemento.parar() }
	}
	
	method configurarPantallaLevel2(){
		//sacamos el object mano
		
		game.removeVisual(mano)
		
		//configuramos fondo del juego en level 2
		
		fondo.cambiarFondo("fondoLevel2.png")
		
    	// Iniciamos los personajes de level2
    	
		self.posicionarAutosEnemigos()
		self.iniciarAutosEnemigos()
		
		//self.posicionarElementos()
		
		self.posicionarElementos()
		self.iniciarElementos()
		
		// Iniciamos personajes que comparten ambos level
		
		level1.posicionarAuto()
		level1.posicionarBanderas()
		level1.posicionarReferencia()
    	referencia.reiniciar()
		game.schedule(3000, { score.iniciar() } )
		level1.audioLargada()
		level1.cargasDeCombustible()	
	}
	
	method posicionarAuto(){
		auto.nuevaPosition(3,1)
		game.addVisual(auto)
		game.schedule(3000,{
			keyboard.right().onPressDo{if(auto.estaEnRuta())auto.moverseALaDerecha() else auto.volverARuta()}
			keyboard.left().onPressDo{if(auto.estaEnRuta())auto.moverseALaIzquierda() else auto.volverARuta()}
			auto.encenderMotor()
		})
		
		game.onCollideDo(auto,{vehiculo => vehiculo.chocar()})
	}
}