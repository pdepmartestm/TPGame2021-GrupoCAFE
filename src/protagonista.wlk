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

			self.agregarArma()
			sonido.reproducir(self.audioAtaque())
			self.restarEnergia(self.arma().energiaRequerida()) //pierde energia		
			self.arma().movimiento()
			game.schedule(50, {self.arma().desaparece()})	
		
	}
	
	method poseeEnergiaRequerida(arma) = energia >= arma.energiaRequerida()
	

	override method posicionarArma(){
		const x = self.position().x() + self.posicionArmaX()
		const y = self.position().y() + self.posicionArmaY()
		self.arma().position(x, y)
	}
	
	override method agregarArma(){
		super()
		self.posicionarArma()	
	}
	
	method restarEnergia(cantidad){
		if(energia > 0) energia -= cantidad
	}
	
	method regenerarEnergia(){
		if(energia < 100){ 
			energia += 50
			game.say(self, "+50 energy")
		}
			
	}
	
	method aumentarVida(cantidad){
		if (vida<10){
			if(vida+cantidad>10){
				vida = 10
				self.barraVida().actualizar(self)
			}else{
			vida = vida + cantidad
			self.barraVida().actualizar(self)
			game.say(self, "10+ life")
			}
		}
		}
		
	override method interactuarElemento(elemento){
		elemento.accion(self)
	}
	
	method moverseHaciaLaDerecha(){
		
		if(self.position().x()<(pantallaPrincipal.ancho()-2)){
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
		
		if(self.position().y()<(pantallaPrincipal.alto()-6)){
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
	
}



const guerrero = new Protagonista(image = "guerrero1.png", 
									arma = espada, 
									miArea = new AreaImagen(ancho = 2, alto = 5), 
									posicionArmaX = 2, 
									posicionArmaY = 2,
									barraVida = vidaPersonajePrincipal,
									audioAtaque = "sonidoEspada"
								)
								
const arquera = new Protagonista(image = "arquera.png", 
									arma = flecha, 
									miArea = new AreaImagen(ancho = 2, alto = 3), 
									posicionArmaX = 1, 
									posicionArmaY = 4,
									barraVida = vidaPersonajePrincipal,
									audioAtaque = "sonidoFlecha"
								)
								
const sacerdote = new Protagonista(image = "sacerdote.png", 
									arma = aura, 
									miArea = new AreaImagen(ancho = 2, alto = 5), 
									posicionArmaX = -1, 
									posicionArmaY = -1,
									barraVida = vidaPersonajePrincipal,
									audioAtaque = "sonidoAuraSacerdote"
								)
								
const angel = new Protagonista(image = "guerreroFinal.png", 
								arma = luz, 
								miArea = new AreaImagen(ancho = 2, alto = 5), 
								posicionArmaX = 3, 
								posicionArmaY = 2,
								barraVida = vidaPersonajePrincipal,
								audioAtaque = "sonidoAtaqueAngel"
							)
