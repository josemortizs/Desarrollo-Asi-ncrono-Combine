import UIKit
import Combine

let url = URL(string: "https://i.blogs.es/f7b0ed/steve-jobs/2560_3000.jpg")!

enum ErroresRed:Error {
    case general
    case notFound(Int)
    case imagenNoValida
}

func getImage(url:URL) -> Future<Data, ErroresRed> {
    .init { promise in
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                promise(.failure(.general))
                return
            }
            if response.statusCode == 200 {
                promise(.success(data))
            } else {
                promise(.failure(.notFound(response.statusCode)))
            }
        }.resume()
    }
}

var subscribers = Set<AnyCancellable>()

getImage(url: url)
    .compactMap { UIImage(data: $0) }
    .sink { completion in
        switch completion {
        case .finished:
            print("Finalizado con éxito")
        case .failure(let error):
            if case .notFound(let code) = error {
                print("No encontrada con estado \(code)")
            } else {
                print("Ha habido un error \(error)")
            }
        }
    } receiveValue: { image in
        print(image)
        image
    }
    .store(in: &subscribers)

