// PUBLICADORES

import Combine


let publisher = [1, 4, 6, 5, 7, 8, 6, 5].publisher

let subscriber = publisher.sink {
    print("Recibido: \($0)")
}

class UnObjeto {
    var valor = "" {
        didSet {
            print("Asignado el valor \(valor)")
        }
    }
}

let objeto1 = UnObjeto()

let publisher2 = ["Hola", "Adiós", "Hasta luego", "¿Qué tal estás?"].publisher

let subscriber2 = publisher2.assign(to: \.valor, on: objeto1)

