import wollok.game.*
import personaje.*
import arma.*
import enemigo.*
import nivel.*
import fondos.*

//PANTALLA PRINCIPAL
object pantallaPrincipal {
	
	var property nivel = primerNivel
	var property pantalla = "muro.jpg"
	var property ancho = 34
	var property alto = 18
	const sonidoIntro = sonido.sonido("intro")
	
	method menuInicial() {
	 	
		self.configurarPantalla()
		self.mostrar(menuPantallaInicial)
		
		//reproduce automáticamente el sonido
        game.schedule(1, {=> sonidoIntro.play()})

        //entra en un loop el sonido después de haber terminado
        sonidoIntro.shouldLoop(true)
        
		keyboard.enter().onPressDo{self.iniciarJuego()}
		keyboard.e().onPressDo{game.stop()}
		
	}
	
	method iniciarJuego() {
		
		game.clear()
		
		if(nivel === primerNivel)	{
		sonidoIntro.stop()
		}
		
		self.nivel().iniciarNivel()
		
		
	}
	
	method victoria(){
		
		self.mostrar(pantallaVictoria) 
	}
	
	
	method configurarPantalla(){
		game.width(ancho)
		game.height(alto)
		game.title("Warrior's Fights")
		game.boardGround(pantalla)
	}
	
	method perder(){
		self.mostrar(pantallaDerrota)
	}
	
	method mostrar(algo){
		game.addVisual(algo)
	}

	
	method quitar(algo){
		game.removeVisual(algo)
	}
	
	method emitirMensaje(contenido, quien){
		game.say(quien, contenido)
	}
	
	method posicionDentroDeLaPantalla(){
		const x = (1..game.width()-6).anyOne()
        const y = (1..game.height()-2).anyOne()

        return game.at(x, y)
	}
	
	
	
}

//SONIDO
object sonido {

    method sonido(audio) = game.sound(audio + ".mp3")

    method reproducir(audio) {
        self.sonido(audio).play()
    }

    method parar(audio) {
        self.sonido(audio).stop()
    }

}


//PANTALLA PARA DERROTA Y VICTORIA
class Pantalla{
	var property image
	var property position=game.origin() //ponerlo en el centro
}

const pantallaVictoria = new Pantalla(image="you-win.png")
const pantallaDerrota= new Pantalla(image="game_over.png")

//MUSICA PARA DERROTA Y VICTORIA
class Music{
	
	var property nombre = null
	
	method play(){
		game.sound(nombre).play()
	}
}

const winnerMusic = new Music(nombre="winner.mp3")
const loserMusic = new Music(nombre="loser.mp3")
