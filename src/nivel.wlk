import wollok.game.*
import pantallaPrincipal.*
import protagonista.*
import enemigo.*
import arma.*
import personaje.*
import fondos.*
import vidas.*
import elementos.*

class Nivel {
	
	var property personajePrincipal
	var property enemigo
	var property fondo = null
	var property siguienteNivel
	var property esUltimoNivel
	var property tablaPersonaje = tableroPersonaje
	var property tablaEnemigo = tableroEnemigo
	var property tiempoAtaqueEnemigo = 0
	var property elementosUnicos = [itemKitMedico]
	var property elementoRegenerable = itemEnergia
	
	method iniciarNivel(){
		//Agrego fondo de pantalla del nivel
		pantallaPrincipal.agregarCosas(self.fondo())
		
		//Agrego visuales de personajes
		
		[self.personajePrincipal(),self.enemigo(),tablaPersonaje,tablaEnemigo].forEach({unObjeto=>pantallaPrincipal.agregarCosas(unObjeto)})

		//Posiciono armas de personajes
		
		[self.enemigo()].forEach({unObjeto=>unObjeto.agregarArma()})
		
		//Posiciono vidas de personajes
		[self.personajePrincipal(),self.enemigo()].forEach({unObjeto=>unObjeto.agregarVida()})
		
		//Agregar elementos unicos (solo item Vida por ahora, se podrian agregar mas)
		elementosUnicos.forEach({elem=>
			pantallaPrincipal.agregarCosas(elem)
			game.say(elem, "You can only pick one, use it wisely")
		})
		
		//Agregar elementos regenerables (elemento energia)
		pantallaPrincipal.agregarCosas(elementoRegenerable)
		
		//Item energia se regenera cada 3 seg
		game.onTick(3000, "Regenerar item energia",{
				if(!elementoRegenerable.activo()){
					pantallaPrincipal.agregarCosas(elementoRegenerable)
					elementoRegenerable.activo(true)
					
				}
			}
		)
		
		//OnCollide Elementos
		elementosUnicos.forEach{elem=>game.onCollideDo(elem, {
			personaje=>
			personaje.interactuarElemento(elem)
			game.removeVisual(elem)

			})
		}	
		
		game.onCollideDo(elementoRegenerable, {
			personaje=>
			personaje.interactuarElemento(elementoRegenerable)
			game.removeVisual(elementoRegenerable)
			elementoRegenerable.activo(false)
		})
		
			
		//Asigno texto a tableros
		tablaPersonaje.personaje(self.personajePrincipal())
		tablaPersonaje.text()
		tablaEnemigo.enemigo(self.enemigo())
		tablaEnemigo.text()
		
		//actualizo barra de vida enemigo
		enemigo.barraVida().actualizar(enemigo)
			
		//Configuro teclas para mover a personaje principal, ataca al enemigo con la x
		keyboard.left().onPressDo({self.personajePrincipal().moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({self.personajePrincipal().moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({self.personajePrincipal().moverseHaciaArriba()})
		keyboard.down().onPressDo({self.personajePrincipal().moverseHaciaAbajo()})		
			
		keyboard.x().onPressDo{	
			
			self.personajePrincipal().agregarArma()
							
			self.personajePrincipal().usarArma()
			
			game.schedule(200, {personajePrincipal.arma().desaparece()})	
			
			enemigo.recibeAtaque(self.personajePrincipal())
			
			if(self.enemigo().cumploCondicion()){
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
		
		//Mover enemigo
		game.onTick(3000, "mover enemigo", {self.enemigo().moverse()})
		
		
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
	esUltimoNivel = false, 
	siguienteNivel = tercerNivel,
	tiempoAtaqueEnemigo = 3000
)

const tercerNivel = new Nivel(
	personajePrincipal = sacerdote, 
	enemigo = esqueleto,
	fondo = fondoNivelTres,
	esUltimoNivel = true, 
	siguienteNivel = null,
	tiempoAtaqueEnemigo = 3000
)