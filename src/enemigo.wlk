import wollok.game.*
import arma.*
import personaje.*
import pantallaPrincipal.*

class Enemigo inherits Personaje {
	
	var property esEnemigo=true
		
	override method restarVida(cantidad){
		vida -= cantidad
		
		if(vida <= 0){
			pantallaPrincipal.nivel().terminarNivel()
		}
	
	
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

const enanoHechicero = new Enemigo(image="enanoHechicero.png", arma=rayo, position=game.at(30, 8))
const enanoHechicero2 = new Enemigo(image="enanoHechicero.png", arma=rayo2, position=game.at(15, 5))