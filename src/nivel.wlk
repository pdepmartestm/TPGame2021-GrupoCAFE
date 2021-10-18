import wollok.game.*
import pantallaPrincipal.*
import protagonista.*
import enemigo.*

class Nivel {
	
	var property personajePrincipal=null
	var property enemigo = null
	var property fondo = null
	var property siguienteNivel
	var property esUltimoNivel
	
	method terminarNivel(){
		
		pantallaPrincipal.removerCosas(enemigo)
		pantallaPrincipal.removerCosas(enemigo.arma())
		pantallaPrincipal.removerCosas(personajePrincipal)
		pantallaPrincipal.removerCosas(personajePrincipal.arma())
		
		if(self.siguienteNivel().esUltimoNivel()){
			
			pantallaPrincipal.victoria()
				
		}else{
			pantallaPrincipal.siguienteNivel(self.siguienteNivel())
		}
		
	}	
	
	method iniciarNivel(){
		keyboard.left().onPressDo({self.personajePrincipal().moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({self.personajePrincipal().moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({self.personajePrincipal().moverseHaciaArriba()})
		keyboard.down().onPressDo({self.personajePrincipal().moverseHaciaAbajo()})
		
		//Personaje ataca al enemigo con la x
		keyboard.x().onPressDo{
			const colliders = game.colliders(self.personajePrincipal())
			self.personajePrincipal().usarArma()
			colliders.forEach{cosa=>
				if(cosa==self.enemigo()){
					self.personajePrincipal().atacar(self.enemigo())
				}
				
			}
		}
		
		pantallaPrincipal.agregarCosas(self.personajePrincipal())
		pantallaPrincipal.agregarCosas(self.enemigo())
		self.personajePrincipal().posicionarArma()
		self.enemigo().posicionarArma()
	}
	
	
}

const primerNivel = new Nivel(personajePrincipal=guerrero, 
	enemigo=enanoHechicero,
	fondo="escenarioArena.png", siguienteNivel=segundoNivel, esUltimoNivel=false, siguienteNivel=segundoNivel)
	
const segundoNivel = new Nivel(esUltimoNivel=true, siguienteNivel=null)