import UIKit
import Combine

let imagenesPublisher = ["Alias", "Alien", "BasicInstinct", "Paquito", "Aliens", "AmazingStories", "BoysFromBrazil", "AmericanTail"].publisher

imagenesPublisher
    .tryCompactMap { file in
        if let ruta = Bundle.main.url(forResource: file, withExtension: "jpg") {
            return try Data(contentsOf: ruta)
        } else {
            return nil
        }
    }
    .compactMap { dataImage in
        UIImage(data: dataImage)
    }
    .sink { completion in
        if case .failure(let error) = completion {
            print("Ha habido un error \(error)")
        }
    } receiveValue: { image in
        print("Normal \(image)")
        image
    }

imagenesPublisher
    .tryCompactMap { file in
        if let ruta = Bundle.main.url(forResource: file, withExtension: "jpg") {
            return try Data(contentsOf: ruta)
        } else {
            return nil
        }
    }
    .compactMap { dataImage in
        UIImage(data: dataImage)
    }
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

