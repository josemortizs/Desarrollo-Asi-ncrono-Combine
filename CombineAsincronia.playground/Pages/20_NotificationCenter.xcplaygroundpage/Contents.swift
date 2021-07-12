import UIKit
import Combine

extension Notification.Name {
    static let myNotification = Notification.Name("MiNotificación")
}

final class ClaseEmisora {
    var timer:Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            NotificationCenter.default.post(name: .myNotification, object: "Mensaje secreto \(Int.random(in: 1...50))")
        }
    }
}

final class ClaseReceptora {
    var mensaje = "" {
        didSet {
            if !mensaje.isEmpty {
                print("Nuevo mensaje \(mensaje)")
            }
        }
    }
    
    var subscribers = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default
            .publisher(for: .myNotification)
            .compactMap { $0.object as? String }
            .assign(to: \.mensaje, on: self)
            .store(in: &subscribers)
    }
}

let emisor = ClaseEmisora()
let receptor = ClaseReceptora()


