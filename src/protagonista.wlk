import pantallaPrincipal.*
import personaje.*
import arma.*
import wollok.game.*
import areaImagen.*

class Protagonista inherits Personaje{
	
	var property energia = 100000
	
	override method mensaje() = "Arghh debo tener mas cuidado"
	
	override method atacar(){
		
		if(self.poseeEnergiaRequerida(self.arma()))
			self.usarArma()
		
		else
			pantallaPrincipal.emitirMensaje("No tienes energia suficiente" + self.energia().toString(), self)
		
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
		self.arma().position(self.position().x() + 2, self.position().y() + 2)
	}
	override method agregarArma(){
		self.posicionarArma()
		super()
	}
	
	method restarEnergia(cantidad){
		
		if(energia > 0)
		
		energia = energia - cantidad
	}
	
	method regenerarEnergia(){
		
		if(energia<50){
			
			energia = energia + 5
		}
	}
	
	method moverseHaciaLaDerecha(){
		
		if(self.position().x()<limites.ancho()){
			
			position = self.position().right(1)
			self.posicionarArma()
		}
	}
	
	method moverseHaciaLaIzquierda(){
		
		if(self.position().x()>2){
			position = self.position().left(1)
			self.posicionarArma()
		}
	}
	
	method moverseHaciaArriba(){
		
		if(self.position().y()<limites.alto()){
			position = self.position().up(1)
			self.posicionarArma()
		}
	}
	
	method moverseHaciaAbajo(){
		
		if(self.position().y()>1){
			position = self.position().down(1)
			self.posicionarArma()
		}
	}
	
	
}


const guerrero = new Protagonista(image="guerrero2.png", arma=espada, miArea = new AreaImagen(ancho = 1, alto = 5))//
const angelGuerrero = new Protagonista(image="guerreroFinal.png", arma=espada)
/* 
const arquero = new Protagonista(image="arquero.png", arma=new Arma())
const sacerdote = new Protagonista(image="sacerdote.png", arma=new Arma())
const angelGuerrero = new Protagonista(image="guerreroFinal.png", arma=new Arma())
*/