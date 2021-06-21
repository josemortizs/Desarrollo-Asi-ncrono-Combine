import UIKit

let array = [1,4,5,7,8,7,6,4,5,4,5,4,3,2,4,5,6,7]
let array2 = ["Hola", "Adiós", "Good Bye", "Hello"]
let arrayPics = ["Alias", "Alien", "BasicInstinct", "Paquito", "Aliens", "AmazingStories", "BoysFromBrazil", "AmericanTail"]


let arrayNumCadena = array.map({ num -> String in
    return "\(num)"
})

let arrayCadena = array.map { "\($0)" }

//arrayCadena.map {
//    print($0)
//}

let arrayMenor6 = array.filter { $0 < 6 }

//arrayMenor6.map {
//    print($0)
//}

let arrayImages = arrayPics.map { UIImage(named: "\($0).jpg") }
let arrayImges2 = arrayPics.compactMap { UIImage(named: "\($0).jpg") }

let arrayImges3 = arrayPics
    .compactMap { UIImage(named: "\($0).jpg") }
    .filter { $0.size.width == 100 }

let sumatorio = array.reduce(0, { $0 + $1 })
sumatorio

let csv = array
    .filter { $0 < 6 }
    .map { "\($0)" }
    .reduce("") {
        "\($0), \($1)"
    }
    .dropFirst()

print(csv)
