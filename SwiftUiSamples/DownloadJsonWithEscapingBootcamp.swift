//
//  DownloadJsonWithEscapingBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 4.06.2023.
//

import SwiftUI

struct PostModel : Identifiable , Codable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

class DownloadWithEscapingViewModel : ObservableObject {
    
    @Published var post : [PostModel] = []
    
    init(){
        getPosts()
    }
    
    func getPost(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {return}
        
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.post.append(newPost)
                }
            }
            else{
                print("No data returned")
            }
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            // insted of this use ***
            //            guard let data = data else {
            //                print("No data")
            //                return
            //            }
            //
            //            guard error == nil else {
            //                print("Error : \(String(describing: error))")
            //                return
            //            }
            //
            //            guard let response  = response as? HTTPURLResponse else{
            //                print("Invalid Response")
            //                return
            //            }
            //
            //            guard response.statusCode >= 200 && response.statusCode < 300 else {
            //                print("Response status code is : \(response.statusCode)")
            //                return
            //            }
            
        }.resume()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.post = newPosts
                }
            }
            else{
                print("No data returned")
            }
        }

    }
    
    
    func downloadData (fromURL url : URL , comleletionHandler : @escaping (_ data : Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data ,
                error == nil ,
                let response  = response as? HTTPURLResponse ,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error in getting data")
                comleletionHandler(nil)
                return
            }
            
            comleletionHandler(data)
            
            
        }.resume()
    }
}

struct DownloadJsonWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.post){ post in
                VStack( alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    
                    Text(post.body )
                        .foregroundColor(.gray)
                }
                .frame(maxWidth : .infinity , alignment: .leading)
            }
        }
    }
}

struct DownloadJsonWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadJsonWithEscapingBootcamp()
    }
}
