import pantallaPrincipal.*
import personaje.*
import arma.*
import wollok.game.*

class Protagonista inherits Personaje{
	
	var property energia = 100000
	
	
	override method atacar(){
		
		if(self.poseeEnergiaRequerida(arma))
			self.usarArma()
		
		else
			pantallaPrincipal.emitirMensaje("No tienes energia suficiente" + self.energia().toString(), self)
		
	}
	
	
	method poseeEnergiaRequerida(arma) = energia >= arma.energiaRequerida()
	
	
	override method usarArma(){
		
		self.restarEnergia(arma.energiaRequerida()) //pierde energia		
		arma.movimiento()
		//game.schedule(200, {arma.desaparece()})
	}
	
	method restarEnergia(cantidad){
		
		if(energia>0)
		
		energia = energia - cantidad
	}
	
	method regenerarEnergia(){
		
		if(energia<50){
			
			energia = energia + 5
		}
	}
	
	method moverseHaciaLaDerecha(){
		
		if(position.x()<limites.ancho()){
			
			position = position.right(1)
			arma.position(self.arma().position().x()+1,self.arma().position().y())
		}
	}
	
	method moverseHaciaLaIzquierda(){
		
		if(position.x()>2){
			position = position.left(1)
			arma.position(self.arma().position().x()-1,self.arma().position().y())
		}
	}
	
	method moverseHaciaArriba(){
		
		if(position.y()<limites.alto()){
			position = position.up(1)
			arma.position(self.arma().position().x(),self.arma().position().y()+1)
		}
	}
	
	method moverseHaciaAbajo(){
		
		if(position.y()>1){
			position = position.down(1)
			arma.position(self.arma().position().x(),self.arma().position().y()-1)
		}
	}
	
	
}


const guerrero = new Protagonista(image="guerrero1.png", arma=espada)
const angelGuerrero = new Protagonista(image="guerreroFinal.png", arma=espada2)
/* 
const arquero = new Protagonista(image="arquero.png", arma=new Arma())
const sacerdote = new Protagonista(image="sacerdote.png", arma=new Arma())
const angelGuerrero = new Protagonista(image="guerreroFinal.png", arma=new Arma())
*/