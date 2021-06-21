import UIKit

// Función normal
func suma(a: Int, b: Int) -> Int {
    return a + b
}

// Una función puede almacenarse en una variable o constante
let f = { (a: Int, b: Int) -> Int in
    a + b
}

f(4, 5)

var array: [() -> Void] = []

class Test {
    var x = 10
    
    func noEscapa(completion: () -> Void) {
        completion()
    }
    
    func escapa(completion: @escaping () -> Void) {
        array.append(completion)
    }
    
    func testSync() {
        noEscapa(completion: { x = 20 })
        escapa(completion: { print("Hola") })
        escapa(completion: { [weak self] in
            self?.x = 15
        })
//        escapa(completion: {
//            self.x = 15
//        })
    }
}

do {
    let test1 = Test()
    test1.x
    test1.testSync()
    test1.x
}


array.first?()
array.last?()

// Al agregar [weak self], aunque el parámetro "escapa" la referencia
// a test1 ya no se mantiene, y si ejecutásemos las líneas 37 a 40 dentro
// de un bloque do {}, las líneas 42 y 43 no mostrarían salida alguna
// ya que la referencia no se ha mantenido en memoria.

// Comprobar el cambio comentando y descomentando la opción de [weak self] con la que no lo contiene.
// Con [weak self] garantizamos el funcionamiento de esas funciones siempre que exista la referencia, y evitamos la retención de memoria.
