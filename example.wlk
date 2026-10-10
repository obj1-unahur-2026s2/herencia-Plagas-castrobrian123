

class Barrio{

    const elemento = [] 

    method agregarElemento(unElemento) {
        elemento.add(unElemento)
    }

    method cantidadDeNoBuenos(){
        return elemento.count({e => not e.esBuena()}) //
    }

    method cantidadDeBuenos(){
        return elemento.count({e => e.esBuena()})
    }

    method esCopado() = self.cantidadDeBuenos() > self.cantidadDeNoBuenos() //
}

class Elemento{
    
    method esBuena()

    method efectoQueProduce(plaga)

}

class Hogar inherits Elemento {

    var nivelDeMugre

    var nivelDeConfort 
    
    method nivelDeMugre() = nivelDeMugre

    method nivelDeConfort() = nivelDeConfort

    override method esBuena() = self.nivelDeMugre() <= (self.nivelDeConfort() / 2)

    override method efectoQueProduce(plaga){
        nivelDeMugre = nivelDeMugre + plaga.nivelDeDanio()
    }

}

class Huerta inherits Elemento {

    var capacidadDeProduccion

    var nivelDeHuertas

    method nivelDeHuertas() = nivelDeHuertas

    method cambiarNivelDeHuertas(nuevoNivel) {
        nivelDeHuertas = nuevoNivel 
    }

    method capacidadDeProduccion() = capacidadDeProduccion

    override method esBuena() = self.capacidadDeProduccion() > self.nivelDeHuertas()

    override method efectoQueProduce(plaga){

        capacidadDeProduccion = capacidadDeProduccion - (plaga.nivelDeDanio() * 0.1)

        if (plaga.transmiteEnfermedad()){
            capacidadDeProduccion = capacidadDeProduccion - 10
        }

    }

}

class Mascota inherits Elemento{

    var nivelDeSalud

    method nivelDeSalud() = nivelDeSalud

    override method esBuena() = self.nivelDeSalud() > 250

    override method efectoQueProduce(plaga){
        if (plaga.transmiteEnfermedad()){
            nivelDeSalud = nivelDeSalud - plaga.nivelDeDanio()
        }
    }

}
class Plaga {

    var poblacion

    method poblacion() = poblacion

    method transmiteEnfermedad() = self.poblacion() >= 10

    method nivelDeDanio()

    method atacar(elemento){
        elemento.efectoQueProduce(self)
        self.efectoAtacar()
    }

    method efectoAtacar(){
        poblacion = poblacion + (self.poblacion() * 0.1)
    }

}

class Cucarachas inherits Plaga{ 

    var pesoPromedio

    method pesoPromedio()= pesoPromedio

    override method nivelDeDanio() = self.poblacion() / 2

    override method transmiteEnfermedad() = super() and self.pesoPromedio() >= 10

    override method efectoAtacar() {
        super()
        pesoPromedio = pesoPromedio + 2
    }

}

class Pulgas inherits Plaga{

    override method nivelDeDanio() = self.poblacion() * 2

}

class Garrapatas inherits Pulgas{

    override method efectoAtacar(){
        poblacion = poblacion + (self.poblacion() * 0.2)
    }

}

class Mosquitos inherits Plaga{

    override method nivelDeDanio() = self.poblacion()

    override method transmiteEnfermedad() = super() and self.poblacion() % 3 == 0
   
}
