import wollok.game.*
import arma.*
import personaje.*
import pantallaPrincipal.*

class Enemigo inherits Personaje {
	
	override method recibeAtaqueEnemigo(arma){
		
	}
		
	override method restarVida(cantidad){
		vida -= cantidad
		
		if(vida <= 0){
			pantallaPrincipal.nivel().terminarNivel()
		}
	
	
	}
	
	method recibeAtaqueDePersonaje(armaPersonaje){
		self.restarVida(armaPersonaje.poderLetalidad())
		pantallaPrincipal.emitirMensaje("Auch maldito, me voy a vengar!", self)
	}
	
	override method posicionarArma(){
		self.arma().position(position.x(), position.y())
		game.addVisual(self.arma())
	}
	
		
	/* 
	method moverseRandom(){
	//por ahora todos se mueven random, la idea seria
	//que cada enemigo tenga su tipo de movimiento(VER)
		const x = 0.randomUpTo(game.width()).truncate(0)
		const y = 0.randomUpTo(game.height()).truncate(0)
		position = game.at(x,y)
	}
*/
}

const enanoHechicero = new Enemigo(image="enanoHechicero.png", arma=rayo, position=game.at(25, 8))
const enanoHechicero2 = new Enemigo(image="enanoHechicero.png", arma=rayo2, position=game.at(20, 5))