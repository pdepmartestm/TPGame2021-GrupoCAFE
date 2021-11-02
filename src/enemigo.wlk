import wollok.game.*
import arma.*
import personaje.*
import pantallaPrincipal.*
import areaImagen.*
import vidas.*

class Enemigo inherits Personaje {
	
	var property esEnemigo = true
	
	override method mensaje() = "Auch! I am really angry. I'm going to take revenge!!!"	

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
	
	
	
}

class Esqueleto inherits Enemigo {
	/* 
	override method moverse() {
		const x = 15.randomUpTo(game.width()).truncate(0)
    	const y = 0.randomUpTo(game.height()).truncate(0)
    	position = game.at(x,y) 
	}*/
	override method moverse() {
		const x = (1..limites.ancho()).anyOne()
        const y = (1..limites.alto()).anyOne()

        position = game.at(x, y)
	}
	
}

class EnanoHechicero inherits Enemigo{
	var vecesQueMori = 0
	const cosas = [self, self.arma(), self.barraVida()]
	override method cumploCondicion() = super() && vecesQueMori == 3
	override method recibeAtaque(personaje){
		const yo = self
		super(personaje) 
		if(self.vida() == 0){
			vecesQueMori ++
			cosas.forEach({unObjeto => pantallaPrincipal.removerCosas(unObjeto)})
			game.schedule(1000, {
				self.vida(10)
				pantallaPrincipal.agregarCosas(self)
				self.agregarArma()
				self.agregarVida()
				self.barraVida().actualizar(self)
			})	
			
		}
	}
	
}
const enanoHechicero = new EnanoHechicero(image="enanoHechicero.png", 
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
							
const esqueleto = new Esqueleto(  image="esqueleto.png",
								arma=humoNegro,
								position=game.at(30,8),
								miArea= new AreaImagen(ancho=2, alto=3),
								barraVida = vidaEnemigo	
)


