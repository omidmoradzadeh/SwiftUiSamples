//
//  CoreDataRelationBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 31.05.2023.
//

import SwiftUI
import CoreData

//3 Entities
//BussinesEntity
//DepartmentEntity
//EmployeeEntity

class CoreDataManager{
    static let instance = CoreDataManager() // Singleton
    
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error  = error{
                print("Error loading Core Data!\(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
            print("Save Suuccessfuly")
        }
        catch let error{
            print("Error \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationViewModel : ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var buissiness : [BussinessEntity] = []
    @Published var departments : [DepartmentEntity] = []
    @Published var employees : [EmployeeEntity] = []
    
    init(){
        getBussinesses()
        getDepartments()
        getEmployees()
    }
    
    
    func getBussinesses(){
        let request = NSFetchRequest<BussinessEntity>(entityName: "BussinessEntity")
        
        
        //Sort
        let sort = NSSortDescriptor(keyPath:  \BussinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        
        //Filter
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do{
            buissiness = try manager.context.fetch(request)
        }
        catch let error{
            print("Error in get Bussinesses \(error)")
        }
        
    }
    
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do{
            departments = try manager.context.fetch(request)
        }
        catch let error{
            print("Error in get Departments \(error)")
        }
        
    }
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do{
            employees = try manager.context.fetch(request)
        }
        catch let error{
            print("Error in get Employees \(error)")
        }
        
    }
    
    func getEmployees( forBussiness bussiness : BussinessEntity  ){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "bussiness == %@", bussiness)
        request.predicate = filter
        
        do{
            employees = try manager.context.fetch(request)
        }
        catch let error{
            print("Error in get Employees \(error)")
        }
        
    }
    
    
    func updateBussiness(){
        let existingBussines = buissiness[2]
        existingBussines.addToDepartments(departments[1])
        save()
    }
    
    
    func addBussiness(){
        let newBussiness = BussinessEntity(context: manager.context)
        newBussiness.name = "FaceBook"
        
        // Add Existing Department to new bussiness
        //newBussiness.departments = [departments[0] , departments[1]]
        
        //Add Existing Employies to the new bussiness
        //newBussiness.employees = [ employees[1]]
        
        // add new bussiness to an exisiting department
        //newBussiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new Bussiness to exisiting new employees
        //newBussiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment(){
        let newDepartment =  DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [buissiness[0] , buissiness[1] , buissiness[2]]
        
        //newDepartment.employees = [employees[1]]
        newDepartment.addToEmployees(employees[1])
        
        save()
    }
    
    func addEmployee(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 21
        newEmployee.dateJoined = Date.now
        newEmployee.name = "John"
        
        
        newEmployee.bussiness = buissiness[2]
        newEmployee.department = departments[1]
        
        save()
    }
    
    
    func deleteDepartment(){
        let department = departments[1]
        manager.context.delete(department)
        save()
    }
    
    func save(){
        buissiness.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.manager.save()
            self.getBussinesses()
            self.getDepartments()
            self.getEmployees()
        })
        
        
    }
}

struct CoreDataRelationBootcamp: View {
    
    @StateObject var vm = CoreDataRelationViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20) {
                    Button {
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.buissiness){ bussines in
                                
                                BussinessView(entity: bussines)
                                
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments){ department in
                                
                                DepartmentView(entity: department)
                                
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees){ employee in
                                
                                EmployeeView(entity: employee)
                                
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationBootcamp()
    }
}


struct BussinessView : View {
    
    let entity : BussinessEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Name : \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                
                ForEach(departments){ department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame( maxWidth: 300 , alignment: .leading)
        .background(.gray)
        .opacity(0.5)
        .cornerRadius(10)
        .shadow(radius: 10 )
    }
}


struct DepartmentView : View {
    
    let entity : DepartmentEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Name : \(entity.name ?? "")")
                .bold()
            
            if let businnesses = entity.businesses?.allObjects as? [BussinessEntity] {
                Text("Buissiness:")
                    .bold()
                
                ForEach(businnesses){ businness in
                    Text(businness.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame( maxWidth: 300 , alignment: .leading)
        .background(.green)
        .opacity(0.5)
        .cornerRadius(10)
        .shadow(radius: 10 )
    }
}


struct EmployeeView : View {
    
    let entity : EmployeeEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
            
            Text("Date Joined :\(entity.dateJoined ?? Date())")
            
            Text("Bussines:")
                .bold()
            
            Text(entity.bussiness?.name ?? "")
            
            Text("Department:")
                .bold()
            
            Text(entity.department?.name ?? "")
            
        }
        .padding()
        .frame( maxWidth: 300 , alignment: .leading)
        .background(.blue)
        .opacity(0.5)
        .cornerRadius(10)
        .shadow(radius: 10 )
    }
}
