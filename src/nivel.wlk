import wollok.game.*
import pantallaPrincipal.*
import protagonista.*
import enemigo.*

class Nivel {
	
	var property personajePrincipal=null
	var property enemigo = null
	var property fondo = null
	var property siguienteNivel=segundoNivel
	var property esUltimoNivel=false
	
	method terminarNivel(){
		
		pantallaPrincipal.removerCosas(enemigo)
		pantallaPrincipal.removerCosas(enemigo.arma())
		pantallaPrincipal.removerCosas(personajePrincipal)
		pantallaPrincipal.removerCosas(personajePrincipal.arma())
		
		if(self.siguienteNivel().esUltimoNivel()){ //no entra aca, ver
				
			pantallaPrincipal.agregarCosas(pantallaVictoria)

		}else{
			pantallaPrincipal.siguienteNivel(self.siguienteNivel())
		}
		
	}	
	
	method iniciarNivel(){
		keyboard.left().onPressDo({self.personajePrincipal().moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({self.personajePrincipal().moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({self.personajePrincipal().moverseHaciaArriba()})
		keyboard.down().onPressDo({self.personajePrincipal().moverseHaciaAbajo()})
		
		pantallaPrincipal.agregarCosas(self.personajePrincipal())
		pantallaPrincipal.agregarCosas(self.enemigo())
		self.personajePrincipal().posicionarArma()
		self.enemigo().posicionarArma()
	}
	
	
}

const primerNivel = new Nivel(personajePrincipal=guerrero, 
	enemigo=enanoHechicero,
	fondo="escenarioArena.png", siguienteNivel=segundoNivel)
	
const segundoNivel = new Nivel(esUltimoNivel=true)