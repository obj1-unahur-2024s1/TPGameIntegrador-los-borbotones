import wollok.game.*
import elementos.*
import auto.*
import vehiculos.*
import fondos.*
import level1.*
import score.*


object level2{
	
	//instancias de vehiculos enemigos para el level 2
	
	//coleccion de los vehiculos enemigos level2
	
	
	//instancias de elementos en pantalla del level 2
	
	//coleccion de elementos del level 2
	
	
	method iniciarSiPasoDeLevel1(){
		//configuramos fondo del juego en level 2
		fondo.cambiarFondo("fondoLevel2.png")
		game.removeVisual(pepita)
    	// Iniciamos los personajes de level2
		//self.posicionarAutosEnemigos()
		//self.posicionarElementos()
		
		// Iniciamos personajes que comparten ambos level
		game.removeVisual(auto)
		self.posicionarAuto()
		level1.audioLargada()
		referencia.reiniciar()
		//self.iniciarFuel()
		
	}
	method configurarPantallaLevel2(){
		//sacamos el object mano
		game.removeVisual(mano)
		//configuramos fondo del juego en level 2
		fondo.cambiarFondo("fondoLevel2.png")
		
    	// Iniciamos los personajes de level2
    	
		//self.posicionarAutosEnemigos()
		//self.posicionarElementos()
		
		// Iniciamos personajes que comparten ambos level
		level1.posicionarAuto()
		level1.posicionarBanderas()
		level1.posicionarReferencia()
    	referencia.reiniciar()
		score.iniciar()
		level1.audioLargada()
		//self.iniciarFuel()
		
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