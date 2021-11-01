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
   		
   		var cantidad = personaje.vida()
   	
	   	var posX = personaje.position().x()
	   	var posY = personaje.position().y() + 1
	   	
	   	self.position(posX,posY)
	   		image = cantidad.toString() + "vidas.png"
	   		game.addVisual(self)
	   }
   
   
 }
 

 
 const vidaPersonajePrincipal =  new Vida(image="10vidas.png", position=game.at(3,6))
 const vidaEnemigoHechizero = new Vida(image="10vidas.png", position=game.at(30,8))


