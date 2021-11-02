import wollok.game.*
import personaje.*
import enemigo.*
import protagonista.*
import pantallaPrincipal.*
import areaImagen.*

class Arma{
	
	var property image=null
	var property position=null
	var property poderLetalidad=null 
	const property energiaRequerida=null
	const property miArea = null
	
	method movimiento(){}
	
	method recibeAtaque(armaPersonaje){}
	
	method desaparece(){
		return game.removeVisual(self)	
	}
	
	method position(x,y){
		position=game.at(x,y)
	}
	
	method estoyDentroDelRango(unPersonaje){
		
		const coinciden = true
		const anchoPersonaje = unPersonaje.miArea().ancho()
		const altoPersonaje = unPersonaje.miArea().alto()
		const anchoArma = self.miArea().ancho()
		const altoArma = self.miArea().alto()
	
		if(unPersonaje.position().x() > (self.position().x() + anchoArma)) return !coinciden 
		if(self.position().x() > (unPersonaje.position().x() + anchoPersonaje)) return !coinciden 
		if(unPersonaje.position().y() > (self.position().y() + altoArma)) return !coinciden 
		if(self.position().y() > (unPersonaje.position().y() + altoPersonaje)) return !coinciden 
		
		return coinciden
	}
}

class Espada inherits Arma{
	override method movimiento(){
		
		//position = position.left(3)
		//position = position.up(2)
		
	}
}

class Rayo inherits Arma{
	override method movimiento(){
		
		position = position.left(1)
	}
}

class Veneno inherits Arma{
	override method movimiento(){
		position = pantallaPrincipal.posicionDentroDeLaPantalla()
	}
}

class Flecha inherits Arma{
	override method movimiento(){
		
		position = position.right(5)
	}
}


class Aura inherits Arma {
	
}

class Humo inherits Arma {
	override method movimiento(){
		position = pantallaPrincipal.posicionDentroDeLaPantalla()    	
	}
}

class Fuego inherits Veneno {
	
}

class Luz inherits Arma {
	
}

const espada = new Espada(image="espada.png", poderLetalidad=5, energiaRequerida=10, position=game.at(5,7), miArea = new AreaImagen(ancho = 2, alto = 2))
const flecha = new Flecha(image = "flecha.png", poderLetalidad=5, energiaRequerida=10, position=game.at(5,7), miArea = new AreaImagen(ancho = 2, alto = 1))
const rayo = new Rayo(image="rayo.png", poderLetalidad=5, miArea = new AreaImagen(ancho = 2, alto = 3))
const veneno = new Veneno(image="charcoVeneno.png", poderLetalidad=5, miArea = new AreaImagen(ancho = 3, alto = 2))
const aura = new Aura(image="auraSacerdote.png",poderLetalidad=5,energiaRequerida=10, position=game.at(5,7), miArea=new AreaImagen(ancho=2,alto=6))
const humoNegro = new Humo(image="humoNegro.png", poderLetalidad=5, miArea = new AreaImagen(ancho = 2, alto = 3),position=game.at(30,8))
const fuego = new Fuego(image="fuego.png",poderLetalidad=5,energiaRequerida=10, position=game.at(5,7), miArea=new AreaImagen(ancho=2,alto=6))
const luz = new Luz(image="luz.png",poderLetalidad=5,energiaRequerida=10, position=game.at(5,7), miArea=new AreaImagen(ancho=2,alto=2))
