import UIKit
import Combine

// Procedimiento síncrono
func incremento(valor: Int) -> Int {
    valor + 1
}

incremento(valor: 4)

// Procedimiento asíncrono
func incrementoTiempo(valor: Int) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
        valor + 1
    })
}

incrementoTiempo(valor: 4)

func incrementoFuturo(valor: Int, tiempo: TimeInterval) -> Future<Int, Never> {
    Future<Int, Never> { promise in
        DispatchQueue.global().asyncAfter(deadline: .now() + tiempo) {
            promise(.success(valor + 1))
        }
    }
}

let future = incrementoFuturo(valor: 4, tiempo: 4)

let subscriber = future.sink {
    print($0)
}


let future2 = incrementoFuturo(valor: 6, tiempo: 6)

let subscriber2 = future2.sink { completion in
    if case .finished = completion {
        print("Ha terminado")
    }
} receiveValue: { num in
    print(num)
}

