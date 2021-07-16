import SwiftUI
import Combine
import PlaygroundSupport

let dateFormat:DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "es_ES")
    formatter.dateStyle = .none
    formatter.timeStyle = .medium
    return formatter
}()

final class ClockVM:ObservableObject {
    @Published var hora = dateFormat.string(from: Date())
    
    var subscribers = Set<AnyCancellable>()
    
    init() {
        Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
            .autoconnect()
            .map { dateFormat.string(from: $0) }
            .assign(to: \.hora, on: self)
            .store(in: &subscribers)
    }
}

struct ClockView:View {
    @ObservedObject var clockVM = ClockVM()
    
    @State var horaPublished = dateFormat.string(from: Date())
    @State var horaOWC = dateFormat.string(from: Date())
    
    var body: some View {
        VStack {
            Text("Desde el PUBLISHED")
                .font(.headline)
            Text("\(clockVM.hora)")
                .frame(maxWidth: .infinity)
            Text("Desde el PUBLISHER")
                .font(.headline)
            Text("\(horaPublished)")
                .frame(maxWidth: .infinity)
                .onReceive(clockVM.$hora) { time in
                    horaPublished = time
                }
            Text("Desde el OBJECT WILL CHANGE")
                .font(.headline)
            Text("\(horaOWC)")
                .frame(minWidth: 300)
                .onReceive(clockVM.objectWillChange) {
                    horaOWC = clockVM.hora
                }
        }
    }
}

PlaygroundPage.current.setLiveView(ClockView())
