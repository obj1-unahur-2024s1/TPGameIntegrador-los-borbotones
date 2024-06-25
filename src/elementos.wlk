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

// Arbusto, Piedra y Super son elementos decorativos.

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

class Piedra inherits Elemento {
	var image = "piedras.png"
	
	const fotogramas = ["piedras.png", "piedrasAbajo.png", "piedrasArriba.png"]

	method image() = image 
	
	override method moverseAbajo() {
		image = fotogramas.get(1)
    	const altura= game.height()					
    	game.schedule(100, 
    		{if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }
    		else { position= game.at(position.x(), altura-1 )}
    		image = fotogramas.get(2) })
    	game.schedule(200, { image = fotogramas.get(0) })
	}
}

class Super inherits Elemento{
	// definimos la imagen 

	method image()= "super.png"
	
	override  method iniciar(){
		game.onTick(velocidad,"movimientoSuper",{self.moverseArriba()})
	}
}
	
// Los al "chocar" fuels cargamos una vida y combustible. Es necesario hacerlo aunque tengamos todas las vidas para ganar.

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
		game.sound("vida.mp3").play()
		score.vidaObtenida()
		game.removeVisual(self)
		medidorFuel.reiniciar()
	}
}

// Cuando perdés, el auto explota y lo representamos con esto.

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

// Mensaje que sale cuando perdés.

object gameOver {
	method position() = game.center()
	
	method text() = "GAME OVER"
}

// Objeto que muestra cuánto falta para terminar la carrera.

object referencia {
	
	const velocidad = 8000
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

// Bandera utilizada para poder ganar el juego. Cuando la referencia "choca" la bandera, ganás.

class Bandera {
	var position
	var image
	
	method position()= position
	
	method image()= image
	
	method mostrarLlegada(){
		
		score.parar()
		game.sound("win.mp3").play()
		if (fondo.image() == "fondoLevel1.png")
			{fondo.cambiarFondo("llegada.png")
			level1.pararVehiculos()
			level1.pararElementos()
			auto.apagarMotor()
			self.pasarDeLevel()}
			
		else {
			fondo.cambiarFondo("llegada2.png")
			level2.pararVehiculos()
			level2.pararElementos()
			auto.apagarMotor()
			self.volverAlInicio()}
		
	}
	
	method volverAlInicio(){
		game.schedule(7000, {
			game.clear()
			fondo.cambiarFondo("panallaInicial1.png")
			juego.mostrarSelecLevel()
			juego.iniciarSonido()
		})
	}
	
	method pasarDeLevel(){ game.schedule(7000, {
		game.clear()
		game.addVisual(fondo)
		level2.configurarPantallaLevel2()})
	}
}

// La imagen que representa la cantidad de vidas restante.

class Vida {
	var position
	 
	method position()= position
	
	method image() = "referenciaVida.png"
	
	method iniciar(){game.addVisual(self)}
	
	method quitar(){game.removeVisual(self)}
}

// La mano selectora de niveles.

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

// El sonido del motor cuando comienza la carrera.

object motor{
	const sonido = game.sound("motor.mp3")
	
	method inicializar(){
		sonido.shouldLoop(true)
		sonido.play()
		sonido.volume(0)
	}
	
	method encender(){ sonido.volume(0.3) }
	
	method apagar() { sonido.volume(0) }
}

// Una manera de perder es quedarse sin combustible. Cuando medidorFuel llega a 0, game over.

object medidorFuel{
	var image = "barraNafta5.png"
	const img= ["barraNafta5.png", "barraNafta4.png", "barraNafta3.png", "barraNafta2.png", "barraNafta1.png", "barraNafta0.png"]
	
	method image()= image
	method position()= game.at(12,2)
	
	method image(nueva){ image= nueva}
	method animacionFuel(){
		var i= 0
		// si el nivel de fuel llega a 0 se detiene el juego. Se podria agregar una pantalla game over.
		game.onTick(6000,"bajaFuel",{self.image(img.get(i%6)) i+=1 if (self.noHayNafta()) auto.perder()})	
	}
	method noHayNafta()= self.image()== "barraNafta0.png"
	method iniciar(){
		game.addVisual( self)
		self.animacionFuel()
	}
	method reiniciar(){
		game.removeTickEvent("bajaFuel")
		self.image("barraNafta5.png")
		self.animacionFuel()
	}
}