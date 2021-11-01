import wollok.game.*
import pantallaPrincipal.*
import protagonista.*
import enemigo.*
import arma.*
import personaje.*


class Nivel {
	
	var property personajePrincipal
	var property enemigo
	var property fondo = null
	var property siguienteNivel
	var property esUltimoNivel
	var property tablaPersonaje = tableroPersonaje
	var property tablaEnemigo = tableroEnemigo
	var property tiempoAtaqueEnemigo = 0
	
	
	method iniciarNivel(){
		//Agrego fondo de pantalla del nivel
		pantallaPrincipal.agregarCosas(self.fondo())
		
		//Agrego visuales de personajes
		
		[self.personajePrincipal(),self.enemigo(),tablaPersonaje,tablaEnemigo].forEach({unObjeto=>pantallaPrincipal.agregarCosas(unObjeto)})

		//Posiciono armas de personajes
		
		[self.personajePrincipal(),self.enemigo()].forEach({unObjeto=>unObjeto.agregarArma()})
			
		//Asigno texto a tableros
		tablaPersonaje.personaje(self.personajePrincipal())
		tablaPersonaje.text()
		tablaEnemigo.enemigo(self.enemigo())
		tablaEnemigo.text()
			
		//Configuro teclas para mover a personaje principal, ataca al enemigo con la x
			
		keyboard.left().onPressDo({self.personajePrincipal().moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({self.personajePrincipal().moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({self.personajePrincipal().moverseHaciaArriba()})
		keyboard.down().onPressDo({self.personajePrincipal().moverseHaciaAbajo()})		
			
		keyboard.x().onPressDo{	
				
		const colliders = game.colliders(self.personajePrincipal().arma()) //colliders : objetos que colisionan con el arma del personaje principal
				
		self.personajePrincipal().usarArma()
				
		//Si el arma del protagonista colisiona con el enemigo
				
		/*colliders.forEach{cosa =>
								cosa.recibeAtaque(self.personajePrincipal())	//.arma()
											//game.onTick(500, "Impacto", {self.personajePrincipal().regenerarEnergia()})
				}*/
				enemigo.recibeAtaque(self.personajePrincipal())
				if(self.enemigo().vida() == 0){
					self.terminarNivel()
				}
			}
			
		//Enemigo ataca
			
		game.onTick(tiempoAtaqueEnemigo, "Ataque de enemigo", {self.enemigo().atacar()})
			
			
		//Si el arma del enemigo colisiona con el protagonista
			
		game.onTick(200, "Colicion arma enemigo contra protagonista", {
				personajePrincipal.recibeAtaque(enemigo)
			})
			
	    //Cuando el ataque se va del mapa, generar uno nuevo
	    	
	    game.onTick(1000, "Regenerar ataque enemigo", {
	    		if(self.enemigo().arma().position().x()<1){
	    			self.regenerarAtaqueEnemigo()
	    		}
	    	})
	    	
	    //Regenerar energia cada 3 segundos, podriamos hacer que la regenere agarrando objetos del mapa
	    game.onTick(3000, "Regenerar energia", {self.personajePrincipal().regenerarEnergia()})
		
		
		
	}
	
	method regenerarAtaqueEnemigo(){
		self.enemigo().posicionarArma()
	}
	
	
	method terminarNivel(){
		
		//Remuevo todo antes de empezar el siguiente nivel
		game.clear()
		
		if(self.esUltimoNivel()){
			
			pantallaPrincipal.victoria()
				
		}else{
			
			pantallaPrincipal.siguienteNivel(siguienteNivel)
		}
		
	}	
	

	
	
}

object tableroPersonaje {
	var property position = game.center()//at(1, 15)//[1,15]
	var property personaje = null
	
	method text(){
		
		return "Personaje vida : " + personaje.vida().toString() + " Personaje energia:" + personaje.energia()
	}
	
	method textColor() = "00FF00FF"
}

object tableroEnemigo{
	var property position = game.at(20, 15)//[20,15]
	var property enemigo = null
	
	
	method text(){
		
		return "Enemigo vida : " + enemigo.vida().toString()
	}
	
	method textColor() = "FF0000FF"
}

object fondoNivelUno {
	var property image = "escenarioArena.png"
	var property position = game.origin()
}

object fondoNivelDos {
	var property image = "orillaLago.jpg"
	var property position = game.origin()
}



const primerNivel = new Nivel(
	personajePrincipal = guerrero, 
	enemigo = enanoHechicero,
	fondo = fondoNivelUno,
	siguienteNivel = segundoNivel, 
	esUltimoNivel = false,
	tiempoAtaqueEnemigo = 200
)
	
const segundoNivel = new Nivel(
	personajePrincipal = arquera, 
	enemigo = basilisco,
	fondo = fondoNivelDos,
	esUltimoNivel = true, 
	siguienteNivel = null,
	tiempoAtaqueEnemigo = 3000
)