import wollok.game.*
import elementos.*
import auto.*

class Vehiculo {
	// definimos los atributos para velocidad y posición

	const velocidad = 300
	var position 

	method position()= position
	
	// definimos los metodos de indicacion
	method moverseALaDerecha() {
    	position = game.at(position.x()+1, position.y())
  	}
	
    method moverseALaIzquierda(){
    	position = game.at(position.x()+1, position.y())
  	}
  	
  	//método abstracto para que no se cree una instancia de vehículo sin definir clase
	method moverseAbajo()
	
	method moverseArriba() {
    	position = game.at(position.x(), position.y()+1)
  	}
	
	//metodo de indicacion cuando colisiona
	method chocar(){
		game.sound("choque.mp3").play()
		self.moverseArriba()
		auto.chocar()	
	}
	
	method iniciar(){
		game.onTick(velocidad,"enemigo",{self.moverseAbajo()})
	}
}

class Camion inherits Vehiculo{
	// definimos la imagen 
	var property image = "enemigo4.png"
	const fotogramas = ["enemigo4.png", "enemigo4Abajo.png", "enemigo4Arriba.png"]
	method image() = image
	
	override method moverseAbajo(){
		image = fotogramas.get(1)
		const x = (3.. game.width()-6).anyOne()		//le asigno un valor random al Eje x
    	const altura= game.height()					//guardo en una var la altura del tablero
    	game.schedule(100, 
    		{if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    		else { position= game.at(x, altura-1 )} 	//si Eje y es 0 le asigno al eje y la altura del tablero -1
    		image = fotogramas.get(2)})
    	game.schedule(200, {self.image(fotogramas.get(0))})
    }
}

class AutoRojo inherits Vehiculo{
	// definimos la imagen 
	var property image = "enemigo3.png"
	const fotogramas = ["enemigo3.png", "enemigo3Abajo.png", "enemigo3Arriba.png"]
	method image() = image
	
	override method moverseAbajo(){
		image = fotogramas.get(1)
		const x = (3.. game.width()-6).anyOne()		//le asigno un valor random al Eje x
    	const altura= game.height()					//guardo en una var la altura del tablero
    	game.schedule(100, 
    		{if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    		else { position= game.at(x, altura-1 )} 	//si Eje y es 0 le asigno al eje y la altura del tablero -1
    		image = fotogramas.get(2)})
    	game.schedule(200, {self.image(fotogramas.get(0))})
    }
}

class AutoAmarillo inherits Vehiculo{
	// definimos la imagen 
	var property image = "enemigo2.png"
	const fotogramas = ["enemigo2.png", "enemigo2Abajo.png", "enemigo2Arriba.png"]
	method image() = image
	
	override method moverseAbajo(){
		image = fotogramas.get(1)
		const x = (3.. game.width()-6).anyOne()		//le asigno un valor random al Eje x
    	const altura= game.height()					//guardo en una var la altura del tablero
    	game.schedule(100, 
    		{if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    		else { position= game.at(x, altura-1 )} 	//si Eje y es 0 le asigno al eje y la altura del tablero -1
    		image = fotogramas.get(2)})
    	game.schedule(200, {self.image(fotogramas.get(0))})
    }
}
class AutoAzul inherits Vehiculo{
	// definimos la imagen 
	var property image = "enemigo1.png"
	const fotogramas = ["enemigo1.png", "enemigo1Abajo.png", "enemigo1Arriba.png"]
	method image() = image
	
	override method moverseAbajo(){
		image = fotogramas.get(1)
		const x = (3.. game.width()-6).anyOne()		//le asigno un valor random al Eje x
    	const altura= game.height()					//guardo en una var la altura del tablero
    	game.schedule(100, 
    		{if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    		else { position= game.at(x, altura-1 )} 	//si Eje y es 0 le asigno al eje y la altura del tablero -1
    		image = fotogramas.get(2)})
    	game.schedule(200, {self.image(fotogramas.get(0))})
    }
}