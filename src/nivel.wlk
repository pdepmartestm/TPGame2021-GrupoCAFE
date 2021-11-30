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
	var property tiempoAtaqueEnemigo = 0
	var property elementosUnicos = [itemKitMedico]
	var property elementoRegenerable = itemEnergia
	const sonidoAmbiente = null
	const loserMusic = sonido.sonido("loser")
	const winnerMusic = sonido.sonido("winner")
	
	method iniciarNivel(){
		//Agrego fondo de pantalla del nivel
		pantallaPrincipal.mostrar(self.fondo())
		
		//Reproducir sonido indefinidamente
		game.schedule(1, {=> sonidoAmbiente.play()})
		sonidoAmbiente.shouldLoop(true)
		
		//Agrego visuales de personajes
		[self.personajePrincipal(),self.enemigo(),tablaPersonaje].forEach({unObjeto=>pantallaPrincipal.mostrar(unObjeto)})

		//Posiciono armas de personajes
		
		[self.enemigo()].forEach({unObjeto=>unObjeto.agregarArma()})
		
		//Posiciono vidas de personajes
		[self.personajePrincipal(),self.enemigo()].forEach({unObjeto=>unObjeto.agregarVida()})
		
		//Agregar elementos unicos (solo item Vida por ahora, se podrian agregar mas)
		elementosUnicos.forEach({elem=>
			pantallaPrincipal.mostrar(elem)
			game.say(elem, "You can only pick one, use it wisely")
		})
		
		//Agregar elementos regenerables (elemento energia)
		pantallaPrincipal.mostrar(elementoRegenerable)
		
		/*pantallaPrincipal.emitirMensaje(mensaje,ayuda)*/
		
		//Item energia se regenera cada 3 seg
		game.onTick(3000, "Regenerar item energia",{
				if(!elementoRegenerable.activo()){
					pantallaPrincipal.mostrar(elementoRegenerable)
					elementoRegenerable.activo(true)
					
				}
			}
		)
		
		//OnCollide Elementos
		elementosUnicos.forEach{elem=>game.onCollideDo(elem, {
			personaje =>
			personaje.interactuarElemento(elem)
			game.removeVisual(elem)

			})
		}
		
		
		game.onTick(4000,"colisiona elemento regenerable con protagonista", {
			if(elementoRegenerable.miArea().colisionan(personajePrincipal, elementoRegenerable)) {
				personajePrincipal.interactuarElemento(elementoRegenerable)
				game.removeVisual(elementoRegenerable)
				elementoRegenerable.activo(false)
				}
			})
			

		//Asigno texto a tableros
		tablaPersonaje.personaje(self.personajePrincipal())
		tablaPersonaje.text()
		
		//actualizo barra de vida enemigo
		enemigo.barraVida().actualizar(enemigo)
		
		//actualizo barra de vida personaje principal
		personajePrincipal.barraVida().actualizar(personajePrincipal)
			
		//Configuro teclas para mover a personaje principal, ataca al enemigo con la x
		keyboard.left().onPressDo({self.personajePrincipal().moverseHaciaLaIzquierda()})
		keyboard.right().onPressDo({self.personajePrincipal().moverseHaciaLaDerecha()})
		keyboard.up().onPressDo({self.personajePrincipal().moverseHaciaArriba()})
		keyboard.down().onPressDo({self.personajePrincipal().moverseHaciaAbajo()})		
		
		//ataque protagonista	
		keyboard.x().onPressDo{	
			
			if(personajePrincipal.poseeEnergiaRequerida(personajePrincipal.arma())) {			
				self.personajePrincipal().atacar()
				enemigo.recibeAtaque(self.personajePrincipal())
			}
			else
				pantallaPrincipal.emitirMensaje("You do not have enough energy" + personajePrincipal.energia().toString(), personajePrincipal)
				
			if(self.enemigo().meQuedeSinVida()){
				self.terminarNivel()
			}
			
		}
		
			
		//Enemigo ataca
		game.onTick(tiempoAtaqueEnemigo, "Ataque de enemigo", {self.enemigo().atacar()})
			
			
		//Si el arma del enemigo colisiona con el protagonista
		game.onTick(1000, "Colicion arma enemigo contra protagonista", {
				personajePrincipal.recibeAtaque(enemigo)
				if(personajePrincipal.vida() == 0){
					sonidoAmbiente.stop()
					game.clear()
					pantallaPrincipal.perder()
					loserMusic.play()
				}
			})
			
	    //Cuando el ataque se va del mapa, generar uno nuevo
	    game.onTick(1000, "Regenerar ataque enemigo", {
	    		if(self.enemigo().arma().position().x()<1){
	    			self.regenerarAtaqueEnemigo()
	    		}
	    	})
		
		//Mover enemigo
		game.onTick(3000, "mover enemigo", {self.enemigo().moverse()})
		
		//Mover regenerador de energia
		game.onTick(6000, "mover regenerador de energia", {self.elementoRegenerable().moverse()})
		
		
	}
	
	method regenerarAtaqueEnemigo(){
		self.enemigo().posicionarArma()
	}
	
	method terminarNivel(){
		
		//Remuevo todo antes de empezar el siguiente nivel
		game.clear()
		
		if(self.esUltimoNivel()){
			sonidoAmbiente.stop()
			pantallaPrincipal.victoria()
			winnerMusic.play()
			
				
		}else{
			sonidoAmbiente.stop()
			pantallaPrincipal.nivel(siguienteNivel)
			pantallaPrincipal.iniciarJuego()
		}
	}	
	
}

object tableroPersonaje {
	var property position = game.center()//at(1, 15)//[1,15]
	var property personaje = null
	
	method text(){
		
		return " Personaje energia:" + personaje.energia()
	}
	
}
	

const primerNivel = new Nivel(
	personajePrincipal = guerrero, 
	enemigo = enanoHechicero,
	fondo = fondoNivelUno,
	siguienteNivel = segundoNivel, 
	esUltimoNivel = false,
	tiempoAtaqueEnemigo = 200,
	sonidoAmbiente = sonido.sonido("sonidoDesierto")
)	
const segundoNivel = new Nivel(
	personajePrincipal = arquera, 
	enemigo = basilisco,
	fondo = fondoNivelDos,
	esUltimoNivel = false, 
	siguienteNivel = tercerNivel,
	tiempoAtaqueEnemigo = 3000,
	sonidoAmbiente = sonido.sonido("sonidoBosque")
)
const tercerNivel = new Nivel(
	personajePrincipal = sacerdote, 
	enemigo = esqueleto,
	fondo = fondoNivelTres,
	esUltimoNivel = false, 
	siguienteNivel = cuartoNivel,
	tiempoAtaqueEnemigo = 3000,
	sonidoAmbiente = sonido.sonido("sonidoCueva")
)
const cuartoNivel = new Nivel(
	personajePrincipal = angel, 
	enemigo = dragon,
	fondo = fondoNivelCuatro,
	esUltimoNivel = true, 
	siguienteNivel = null,
	tiempoAtaqueEnemigo = 3000,
	sonidoAmbiente = sonido.sonido("sonidoCuevaDeLava")
)