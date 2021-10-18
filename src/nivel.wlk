import wollok.game.*
import pantallaPrincipal.*
import protagonista.*
import enemigo.*
import arma.*

class Nivel {
	
	var property personajePrincipal=null
	var property enemigo = null
	var property fondo = null
	var property siguienteNivel
	var property esUltimoNivel
	var property tablaPersonaje = tableroPersonaje
	var property tablaEnemigo = tableroEnemigo
	
	
	method iniciarNivel(){
		
		//Agrego visuales de personajes
		
		[self.personajePrincipal(),self.enemigo()].forEach({unObjeto=>pantallaPrincipal.agregarCosas(unObjeto)})
		
		
		//Asigno texto a tableros
		
		self.tablaPersonaje().text(self.personajePrincipal())
		self.tablaEnemigo().text(self.enemigo())
		
		//Agrego visuales de tableros
		
		[self.tablaPersonaje(),self.tablaEnemigo()].forEach({unObjeto=>pantallaPrincipal.agregarCosas(unObjeto)})
		
		//Posiciono armas de personajes
		
		[self.personajePrincipal(),self.enemigo()].forEach({unObjeto=>unObjeto.posicionarArma()})
			
		//Configuro teclas para mover a personaje principal, ataca al enemigo con la x
			
			keyboard.left().onPressDo({self.personajePrincipal().moverseHaciaLaIzquierda()})
			keyboard.right().onPressDo({self.personajePrincipal().moverseHaciaLaDerecha()})
			keyboard.up().onPressDo({self.personajePrincipal().moverseHaciaArriba()})
			keyboard.down().onPressDo({self.personajePrincipal().moverseHaciaAbajo()})		
			keyboard.x().onPressDo{	
				
				const colliders = game.colliders(self.personajePrincipal().arma()) //colliders : objetos que colisionan con el arma del personaje principal
				
				self.personajePrincipal().usarArma()
			//Si el arma del protagonista colisiona con el enemigo
				colliders.forEach{cosa=>
											if(cosa==self.enemigo())
											self.personajePrincipal().arma().colisiona(self.enemigo())						
											pantallaPrincipal.emitirMensaje("Auch maldito",self.enemigo())
											//game.onTick(500, "Impacto", {self.personajePrincipal().regenerarEnergia()})
				}
			}
			
			//Enemigo ataca
			
			game.onTick(500, "Ataque de enemigo ", {self.enemigo().atacar()})
			
			
			//Si el arma del enemigo colisiona con el protagonista
			
			game.onCollideDo(self.enemigo().arma(),{personaje=>
				if(personaje==self.personajePrincipal()){
					self.enemigo().arma().colisiona(self.personajePrincipal())
					pantallaPrincipal.emitirMensaje("Arghh debo tener mas cuidado",self.personajePrincipal())
			}})
			
	    	//Cuando el ataque se va del mapa, generar uno nuevo
	    	game.onTick(1000, "Regenerar ataque enemigo", {
	    		if(self.enemigo().arma().position().x()<0){
	    			self.enemigo().arma().volverPosicionInicial() 
	    		}
	    	})
	    	//Regenerar energia cada 3 segundos, podriamos hacer que la regenere agarrando objetos del mapa
	    	game.onTick(3000, "Regenerar energia", {self.personajePrincipal().regenerarEnergia()})
		
		
		
	}
	
	
	
	method terminarNivel(){
		
		//Remuevo personajes
		
		[enemigo,enemigo.arma(),personajePrincipal,personajePrincipal.arma()].forEach({unObjeto=>pantallaPrincipal.removerCosas(unObjeto)})
		
		if(self.siguienteNivel().esUltimoNivel()){
			
			pantallaPrincipal.victoria()
				
		}else{
			pantallaPrincipal.siguienteNivel(self.siguienteNivel())
		}
		
	}	
	

	
	
}

object tableroPersonaje {
	var property position = [1,15]
	
	method text(personaje){
		
		return "Personaje vida : " + personaje.vida().toString() + " Personaje energia:" + personaje.energia()
	}
}

object tableroEnemigo{
	var property position = [20,15]
	
	method text(personaje){
		
		return "Personaje vida : " + personaje.vida().toString()
	}
}


const primerNivel = new Nivel(
	personajePrincipal=guerrero, 
	enemigo=enanoHechicero,
	fondo="escenarioArena.png", 
	siguienteNivel=segundoNivel, 
	esUltimoNivel=false
)
	
const segundoNivel = new Nivel(
	personajePrincipal=angelGuerrero, 
	enemigo=enanoHechicero,
	esUltimoNivel=true, 
	siguienteNivel=null
)