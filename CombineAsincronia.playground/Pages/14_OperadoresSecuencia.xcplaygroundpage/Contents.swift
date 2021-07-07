import UIKit
import Combine

let publisher = [5,3,7,1,3,9,2].publisher

publisher
    .min()
    .sink { value in
        print("Mínimo \(value)")
    }

publisher
    .max()
    .sink { value in
        print("Máximo \(value)")
    }

let pub2 = ["Hola", "K", "ase"].publisher

pub2
    .min { $0.count < $1.count }
    .sink { value in
        print("Mínimo caracteres \(value)")
    }

pub2
    .max { $0.count < $1.count }
    .sink { value in
        print("Máximo caracteres \(value)")
    }

publisher
    .first()
    .sink { value in
        print("Primero \(value)")
    }

publisher
    .last()
    .sink { value in
        print("Último \(value)")
    }

publisher
    .output(at: 2)
    .sink { value in
        print("Índice 2 valor emitido \(value)")
    }

publisher
    .output(in: 2...4)
    .sink { value in
        print("Índice 2 al 4 valor emitido \(value)")
    }

publisher
    .count()
    .sink { value in
        print("Total de valores emitidos \(value)")
    }
