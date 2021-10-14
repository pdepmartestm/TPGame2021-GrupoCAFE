import wollok.game.*
import warrior.*
import enemy.*

object pantalla {
	
	const alto = 18
	const ancho = 35
	
	method iniciar(){
		
		self.tamanioVentanaJuego(alto, ancho)
		self.agregarPesonajesJuego()
		self.desplazamiento()
		
		game.onCollideDo(warrior,{algo => 
			algo.coliciona(warrior)
			game.say(warrior, "¡Uno Menos!")
			if(warrior.miPoder() <= 10000){
				game.say(boss, "¡Humano, eres debil!")
			}else{
				game.say(boss, "¡Al fin, un digno oponente!")
			}
		})
		
		boss.animar()
		
		game.start()
	}
	
	method tamanioVentanaJuego(altura, anchura){
		game.height(altura) //altura
		game.width(anchura) //ancho
		game.title("Warriors")
		game.boardGround("suelo.gif")
	}
	
	method dentroDeLaPantalla(posicion){
		var nuevaPosicion = posicion
		//nuevaPosicion.x(posicion.x().min(ancho-1).max(0))
		//nuevaPosicion.y(posicion.y().min(alto-1).max(0))
		if(posicion.x() >= ancho) nuevaPosicion = game.at(ancho-1, nuevaPosicion.y())
		if(posicion.x() < 0) nuevaPosicion = game.at(0, nuevaPosicion.y())
		if(posicion.y() >= alto) nuevaPosicion = game.at(nuevaPosicion.x(), alto-1)
		if(posicion.y() < 0) nuevaPosicion = game.at(nuevaPosicion.x(), 0)
		return nuevaPosicion
	}
	
	method desplazamiento(){
		keyboard.left().onPressDo({warrior.moverALaIzquierda()})
		keyboard.right().onPressDo({warrior.moverALaDerecha()})
		keyboard.up().onPressDo({warrior.moverArriba()})
		keyboard.down().onPressDo({warrior.moverAbajo()})
		
		game.onTick(2000, "movimientoLadronZombie", {ladronZombie.moverse()})
		game.onTick(2000, "movimientoEnanoHechicero", {enanoHechicero.moverse()})
		game.onTick(500, "movimientoBasilisco", {basilisco.moverse()})
		
		
	}
	
	method agregarPesonajesJuego(){
		game.addVisual(warrior)
		game.addVisual(textoPoderGuerrero)
		game.addVisual(boss)
		game.addVisual(enanoHechicero)
		game.addVisual(ladronZombie)
		game.addVisual(basilisco)
		game.addVisual(esqueleto)
	}
	
}
