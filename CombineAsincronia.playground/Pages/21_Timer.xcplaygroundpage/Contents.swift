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

struct MyClock:View {
    let timer = Timer
        .TimerPublisher(interval: 1, runLoop: .main, mode: .default)
        .autoconnect()
        .map { dateFormat.string(from: $0) }
    
    @State var hora = dateFormat.string(from: Date())
    
    var body: some View {
        VStack {
            Text("\(hora)")
                .frame(width: 200)
        }
        .onReceive(timer) { time in
            hora = time
        }
    }
}

PlaygroundPage.current.setLiveView(MyClock())
