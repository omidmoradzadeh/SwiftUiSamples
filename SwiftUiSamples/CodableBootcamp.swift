//
//  CodableBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 3.06.2023.
//

import SwiftUI


struct CustomerModel : Identifiable , Decodable {
    let id: String
    let name : String
    let point : Int
    let isPrimium : Bool
    
    //Default initilizer
    init(id: String, name: String, point: Int, isPrimium: Bool) {
        self.id = id
        self.name = name
        self.point = point
        self.isPrimium = isPrimium
    }
    
    //Decodable initilizer
    enum CodingKeys: String , CodingKey {
        case id
        case name
        case point
        case isPrimium // can change = "is_Primium"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.point = try container.decode(Int.self, forKey: .point)
        self.isPrimium = try container.decode(Bool.self, forKey: .isPrimium)
    }
}

class CodableViewModel :  ObservableObject{
    @Published var customer : CustomerModel? =  nil //CustomerModel(id: "1", name: "omid", point: 5, isPrimium: true)
    
    init(){
        getDate()
    }
    
    func getDate(){
        guard let data = getJsonData() else {return}
        
        // print byte type
        //        print("Json Data :")
        //        print(data)
        //
        //print converted type
        //        let jsonString = String(data: data, encoding: String.Encoding.utf8)
        //        print(jsonString)
        
        
    
        
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dic = localData as? [String : Any] ,
//            let id = dic["id"] as? String  ,
//            let name = dic["name"] as? String ,
//            let point  = dic["point"] as? Int ,
//            let isPrimium = dic["isPrimium"] as? Bool{
//
//            let newCustomer = CustomerModel(id: id, name: name, point: point, isPrimium: isPrimium)
//            customer = newCustomer
//        }
        
        do{
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        }catch let error{
            print("Error : \(error)")
        }
    }
    
    func getJsonData() -> Data? {
        //make fake data
        let dictiniory : [String : Any] = [
            "id" : "12345",
            "name" : "omid" ,
            "point" : 5 ,
            "isPrimium" : true
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: dictiniory)
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer{
                Text("\(customer.id)")
                Text("\(customer.name)")
                Text("\(customer.point)")
                Text("\(customer.isPrimium.description)")
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
