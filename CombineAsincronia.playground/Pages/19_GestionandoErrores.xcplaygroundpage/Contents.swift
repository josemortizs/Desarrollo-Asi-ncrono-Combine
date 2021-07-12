import SwiftUI
import Combine

enum Department: String, Codable {
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

struct EmpleadosModel:Codable, Identifiable {
    let id:Int
    let username:String
    let first_name:String
    let last_name:String
    let gender:Gender
    let email:String
    let department:Department
    let address:String
    let avatar:URL
}

let urlEmpleados = URL(string: "https://acoding.academy/testData/EmpleadosData.json")!
let urlTest200_5 = URL(string: "https://httpstat.us/200?sleep=5000")!
let urlTest404 = URL(string: "https://httpstat.us/404")!


enum NetworkErrors:Error {
    case general(String)
    case timeout(String)
    case notFound(String)
    case badConnection(String)
}

var subscribers = Set<AnyCancellable>()

//let configuration = URLSessionConfiguration.ephemeral
//configuration.timeoutIntervalForRequest = 3
//let session = URLSession(configuration: configuration)

URLSession.shared.dataTaskPublisher(for: urlEmpleados)
    .mapError { error -> NetworkErrors in // Sirve para "transformar" los errores del servicio por los que nosotros creemos
        if error.errorCode == -1001 {
            return .timeout(error.localizedDescription)
        } else {
            return .general(error.localizedDescription)
        }
    }
    .retry(3) // Antes de "propagar" el error, intentará realizar la conexión 3 veces
    .timeout(.seconds(3), scheduler: RunLoop.current, options: nil) {
        .timeout("Ha tardado más de 3 segundos")
    }
    .tryMap { (data, response) -> Data in
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.badConnection("Conexión erronea")
        }
        if response.statusCode == 200 {
            return data
        } else {
            throw NetworkErrors.notFound("Status code \(response.statusCode)")
        }
    }
    .decode(type: [EmpleadosModel].self, decoder: JSONDecoder())
    .sink { completion in
        if case .failure(let error) = completion,
           let networkErr = error as? NetworkErrors {
            switch networkErr {
            case .general(let mensaje):
                print("Error general \(mensaje)")
            case .timeout(let mensaje):
                print("Timeout \(mensaje)")
            case .notFound(let mensaje):
                print("Not Found \(mensaje)")
            case .badConnection(let mensaje):
                print("Bad connection \(mensaje)")
            }
        }
    } receiveValue: { empleados in
        print(empleados.first!)
    }
    .store(in: &subscribers)

