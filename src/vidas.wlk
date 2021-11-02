import wollok.game.*
import pantallaPrincipal.*
import protagonista.*
import personaje.*


class Vida {

    var property image = null
    var property position = null
    
    method position(x,y){
		position = game.at(x,y)
	}
    
   method actualizar(personaje){
   		game.removeVisual(self)
   		const cantidad = personaje.vida()
	   	personaje.posicionarVida()
	   	image = cantidad.toString() + "vidas.png"
	   	game.addVisual(self)
	}
   
   
 }
 

 
 const vidaPersonajePrincipal =  new Vida(image="10vidas.png", position=game.at(3,6))
 const vidaEnemigo = new Vida(image="10vidas.png", position=game.at(30,8))


