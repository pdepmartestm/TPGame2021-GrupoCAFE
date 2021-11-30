

class AreaImagen {
	
	var property ancho
	var property alto
	
	method colisionan(colisionador, colisionado){
		
		const coinciden = true
		
		const anchoColisionador = colisionador.miArea().ancho()
		const altoColisionador = colisionador.miArea().alto()
		
		const anchoColisionado = colisionado.miArea().ancho()
		const altoColisionado = colisionado.miArea().alto()
	
		if(colisionador.position().x() > (colisionado.position().x() + anchoColisionado)) return !coinciden 
		if(colisionado.position().x() > (colisionador.position().x() + anchoColisionador)) return !coinciden
		
		if(colisionador.position().y() > (colisionado.position().y() + altoColisionado)) return !coinciden 
		if(colisionado.position().y() > (colisionador.position().y() + altoColisionador)) return !coinciden 
		
		return coinciden
	}
	
}
