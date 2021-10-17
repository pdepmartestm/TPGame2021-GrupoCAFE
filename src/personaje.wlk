import wollok.game.*
import arma.*
import pantallaPrincipal.*

class Personaje{
	
	var property image = null
	var property vida = 100
	var property position = game.at(3,5)
	var property arma = null
	var property energia=50
	
	method usarArma(){
		self.restarEnergia(arma.energiaRequerida())
		if(!arma.puedeLanzarAtaque(self))
		pantallaPrincipal.emitirMensaje("No tienes energia suficiente" + self.energia().toString(), self)
		
	}
	
	method atacar(atacado){
		if(arma.puedeLanzarAtaque(self)){
			atacado.restarVida(arma.poderLetalidad())
		}
		
	}
		
	method restarVida(cantidad){
		vida = vida - cantidad
		game.say(self, "auch maldito!")
		if(vida<=0){
			
		}
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
}

const guerrero = new Personaje(image="guerrero.png", arma=espada)

/* 
const arquero = new Personaje(image="arquero.png", arma=new Arma())
const sacerdote = new Personaje(image="sacerdote.png", arma=new Arma())
const angelGuerrero = new Personaje(image="guerreroFinal.png", arma=new Arma())
*/
object recorrido{
	method superaA(limite, posicion){
		return posicion < limite
	}
}
