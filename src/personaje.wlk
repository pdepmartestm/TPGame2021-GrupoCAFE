import wollok.game.*
import arma.*
import pantallaPrincipal.*

class Personaje{
	
	var property image = null
	var property vida = 5
	var property position = game.at(3,5)
	var property arma = null
	var property mensaje = null
	
	method atacar(atacado){
		atacado.restarVida(arma.poderLetalidad())		
	}
		
	method restarVida(cantidad){
		vida = vida - cantidad
		game.say(self, self.mensaje() + ' Vida: '+self.vida().toString())
		if(vida<=0){
			
		}
	}
	
	method posicionarArma(){
		game.addVisual(self.arma())
	}

	
	
}

