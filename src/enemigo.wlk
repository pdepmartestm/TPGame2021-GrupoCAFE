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
	
}

class EnemigoConMovimientoAleatorio inherits Enemigo {
	
	override method moverse() {
        self.position(pantallaPrincipal.posicionDentroDeLaPantalla())
        self.posicionarVida()
	}
	
}

class EnanoHechicero inherits Enemigo{
	var vecesQueMori = 0
	const cosas = [self, self.arma(), self.barraVida()]
	
	override method meQuedeSinVida() = super() && vecesQueMori == 3
	
	override method recibeAtaque(personaje){
		
		if(personaje.arma().colisionoConPersonaje(self) && self.vida()>=personaje.arma().poderLetalidad()){
			self.restarVida(personaje.arma().poderLetalidad())
			pantallaPrincipal.emitirMensaje(self.mensaje(), self)
				
				if(self.vida() == 0){
					
					vecesQueMori+=1
					cosas.forEach({unObjeto => pantallaPrincipal.quitar(unObjeto)})
					
						game.schedule(1000, {
						self.vida(10)
						[self, self.barraVida()].forEach({algo => pantallaPrincipal.mostrar(algo)})
						self.barraVida().actualizar(self)
						self.agregarArma()
						
					})	
		}
	
	}
	
}
}

const enanoHechicero = new EnanoHechicero(image="enanoHechicero.png", 
									arma = rayo, 
									position = game.at(30, 8), 
									miArea = new AreaImagen(ancho = 2, alto = 3), 
									barraVida = vidaEnemigo,
									posicionBarraVida=game.at(0,3)
								)
								
const basilisco = new Enemigo(image = "basilisco.png", 
								arma = veneno, 
								position = game.at(25, 8), 
								miArea = new AreaImagen(ancho = 3, alto = 4), 
								barraVida = vidaEnemigo,
								posicionBarraVida=game.at(-1,5)
							)
							
const esqueleto = new EnemigoConMovimientoAleatorio(  image="esqueleto.png",
								arma = humoNegro,
								position = game.at(30,8),
								miArea = new AreaImagen(ancho = 4, alto = 3),
								barraVida = vidaEnemigo,
								posicionBarraVida=game.at(1,4)	
)

const dragon = new EnemigoConMovimientoAleatorio(  image="dragonNegro0.png",
								arma = fuego,
								position = game.at(30,8),
								miArea = new AreaImagen(ancho = 9, alto = 6),
								barraVida = vidaEnemigo,
								posicionBarraVida=game.at(2,5)
)

