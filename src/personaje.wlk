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
	var property posicionBarraVida = game.at(-1,5)
	const property audioAtaque = null
	
	method atacar(){
		arma.movimiento()		
	}
	
	method restarVida(cantidad){
		vida -= cantidad
		self.barraVida().actualizar(self)	
	}
	
	method recibeAtaque(personaje){
		if(personaje.arma().colisionoConPersonaje(self) && self.vida()>=personaje.arma().poderLetalidad()){
			self.restarVida(personaje.arma().poderLetalidad())
			pantallaPrincipal.emitirMensaje(self.mensaje(), self)
		}
	}
	
	method agregarArma(){
		pantallaPrincipal.mostrar(self.arma())
	}
	
	
	method agregarVida(){
		self.posicionarVida()
		pantallaPrincipal.mostrar(self.barraVida())
	}
	
	method posicionarArma()
	
	method posicionarVida() {
		const x = self.posicionBarraVida().x()
		const y = self.posicionBarraVida().y()
		self.barraVida().position(self.position().x() + x, self.position().y() + y)
	}

	
	method interactuarElemento(elemento){
		
	}
	method moverse(){}
	method cumploCondicion(){return self.vida() == 0}
	
}



