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
		pantallaPrincipal.quitar(self)	
	}
	
	method position(x,y){
		position=game.at(x,y)
	}
	
	method colisionoConPersonaje(unPersonaje) = miArea.colisionan(unPersonaje, self)

}


class ArmaDisparadaHaciaIzquierda inherits Arma{
	override method movimiento(){
		
		position = position.left(1)
	}
}

class ArmaConDisparoAleatorio inherits Arma{
	override method movimiento(){
		position = pantallaPrincipal.posicionDentroDeLaPantalla()
	}
	
	method interactuarElemento(param1){}
}

class ArmaDisparadaHaciaDerecha inherits Arma{
	override method movimiento(){
		
		position = position.right(5)
	}
}


const espada = new Arma(image="espada.png", poderLetalidad=2, energiaRequerida=10, position=game.at(5,7), miArea = new AreaImagen(ancho = 2, alto = 2))
const flecha = new ArmaDisparadaHaciaDerecha(image = "flecha.png", poderLetalidad=5, energiaRequerida=10, position=game.at(5,7), miArea = new AreaImagen(ancho = 2, alto = 1))
const rayo = new ArmaDisparadaHaciaIzquierda(image="rayo.png", poderLetalidad=2, miArea = new AreaImagen(ancho = 2, alto = 3))
const veneno = new ArmaConDisparoAleatorio(image="charcoVeneno.png", poderLetalidad=5, miArea = new AreaImagen(ancho = 3, alto = 2))
const aura = new Arma(image="auraSacerdote.png",poderLetalidad=5,energiaRequerida=10, position=game.at(5,7), miArea=new AreaImagen(ancho=2,alto=6))
const humoNegro = new ArmaConDisparoAleatorio(image="humoNegro.png", poderLetalidad=5, miArea = new AreaImagen(ancho = 2, alto = 3),position=game.at(30,8))
const fuego = new ArmaConDisparoAleatorio(image="fuego.png",poderLetalidad=5,energiaRequerida=10, position=game.at(5,7), miArea=new AreaImagen(ancho=2,alto=6))
const luz = new Arma(image="luz.png",poderLetalidad=5,energiaRequerida=10, position=game.at(5,7), miArea=new AreaImagen(ancho=2,alto=2))
