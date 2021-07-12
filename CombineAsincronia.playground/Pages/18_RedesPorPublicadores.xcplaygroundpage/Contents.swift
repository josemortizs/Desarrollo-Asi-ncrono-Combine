import UIKit
import Combine

final class SteveJobs {
    var image:UIImage?
    var subscribers = Set<AnyCancellable>()
    let url = URL(string: "https://i.blogs.es/f7b0ed/stee-jobs/2560_3000.jpg")!

    func getJobs() {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in // tryMap, importante, para poder usar throw URLError en la línea 16
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    return data
                } else {
                    throw URLError(.badURL)
                }
            }
            .compactMap { UIImage(data: $0) }
            .replaceError(with: UIImage(named: "steve-jobs.jpg", in: .main, with: .none)) // Si la llamada falla se carga esta imagen
            .assign(to: \.image, on: self)
            .store(in: &subscribers)
    }
}

let jobs1 = SteveJobs()
jobs1.getJobs()

sleep(1)

jobs1.image
