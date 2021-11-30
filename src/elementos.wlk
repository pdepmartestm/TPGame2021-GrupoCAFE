import wollok.game.*
import pantallaPrincipal.*
import areaImagen.*

class Elemento {
	
	var property image
	var property position
	const property miArea = null
	

	method moverse(){}

}

class Energia inherits Elemento{
	
	var property activo = true
	
	
	method accion(personaje){
		personaje.regenerarEnergia()
	}
	
	method aparecer(){
		pantallaPrincipal.mostrar(self)
	}
	override method moverse() {
        self.position(pantallaPrincipal.posicionDentroDeLaPantalla())
	}
			
}


class KitMedico inherits Elemento{
	
	const vida = 5

	method accion(personaje){
		personaje.aumentarVida(vida)
	}
	
}

const itemEnergia = new Energia(image="energyPoison.png", position=game.at(10,12), miArea = new AreaImagen(ancho = 1, alto = 1))
const itemKitMedico = new KitMedico(image="lifePoison.png", position=game.at(16,10), miArea = new AreaImagen(ancho = 1, alto = 1))