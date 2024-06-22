import wollok.game.*
import configuracion.*
import vehiculos.*
import auto.*
import fondos.*
import level1.*
import level2.*
import score.*

class Elemento {
	const velocidad = 0
	var position 
	method position()= position
		
	// definimos los metodos de indicacion
	method moverseAbajo() {
    	const altura= game.height()					//guardo en una var la altura del tablero
    	
    	if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    	else { position= game.at(position.x(), altura-1 )} 	//si Eje y es 0 le asigno al eje y la altura del tablero -1
	}
	
	 method moverseArriba() {
    	const altura= game.height()						//guardo en una var la altura del tablero
    	const nuevoY= (position.y()+1) % altura			//le sumo 1 a la posicion del eje y, y me fijo si esta en la ultima posicion le doy el valor 0 
	    position = game.at(self.position().x(), nuevoY)	//guardo en la var position la nueva posicion
    }
    
    method chocar(){
		game.say(self,"vuelve a la carretera")
	}
	method iniciar(){
		game.onTick(velocidad,"movimientoElementos",{self.moverseAbajo()})
	}
	method parar(){
		game.removeTickEvent("movimientoElementos")
	}
}

class Arbusto inherits Elemento{
	// definimos la imagen
	var image = "tree.png"
	
	const fotogramas = ["tree.png", "treeAbajo.png", "treeArriba.png"]

	method image() = image 
	
	override method moverseAbajo() {
		image = fotogramas.get(1)
    	const altura= game.height()					//guardo en una var la altura del tablero
    	game.schedule(100, 
    		{if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    		else { position= game.at(position.x(), altura-1 )} 	//si Eje y es 0 le asigno al eje y la altura del tablero -1
    		image = fotogramas.get(2) })
    	game.schedule(200, { image = fotogramas.get(0) })
	}
}

class Super inherits Elemento{
	// definimos la imagen 

	method image()= "super.png"
	
	override  method iniciar(){
		game.onTick(velocidad,"movimientoElementos",{self.moverseArriba()})
	}
}
	

class Fuel inherits Elemento{
	// definimos la imagen
	
	method image()= "vida.png"
	
	method inicializar(posicionX, posicionY){
		position = game.at(posicionX, posicionY)
	}
	
	override method moverseAbajo(){
    	
    	if (position.y() > 0) { position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    	else { if(game.hasVisual(self)) game.removeVisual(self) } 	//cuando la vida sale del tablero, se borra.
	}
	
	override method chocar(){
		auto.sumarVida()
		score.vidaObtenida()
		game.removeVisual(self)
	}
}

object bomba{
	//variables para las animaciones
	const img = ["bomba1.png", "bomba2.png","bomba3.png"]
	var property image= "bomba1.png"
	
	method position()= auto.position()
	
	method animacionBomba(){ // Animacion itera sobre la lista de imagenes y cambia el visual cada X tiempo
		game.onTick(400,"explosion",{self.image(img.get(0.randomUpTo(2)))})
	}
	//elimina la animacion
	method eliminar(tiempo,tick){
		game.schedule(tiempo, {game.removeTickEvent(tick)})		
	}
	method explotar(){
		self.animacionBomba()
		self.eliminar(4000, "explosion")
	}
}	

object gameOver {
	method position() = game.center()
	
	method text() = "GAME OVER"
}

object referencia {
	
	const velocidad = 10000
	var position = game.at(0,1)
	const image= "referencia.png"
	method position()= position
	method image()= image
	method moverseArriba() {
    	position = game.at(position.x(), position.y()+1)
  	}
	method iniciar(){
		game.onTick(velocidad,"movimientoElementos",{self.moverseArriba()})
	}
	method reiniciar(){
		position = game.at(0,1)
	}
	method mostrarCuandoLlega(){
		game.onCollideDo(self, { bandera => bandera.mostrarLlegada() } )
	}
}

class Bandera {
	var position
	var image
	
	method position()= position
	
	method image()= image
	
	method mostrarLlegada(){
		
		auto.apagarMotor()
		fondo.cambiarFondo("llegada.png")
		game.schedule(2000, {
			game.clear()
			fondo.cambiarFondo("panallaInicial1.png")
			juego.mostrarSelecLevel()
			juego.iniciarSonido()
		})
	}
}

class Vida {
	var position
	 
	method position()= position
	
	method image() = "referenciaVida.png"
	
	method iniciar(){game.addVisual(self)}
	
	method quitar(){game.removeVisual(self)}
}

object mano {
	var position= game.at(5,2)
	var level= 1
	
	method image()= "selecInicial.png"
	method position()= position
	method level()= level
	
	method moverseArriba(){
		position= game.at(5,2)
		level= 1
	}
	method moverseAbajo(){
		position= game.at(5,1)
		level= 2
	}
}

object motor{
	const sonido = game.sound("motor.mp3")
	
	method inicializar(){
		sonido.shouldLoop(true)
		sonido.volume(0.3)
		sonido.play()
		sonido.pause()
	}
	
	method encender(){ sonido.resume() }
	
	method apagar() { sonido.pause() }
}


object pepita{
	var position= game.at(3,6)
	
	method position()= position
	method image()= "pepita.png"
	
	method moverseALaDerecha(){
    	const ancho= game.width()					//guardo en una const el ancho del tablero
    	const nuevoX= (position.x()+1) % ancho	//le sumo 1 a la posicion del eje X, y me fijo si esta en la ultima posicion le doy el valor 0 
	    position = game.at(nuevoX, self.position().y())	//guardo en la var position la nueva posicion
    }
    method salir(){
    	game.addVisual(self)
    		game.schedule(300, {game.say(self, "GANASTE")})
    		game.schedule(300, {self.moverseALaDerecha()})
    }
}