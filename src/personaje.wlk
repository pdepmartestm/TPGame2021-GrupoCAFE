import wollok.game.*
import arma.*
import pantallaPrincipal.*
import areaImagen.*
import vidas.*

class Personaje{
	
	var property image = null
	var property vida = 10
	var property position = game.at(3,5)
	var property arma = null
	var property mensaje = null
	var property miArea = null
	var property barraVida = null
	
	method atacar(){
		self.usarArma()		
	}
	
	method usarArma(){
		arma.movimiento()
	}
	
	method restarVida(cantidad){
		vida -= cantidad
		self.barraVida().actualizar(self)
		
	}
	
	method recibeAtaque(personaje){
		if(personaje.arma().estoyDentroDelRango(self)){
			self.restarVida(personaje.arma().poderLetalidad())
			personaje.posicionarArma()
			pantallaPrincipal.emitirMensaje(self.mensaje(), self)
		}
	}
	
	method agregarArma(){
		game.addVisual(self.arma())
	}
	
	
	method agregarVida(){
		self.posicionarVida()
		game.addVisual(self.barraVida())
	}
	
	method posicionarArma(){}
	
	
	method posicionarVida() {}
	
	method interactuarElemento(elemento){
		
	}
	
}



