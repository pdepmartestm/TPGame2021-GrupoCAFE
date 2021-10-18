import pantallaPrincipal.*
import personaje.*
import arma.*
import wollok.game.*

class Protagonista inherits Personaje{
	
	var property energia=100000
	
	override method atacar(atacado){
		if(arma.puedeLanzarAtaque(self)){
			atacado.restarVida(arma.poderLetalidad())
		}
	}
	
	method usarArma(){
		self.restarEnergia(arma.energiaRequerida())
		if(!arma.puedeLanzarAtaque(self))
		pantallaPrincipal.emitirMensaje("No tienes energia suficiente" + self.energia().toString(), self)
		
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
			arma.position(position.x()+2,position.y()+2)
		}
	}
	
	method moverseHaciaLaIzquierda(){
		if(position.x()>1){
			position = position.left(1)
			arma.position(position.x()+2,position.y()+2)
		}
	}
	
	method moverseHaciaArriba(){
		if(position.y()<limites.alto()){
			position = position.up(1)
			arma.position(position.x()+2,position.y()+2)
		}
	}
	
	method moverseHaciaAbajo(){
		if(position.y()>1){
			position = position.down(1)
			arma.position(position.x()+2,position.y()+2)
		}
	}
	
	
}



const guerrero = new Protagonista(image="guerrero2.png", arma=espada, mensaje="Arghh debo tener mas cuidado")

/* 
const arquero = new Protagonista(image="arquero.png", arma=new Arma())
const sacerdote = new Protagonista(image="sacerdote.png", arma=new Arma())
const angelGuerrero = new Protagonista(image="guerreroFinal.png", arma=new Arma())
*/