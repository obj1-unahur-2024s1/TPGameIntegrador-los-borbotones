import wollok.game.*

class Num{
	var position
	var image
	
	method image()= image
	method position()= position
}

object unidad{
	var aux = 0
	
	const cero= new Num(position= game.at(13,6), image="number0.png" )
	const uno= new Num(position= game.at(13,6), image="number1.png" )
	const dos= new Num(position= game.at(13,6), image="number2.png" )
	const tres= new Num(position= game.at(13,6), image="number3.png" )
	const cuatro= new Num(position= game.at(13,6), image="number4.png" )
	const cinco= new Num(position= game.at(13,6), image="number5.png" )
	const seis= new Num(position= game.at(13,6), image="number6.png" )
	const siete= new Num(position= game.at(13,6), image="number7.png" )
	const ocho= new Num(position= game.at(13,6), image="number8.png" )
	const nueve= new Num(position= game.at(13,6), image="number9.png" )
	const unidades=[cero,uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve]
	
	method iniciar(){
		game.addVisual(unidades.get(aux))
		game.onTick(1000,"cambiarUnidad",{
			game.removeVisual(unidades.get(aux)) 
			game.addVisual(unidades.get(if(aux<9)aux+1 else 0)) 
			if (aux<9) { aux = aux + 1 } else { aux = 0 decena.sumaDiez()}
		})
	}
	
	method parar(){
		game.removeTickEvent("cambiarUnidad")
	}
	method contadorACero(){ aux = 0 }
}
object decena{
	var aux= 0
	
	const cero= new Num(position= game.at(12,6), image="number0.png" )
	const uno= new Num(position= game.at(12,6), image="number1.png" )
	const dos= new Num(position= game.at(12,6), image="number2.png" )
	const tres= new Num(position= game.at(12,6), image="number3.png" )
	const cuatro= new Num(position= game.at(12,6), image="number4.png" )
	const cinco= new Num(position= game.at(12,6), image="number5.png" )
	const seis= new Num(position= game.at(12,6), image="number6.png" )
	const siete= new Num(position= game.at(12,6), image="number7.png" )
	const ocho= new Num(position= game.at(12,6), image="number8.png" )
	const nueve= new Num(position= game.at(12,6), image="number9.png" )
	const unidades=[cero,uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve]
	
	method iniciar(){ game.addVisual(unidades.get(aux)) }
	
	method parar(){
		game.removeTickEvent("cambiarUnidad")
	}
	
	method sumaDiez(){
		game.removeVisual(unidades.get(aux))
		game.addVisual(unidades.get( if (aux<9) aux + 1 else 0))
		if (aux<9) { aux = aux + 1 } else { aux = 0 centena.sumarCien() }
	}
	
	method contadorACero(){ aux = 0 }
}

object centena{
	var aux= 0
	
	const cero= new Num(position= game.at(11,6), image="number0.png" )
	const uno= new Num(position= game.at(11,6), image="number1.png" )
	const dos= new Num(position= game.at(11,6), image="number2.png" )
	const tres= new Num(position= game.at(11,6), image="number3.png" )
	const cuatro= new Num(position= game.at(11,6), image="number4.png" )
	const cinco= new Num(position= game.at(11,6), image="number5.png" )
	const seis= new Num(position= game.at(11,6), image="number6.png" )
	const siete= new Num(position= game.at(11,6), image="number7.png" )
	const ocho= new Num(position= game.at(11,6), image="number8.png" )
	const nueve= new Num(position= game.at(11,6), image="number9.png" )
	const unidades=[cero,uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve]
	
	method iniciar(){ game.addVisual(unidades.get(aux)) }
	
	method parar(){
		game.removeTickEvent("cambiarUnidad")
	}
	
	method sumarCien(){
		game.removeVisual(unidades.get(aux)) 
		game.addVisual(unidades.get(if(aux<9)aux+1 else 0)) 
		aux=if(aux<9)aux+1 else 0
	}
	
	method contadorACero(){ aux = 0 }
}

object score{
	
	method iniciar(){ [unidad, decena, centena].forEach{ n => n.iniciar() } }
	
	method parar(){ unidad.parar() }
	
	method vidaObtenida(){ decena.sumaDiez() }
	
	method reiniciar(){[unidad, decena, centena].forEach{ n => n.contadorACero() } }
}
