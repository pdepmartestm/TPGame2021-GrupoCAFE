import wollok.game.*
import guerrero.*
import pantalla.*
import arma.*


class Enemigo {
	
	var cantidadDesaparecidas = 0
	
	method coliciona(alguien){
		
		game.removeVisual(self)
		cantidadDesaparecidas++
		alguien.aumentaPoder(cantidadDesaparecidas)
		
		if(cantidadDesaparecidas < 3){
			game.addVisual(self)
		}
	}	
}


object boss inherits Enemigo {
	
	const power = 10000
	const posicion = game.at(25,11)
	var nro = 0
	method position() {
		return posicion
	}

	method image() {
		return "dragonNegro"+ nro + ".png"
	}
	
	override method coliciona(alguien){
		if(power < alguien.miPoder()){
			game.removeVisual(self)
			game.addVisual(victory)
		}else{
			game.addVisual(lose)
		}
	}
	
	method animar(){
		game.onTick(5000, "dragonSeMueve", {nro = (nro + 1) % 2})
	}
	
}

object enanoHechicero inherits Enemigo {
	
	var posicion = game.center()//game.at(1,15)
	
	method position() {
		return posicion
	}

	method image() {
		return "enanoHechicero.png"
	}
	
	method moverse(){
		2.times({x => 
			posicion = posicion.down(1)
		})
		
		if(posicion.y() < 0) posicion = game.at(1,15)
		
	}
	
	method atacar(){
		rayoParalizador.position(self.position())
		game.addVisual(rayoParalizador)
		rayoParalizador.lado()
		game.schedule(500, {rayoParalizador.desaparece()})
	}
	
}

object ladronZombie inherits Enemigo {
	
	var posicion = game.at(28,3)
	
	method position() {
		return posicion
	}

	method image() {
		return "ladronZombie.png"
	}
	
	method moverse(){
		const x = (-5..30).anyOne()
    	const y = (-5..15).anyOne()
    	posicion = pantalla.dentroDeLaPantalla(game.at(x,y))
    }
	
}

object basilisco inherits Enemigo {
	
	var posicion = game.center()//at(19,9)
	var moverseALaIzquierda = true
	
	method position() {
		return posicion
	}

	method image() {
		return "basilisco.png"
	}
	
	method moverse(){
		if(moverseALaIzquierda){
			self.moverseIzquierda()
		}else{
			self.moverseDerecha()
		}
		
		
	}
	
	method moverseIzquierda(){
		
		2.times({a => 
			posicion = posicion.left(1)
		})
		if(posicion.x() <= 0) moverseALaIzquierda = false
	}
	
	method moverseDerecha(){
		
		2.times({b => 
			posicion = posicion.right(1)
		})
		
		if(posicion.x() == game.center().x()) moverseALaIzquierda = true
	}
}

object esqueleto inherits Enemigo {
	
	const posicion = game.at(13,4)
	
	method position() {
		
		return posicion
	}

	method image() {
		return "esqueleto.png"
	}
	
	
}


object victory {
	
	method position() = game.at(11,5)
	method image() = "you-win.png"
}

object lose {
	
	method position() = game.at(9,3)
	method image() = "game_over.png"
}