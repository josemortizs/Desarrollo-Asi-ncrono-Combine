import Foundation
import Combine

let subject = PassthroughSubject<String,Never>()

let subscriber = subject.sink(receiveValue: { resultado in
    print(resultado)
})

subject.send("A")
sleep(1)
subject.send("Long")
sleep(1)
subject.send("Time")
sleep(1)
subject.send("Ago")
sleep(1)
subject.send("in")
sleep(1)
subject.send("a")
sleep(1)
subscriber.cancel()
subject.send("galaxy")
sleep(1)
subject.send("far")
sleep(1)
subject.send("far")
sleep(1)
subject.send("away")

subject.send(completion: .finished)
