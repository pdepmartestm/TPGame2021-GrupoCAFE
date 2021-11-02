import pantallaPrincipal.*
import personaje.*
import arma.*
import wollok.game.*
import areaImagen.*
import vidas.*

class Protagonista inherits Personaje{
	
	var property energia = 100
	var property posicionArmaX
	var property posicionArmaY
	
	override method mensaje() = "Arghh that hurts!"
	
	override method atacar(){
		
		if(self.poseeEnergiaRequerida(self.arma())) self.usarArma()
		else
			pantallaPrincipal.emitirMensaje("You do not have enough energy" + self.energia().toString(), self)
		
	}
	
	method poseeEnergiaRequerida(arma) = energia >= arma.energiaRequerida()
	
	
	override method usarArma(){
		
		self.restarEnergia(self.arma().energiaRequerida()) //pierde energia		
		self.arma().movimiento()
	}
	
	override method recibeAtaque(enemigo){
		
		super(enemigo)
		if(self.vida() == 0){
			game.clear()
			pantallaPrincipal.perder()
			
		}
	}
	
	override method posicionarArma(){
		const x = self.position().x() + self.posicionArmaX()
		const y = self.position().y() + self.posicionArmaY()
		self.arma().position(x, y)
	}
	
	override method agregarArma(){
		self.posicionarArma()
		super()
	}
	
	method restarEnergia(cantidad){
		if(energia > 0) energia = energia - cantidad
	}
	
	method regenerarEnergia(){
		if(energia < 100){ 
			energia = energia + 5
			game.say(self, "+5 energy")
		}
			
	}
	
	method aumentarVida(cantidad){
		if (vida<10){
			if(vida+cantidad>10){
				vida = 10
			}else{
			vida = vida + cantidad
			game.say(self, "10+ life")
			}
		}
		}
		
	override method interactuarElemento(elemento){
		elemento.accion(self)
	}
	
	method moverseHaciaLaDerecha(){
		
		if(self.position().x()<limites.ancho()){
			position = self.position().right(1)
			self.posicionarArma()
			self.posicionarVida()
		}
	}
	
	method moverseHaciaLaIzquierda(){
		
		if(self.position().x()>2){
			position = self.position().left(1)
			self.posicionarArma()
			self.posicionarVida()
		}
	}
	
	method moverseHaciaArriba(){
		
		if(self.position().y()<limites.alto()){
			position = self.position().up(1)
			self.posicionarArma()
			self.posicionarVida()
		}
	}
	
	method moverseHaciaAbajo(){
		
		if(self.position().y()>1){
			position = self.position().down(1)
			self.posicionarArma()
			self.posicionarVida()
		}
	}
	
	/* 
	override method posicionarVida() {
		self.barraVida().position(self.position().x() - 2, self.position().y() + 5)
	}*/
	
}



const guerrero = new Protagonista(image = "guerrero1.png", 
									arma = espada, 
									miArea = new AreaImagen(ancho = 1, alto = 5), 
									posicionArmaX = 2, 
									posicionArmaY = 2,
									barraVida = vidaPersonajePrincipal
								)
								
const arquera = new Protagonista(image = "arquera.png", 
									arma = flecha, 
									miArea = new AreaImagen(ancho = 2, alto = 3), 
									posicionArmaX = 1, 
									posicionArmaY = 4,
									barraVida = vidaPersonajePrincipal
								)
								
const sacerdote = new Protagonista(image = "sacerdote.png", 
									arma = aura, 
									miArea = new AreaImagen(ancho = 2, alto = 5), 
									posicionArmaX = -1, 
									posicionArmaY = -1,
									barraVida = vidaPersonajePrincipal
								)
								
const angel = new Protagonista(image = "guerreroFinal.png", 
								arma = luz, 
								miArea = new AreaImagen(ancho = 2, alto = 5), 
								posicionArmaX = 3, 
								posicionArmaY = 2,
								barraVida = vidaPersonajePrincipal
							)
