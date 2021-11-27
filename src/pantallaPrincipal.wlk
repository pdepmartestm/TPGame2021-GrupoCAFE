import wollok.game.*
import personaje.*
import arma.*
import enemigo.*
import nivel.*
import fondos.*

object pantallaPrincipal {
	
	var property nivel = primerNivel
	var property pantalla = "muro.jpg"
	
	 method menuInicial() {
	 	
		self.configurarPantalla()
		game.addVisual(menuPantallaInicial)
		
		//reproduce automáticamente el sonido
        game.schedule(1, {=> sonidoIntro.play()})

        //entra en un loop el sonido después de haber terminado
        sonidoIntro.shouldLoop(true)
        
		keyboard.enter().onPressDo{self.iniciarJuego()}
		keyboard.e().onPressDo{game.stop()}
		
	}
	
	method iniciarJuego() {
		
		game.clear()
		nivel.iniciarNivel()	
		sonidoIntro.stop()
	}
	
	method victoria(){
		
		self.agregarCosas(pantallaVictoria) 
	}
		
	method siguienteNivel(siguienteNivel){
		nivel=siguienteNivel
		siguienteNivel.iniciarNivel()
	}
	
	
	method configurarPantalla(){
		game.width(34)
		game.height(18)
		game.title("Warrior's Fights")
		game.boardGround(pantalla)
	}
	
	method perder(){
		game.addVisual(pantallaDerrota)
	}
	
	method agregarCosas(algo){
		game.addVisual(algo)
	}

	
	method removerCosas(algo){
		game.removeVisual(algo)
	}
	
	method emitirMensaje(contenido, quien){
		game.say(quien, contenido)
	}
	
	method posicionDentroDeLaPantalla(){
		const x = (1..limites.ancho()).anyOne()
        const y = (1..limites.alto()).anyOne()

        return game.at(x, y)
	}
	
	
	
}

object sonido {

    method sonido(audio) = game.sound(audio + ".mp3")

    method reproducir(audio) {
        self.sonido(audio).play()
    }

    method parar(audio) {
        self.sonido(audio).stop()
    }

}
const sonidoIntro = sonido.sonido("intro")

object limites{
	
	var property alto=game.height() - 6
	var property ancho=game.width() - 2

}

class Pantalla{
	var property image
	var property position=game.at(8,4) //ponerlo en el centro
}

const pantallaVictoria = new Pantalla(image="you-win.png")
const pantallaDerrota= new Pantalla(image="game_over.png")

class Music{
	
	var property nombre = null
	
	method play(){
		game.sound(nombre).play()
	}
}

const winnerMusic = new Music(nombre="winner.mp3")
const loserMusic = new Music(nombre="loser.mp3")
