import Foundation
import Combine

final class Test:NSObject {
    @objc dynamic var propiedad:Int = 0
}

let test = Test()

test.publisher(for: \.propiedad)
    .map {
        print("Recibido el valor \($0)")
        return $0
    }
    .sink {
        print($0)
    }

test.propiedad = 1
sleep(1)
test.propiedad = 2
sleep(1)
test.propiedad = 3
sleep(1)
test.propiedad = 4
