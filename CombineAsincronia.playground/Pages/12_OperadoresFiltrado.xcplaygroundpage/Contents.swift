import UIKit
import Combine

let number = [1,5,7,9,9,3,5,7,6,4,4,5,12,2,4].publisher

number
    .filter { $0.isMultiple(of: 3) }
    .sink {
        print("Múltiplos 3: \($0)")
    }

number
    .removeDuplicates()
    .sink {
        print("Borrar duplicados: \($0)")
    }

number
    .ignoreOutput()
    .sink { completion in
        if case .finished = completion {
            print("Ha finalizado")
        }
    } receiveValue: { value in
        print("Ha llegado un \(value)")
    }

number
    .first { $0 % 3 == 0 }
    .sink {
        print("Primer valor: \($0)")
    }

number
    .last { $0 % 3 == 0 }
    .sink {
        print("Último valor: \($0)")
    }

let semaforo = PassthroughSubject<Void, Never>()
let numbers = PassthroughSubject<Int, Never>()
    
numbers
    .drop(untilOutputFrom: semaforo)
    .sink {
        print("DROP: \($0)")
    }

let nums = [1,5,7,9,9,3,5,7,6,4,4,5,12,2,4]

nums.forEach { n in
    if n == 3 {
        semaforo.send()
    }
    numbers.send(n)
}
