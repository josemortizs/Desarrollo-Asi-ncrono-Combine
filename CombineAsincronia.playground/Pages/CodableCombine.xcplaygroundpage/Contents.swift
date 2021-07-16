import SwiftUI
import Combine

var subscribers = Set<AnyCancellable>()

struct Post:Identifiable, Codable {
    let id:Int
    
    struct Rendered:Codable {
        let rendered:String
    }
    
    let title:Rendered
    let excerpt:Rendered
    let jetpack_featured_media_url:URL
    let author:Int
}

struct Author:Identifiable, Codable {
    let id:Int
    let name:String
    
    struct AvatarURLs:Codable {
        let _96:URL
        
        enum CodingKeys: String, CodingKey {
            case _96 = "96"
        }
    }
    
    let avatar_urls:AvatarURLs
}

let url = URL(string: "https://applecoding.com/wp-json/wp/v2/posts")!
let urlAuthor = URL(string: "https://applecoding.com/wp-json/wp/v2/users")!

func getImagePublisher(url:URL) -> AnyPublisher<UIImage, Error> {
    URLSession.shared
        .dataTaskPublisher(for: url)
        .map(\.data)
        .compactMap { UIImage(data: $0) }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
}

func getAuthorPublisher(author:Int) -> AnyPublisher<Author, Error> {
    URLSession.shared
        .dataTaskPublisher(for: urlAuthor.appendingPathComponent("\(author)"))
        .map(\.data)
        .decode(type: Author.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let postPublisher = URLSession.shared
    .dataTaskPublisher(for: url)
    .map(\.data)
    .decode(type: [Post].self, decoder: JSONDecoder())
    .compactMap { $0.first }
    .share()
    .eraseToAnyPublisher()

let imagePublisher = postPublisher
    .flatMap { post in
        getImagePublisher(url: post.jetpack_featured_media_url)
    }

let authorPublisher = postPublisher
    .flatMap { post in
        getAuthorPublisher(author: post.author)
    }

let avatarAuthorPublisher = postPublisher
    .flatMap { post in
        getAuthorPublisher(author: post.author)
    }
    .flatMap { author in
        getImagePublisher(url: author.avatar_urls._96)
    }

Publishers.Zip4(postPublisher, imagePublisher, authorPublisher, avatarAuthorPublisher)
    .sink { completion in
        if case .failure(let error) = completion {
            print("Algo ha fallado \(error)")
        }
    } receiveValue: { post, image, author, avatar in
        print("Título : \(post.title.rendered)")
        print(image)
        image
        print("Autor : \(author.name)")
        print(avatar)
        avatar
    }
    .store(in: &subscribers)

