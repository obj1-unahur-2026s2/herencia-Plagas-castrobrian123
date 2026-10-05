
class Elemento {

    method esBueno()

    method recibirAtaque(plaga)

}

class Hogar inherits Elemento {

    var mugre

    var confort

    override method esBueno() = mugre <= confort / 2

    override method recibirAtaque(plaga) {
        mugre += plaga.nivelDeDanio()
    }

}

class Huerta inherits Elemento {

    var capacidadProduccion

    override method esBueno() = capacidadProduccion > 100

    override method recibirAtaque(plaga) {

        if (plaga.transmiteEnfermedades()) {
            capacidadProduccion -= 10
        } else {
            capacidadProduccion -= plaga.nivelDeDanio() * 0.1
        }

    }

}

class Mascota inherits Elemento {

    var salud

    override method esBueno() = salud > 250

    override method recibirAtaque(plaga) {

        if (plaga.transmiteEnfermedades()) {
            salud -= plaga.nivelDeDanio()
        }

    }

}

class Barrio {

    var elementos

    method esCopado() {
        return
            elementos.count { elemento =>     elemento.esBueno() } >
            elementos.count { elemento => not elemento.esBueno() }
    }

}

class Plaga {

    var poblacion

    method nivelDeDanio()

    method transmiteEnfermedades() {
        return poblacion >= 10
    }

    method aumentarPoblacion() {
        poblacion *= 1.1
    }

    method atacar(elemento) {
        elemento.recibirAtaque(self)
        self.aumentarPoblacion()
    }

}

class Cucarachas inherits Plaga {

    var pesoPromedio

    override method nivelDeDanio() = poblacion / 2

    override method transmiteEnfermedades() = super() && pesoPromedio >= 10

    override method aumentarPoblacion() {
        super()
        pesoPromedio += 2
    }

}

class Pulgas inherits Plaga {

    override method nivelDeDanio() = poblacion * 2

}

class Garrapatas inherits Pulgas {

    override method aumentarPoblacion() {
        poblacion *= 1.2
    }

}

class Mosquitos inherits Plaga {

    override method nivelDeDanio() = poblacion

    override method transmiteEnfermedades() = super() && poblacion % 3 == 0

}
