import wollok.game.*

object guerrero {
	
	var posicion = game.at(3,5)
	var property poder = 1000
	
	method position() {
		return posicion
	}

	method image() {
		if(poder > 5000 && poder <= 10000){
			return "guerreroNegro.png"
		}
		if(poder > 10000){
			return "guerreroFinal.png"
		}
		return "guerreroPrincipal.png"
	}
	
	method moverALaDerecha(){
		posicion = posicion.right(1)
	}
	method moverALaIzquierda(){
		posicion = posicion.left(1)
	}
	method moverArriba(){
		posicion = posicion.up(1)
	}
	method moverAbajo(){
		posicion = posicion.down(1)
	}
	
	method aumentaPoder(cantColisiones){
		poder += 500*cantColisiones
	}
}

object textoPoderGuerrero {
	method position() = game.origin()
	method text() = "        Power: " + guerrero.poder()
	method colisiona(){}
}


