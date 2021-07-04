import UIKit
import Combine

func newPublisher(value:String) -> CurrentValueSubject<String, Never> {
    .init(value.uppercased())
}

let publisher = ["Ola", "k", "ASe", "proGRamas", "o", "K", "ase"].publisher

let pub = publisher
    .map { $0.lowercased() }
    .map(\.localizedLowercase)
    .flatMap(maxPublishers: .max(3)) { (resultado:String) -> CurrentValueSubject<String, Never> in
        newPublisher(value: resultado)
    }

let subscriber = pub
    .sink(receiveValue: {
        print($0)
    })
