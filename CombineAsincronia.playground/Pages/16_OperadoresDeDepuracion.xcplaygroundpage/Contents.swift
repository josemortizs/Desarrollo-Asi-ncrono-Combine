import UIKit
import Combine

let imagenesPublisher = ["Alias", "Alien", "BasicInstinct", "Paquito", "Aliens", "AmazingStories", "BoysFromBrazil", "AmericanTail"].publisher

class ImageLogger:TextOutputStream {
    func write(_ string: String) {
        print("Recibidos datos \(string)")
    }
}

imagenesPublisher
    .tryCompactMap { file in
        if let ruta = Bundle.main.url(forResource: file, withExtension: "jpg") {
            return try Data(contentsOf: ruta)
        } else {
            return nil
        }
    }
    .handleEvents(receiveOutput: { print("Total de datos \($0.count)") })
    .breakpoint(receiveOutput: { $0.count == 0 })
    .compactMap { dataImage in
        UIImage(data: dataImage)
    }
    .print("Control post CompactMap", to: ImageLogger())
    .collect(2)
    .sink { completion in
        switch completion {
        case .finished:
            print("Ha finalizado la descarga")
        case .failure(let error):
            print("Error en la descarga de imagen \(error)")
        }
    } receiveValue: { images in
        images.forEach { image in
            print("Collect \(image)")
            image
        }
    }

