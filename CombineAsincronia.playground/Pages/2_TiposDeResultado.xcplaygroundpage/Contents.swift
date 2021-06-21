import UIKit

// TIPOS DE RESULTADO

enum ErroresSuma: Error {
    case arrayVacio, datoInvalido
}

func sumaNumeros(nums: [Int]) -> Result<Int, ErroresSuma> {
    if nums.isEmpty {
        return .failure(.arrayVacio)
    }
    
    var suma = 0
    for num in nums {
        suma += num
    }
    
    return .success(suma)
}

let array = [1, 2, 3, 4, 5]
let suma = sumaNumeros(nums: array)

switch suma {
case .success(let sum):
    print("El resultado es: \(sum)")
case .failure(let error):
    print("El error ha sido: \(error)")
}

if case .success(let sum) = suma {
    print(sum)
}
