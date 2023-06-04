//
//  DownloadJsonWithCombineBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 4.06.2023.
//

import SwiftUI
import Combine


struct PostModel2 : Identifiable , Codable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

class DownloadWithCombineViewModel : ObservableObject{
    
    @Published var posts : [PostModel2] = []
    var cancelebles = Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        //Combine Discution
        /*
         // 1- sign up for montly subscripttion
         // 2- company would made package behide de seen
         // 3- recvie the package at front door
         // 4- check the box isn't damage
         // 5- open the box and check that item is correct
         // 6- use the items
         // 7- canclable at any time
         
         
         // 1- create publisher
         // 2- subscribe the publisher into background thread by "dataTaskPublisher"
         // 3- recive on main thread
         // 4- try map  (chack data is correct)
         // 5- Decode data into postModel
         // 6- Sink ( put the item into app)
         // 7- Store (call cancle when needed)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on:  DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handelOutPut)
        //use func insted of impiliment here
        //            .tryMap { (data , response) -> Data in
        //
        //                guard
        //                    let response = response as? HTTPURLResponse ,
        //                    response.statusCode >= 200 && response.statusCode < 300
        //                else {
        //                    throw URLError( .badServerResponse)
        //                }
        //
        //                return data
        //            }
            .decode(type: [PostModel2] .self, decoder: JSONDecoder())
        //in the case of error we can use replace error and change sink like this
            .replaceError(with: [] )// when error happen return [])
            .sink( receiveValue:
                    { [weak self] (returnedPost) in
                self?.posts = returnedPost
                
            })
        // if we use replace error we dont need use Sink like below
        //            .sink { compeletion in
        //
        //                //handel success and error
        //                switch compeletion{
        //                    case .finished :
        //                        print("compeletion: \(compeletion)")
        //                    case .failure(let error ) :
        //                        print("There was an error \(error)")
        //                }
        //
        //            } receiveValue: { [weak self] (returnedPost) in
        //                self?.posts = returnedPost
        //            }
            .store(in: &cancelebles)
        
    }
    
    func handelOutPut(output : URLSession.DataTaskPublisher.Output) throws -> Data{
        guard
            let response = output.response as? HTTPURLResponse ,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError( .badServerResponse)
        }
        
        return output.data
    }
    
}
struct DownloadJsonWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List{
            ForEach( vm.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    
                    Text(post.body)
                        .foregroundColor(.gray)
                    
                }
                .frame(maxWidth : .infinity,  alignment: .leading)
            }
        }
    }
}

struct DownloadJsonWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadJsonWithCombineBootcamp()
    }
}
