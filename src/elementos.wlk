import wollok.game.*
import vehiculos.*
import auto.*

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
		game.onTick(velocidad,"elemento1",{self.moverseAbajo()})
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
		game.onTick(velocidad,"elemento1",{self.moverseArriba()})
	}
}
	
class Referencia inherits Elemento{
	// definimos la imagen 

	method image()= "referencia.png"
	
	override method iniciar(){
		game.onTick(velocidad,"elemento1",{self.moverseArriba()})
	}
	//method mostrarLlegada(){
		//if(position.y()==7)game.boardGround("fondoLlegada.png")
	//}
}

class Fuel inherits Elemento{
	// definimos la imagen 
	method image()= "vida.png"
	override method chocar(){
		auto.sumarVida()
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

class Bandera {
	var position
	var image
	method position()= position
	method image()= image
	
}

class Vida {
	var position
	 
	method position()= position
	
	method image() = "referenciaVida.png"
	
	method iniciar(){game.addVisual(self)}
	
	method quitar(){game.removeVisual(self)}
}

object mano{
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
	method encender(){sonido.play()}
	method apagar(){sonido.stop()}
}