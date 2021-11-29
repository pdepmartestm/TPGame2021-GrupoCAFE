import wollok.game.*
import pantallaPrincipal.*

class Elemento {
	
	var property image
	var property position
	
}

class Energia inherits Elemento{
	
	var property activo=true
	
	method accion(personaje){
		personaje.regenerarEnergia()
	}
	
	method aparecer(){
		pantallaPrincipal.mostrar(self)
	}
			
}


class KitMedico inherits Elemento{
	
	const vida = 5
	
	method accion(personaje){
		personaje.aumentarVida(vida)
	}
	
}

const itemEnergia = new Energia(image="energyPoison.png", position=game.at(10,12))
const itemKitMedico = new KitMedico(image="lifePoison.png", position=game.at(16,10))