import wollok.game.*
import elementos.*

object auto {
	
	var property vida= 3
	var position = game.at(3,1)
	//variables para las animaciones
	const imgDerecha = ["auto1.png", "auto2.png","auto3.png","auto4.png","auto1.png"]
	const imgIzquierda = ["auto1.png","auto5.png","auto6.png","auto7.png","auto1.png"]
	var property image = "auto1.png"
	
	//metodos de consulta
	method position()= position
	
	//metodos en auto para moverse una posicion x sin salir del tablero
    method moverseALaDerecha(){
    	const ancho= game.width()					//guardo en una var el ancho del tablero
    	const nuevoX= (position.x()+1) % ancho	//le sumo 1 a la posicion del eje X, y me fijo si esta en la ultima posicion le doy el valor 0 
	    position = game.at(nuevoX, self.position().y())	//guardo en la var position la nueva posicion
    }
    
    method moverseALaIzquierda(){
    	const ancho= game.width()					//guardo en una var el ancho del tablero
    	if (position.x() > 0) {position= game.at(position.x()-1, position.y() ) }//si Eje x es mayor a 0 le resto 1
    	else {position= game.at(ancho -1, position.y() ) }	//si eje x es 0 le asigno al eje x el ancho del tablero -1
    }
    
    method moverseArriba() {
    	const altura= game.height()					//guardo en una var la altura del tablero
    	const nuevoY= (position.y()+1) % altura		//le sumo 1 a la posicion del eje y, y me fijo si esta en la ultima posicion le doy el valor 0 
	    position = game.at(self.position().x(), nuevoY)	//guardo en la var position la nueva posicion
    }
    method moverseAbajo() {
    	const altura= game.height()					//guardo en una var la altura del tablero
    	if (position.y() > 0) {position= game.at(position.x(), position.y()-1) }//si Eje y es mayor a 0 le resto 1
    	else {position= game.at(position.x(), altura-1 ) }	//si eje y es 0 le asigno al eje y el ancho del tablero -1
	}
    
    //metodo para animacion al colisionar
    method animacionDerrape(){ // Animacion itera sobre la lista de imagenes y cambia el visual cada X tiempo
		var i = 0
		if (position.x() > 5) {game.onTick(200,"derrape",{self.image(imgDerecha.get(i%5)) i+=1})}
		else {game.onTick(200,"derrape",{self.image(imgIzquierda.get(i%5)) i+=1})}
	}
	//metodo para eliminar la animacion
	method eliminar(tiempo,tick){
		game.schedule(tiempo, {game.removeTickEvent(tick)})		
	}
	//metodo de indicacion cuando colisiona y para descontar vidas
    method chocar(){
    	self.animacionDerrape()
    	self.eliminar(1300, "derrape")
		game.say(self,"conduce mejor")
		if (position.x() > 5) self.moverseALaDerecha() else self.moverseALaIzquierda()
		vida -=1
		if (vida == 0){game.addVisual(gameOver)}
	}
	method sumarVida(){
		vida+= 1
	}
}
