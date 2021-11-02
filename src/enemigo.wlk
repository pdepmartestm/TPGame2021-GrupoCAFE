import wollok.game.*
import arma.*
import personaje.*
import pantallaPrincipal.*
import areaImagen.*
import vidas.*

class Enemigo inherits Personaje {
	
	var property esEnemigo=true
	
	override method mensaje() = "Auch maldito, me voy a vengar!"	

	override method posicionarArma() {
		self.arma().position(self.position().x() -2, self.position().y())
	}
	override method agregarArma(){
		self.posicionarArma()
		super()
	}
	override method posicionarVida() {
		self.barraVida().position(self.position().x() - 1, self.position().y() + 4)
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

const enanoHechicero = new Enemigo(image="enanoHechicero.png", 
									arma=rayo, 
									position=game.at(30, 8), 
									miArea = new AreaImagen(ancho = 2, alto = 3), 
									barraVida = vidaEnemigo
								)
								
const basilisco = new Enemigo(image = "basilisco.png", 
								arma = veneno, 
								position = game.at(15, 5), 
								miArea = new AreaImagen(ancho = 3, alto = 4), 
								barraVida = vidaEnemigo
							)

