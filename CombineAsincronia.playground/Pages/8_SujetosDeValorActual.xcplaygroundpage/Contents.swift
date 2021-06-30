import Foundation
import Combine


let subject = CurrentValueSubject<Int, Never>(0)
subject.value

subject.send(1)
subject.send(2)

subject.value

sleep(2)

let subscription = subject.sink(receiveValue: { print("Recibí el valor \($0)") })

sleep(2)

subject.send(3)

subject.send(completion: .finished)

subject.send(4)
