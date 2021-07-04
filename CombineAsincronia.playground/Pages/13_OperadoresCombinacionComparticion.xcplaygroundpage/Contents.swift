import UIKit
import Combine

let pub1 = [1,2,3].publisher
let pub2 = [4,5,6].publisher

pub1
    .append(pub2)
    .sink { value in
        print("Append Pub2 : \(value)")
    }

pub1
    .prepend(pub2)
    .sink { value in
        print("Prepend Pub2 : \(value)")
    }

let sub1 = PassthroughSubject<Int, Never>()
let sub2 = PassthroughSubject<Int, Never>()

sub1
    .merge(with: sub2)
    .sink { completion in
        if case .finished = completion {
            print("Ha terminado")
        }
    } receiveValue: { value in
        print("Merge Pub1&Pub2 \(value)")
    }


let sub3 = PassthroughSubject<String, Never>()

sub3
    .combineLatest(sub2)
    .sink { value in
        print("Combine Latest Sub2 : \(value)")
    }

sub1.send(1)
sub1.send(2)
sub2.send(3)
sub1.send(4)
sub2.send(5)
sub1.send(6)
sub1.send(7)
sub1.send(completion: .finished)
sub2.send(8)
sub2.send(completion: .finished)

sub3.send("9")
sub3.send("10")
sub3.send("11")

let sub5 = PassthroughSubject<String, Never>()
let sub6 = PassthroughSubject<Int, Never>()

sub5
    .zip(sub6)
    .sink { value in
        print("ZIP Sub5&6 : \(value)")
    }

sub5.send("a")
sub5.send("b")
sub6.send(3)
sub5.send("c")
sub6.send(5)

