import Combine
import Foundation

class ClasePublicadora {
    var futuro: Future<String, Never> {
        Future<String, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success("OK"))
            }
        }
    }
    
    var subscriber: AnyCancellable?
    var subscribers = Set<AnyCancellable>()
    
    func start() {
        subscriber = futuro.sink { value in
            print("\(value)")
        }
        
        [1, 3, 5, 6, 7, 8, 10]
            .publisher
            .sink {
                value in
                print("\(value)")
            }
            .store(in: &subscribers)
        
        futuro.sink { value in
            print("\(value)")
        }.store(in: &subscribers)
    }
}


let clase1 = ClasePublicadora()
clase1.start()
