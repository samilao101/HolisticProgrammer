//
//  StorageViewModel.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 3/2/22.
//

import Foundation
import CoreData


class StorageViewModel : ObservableObject {
    
    let container: NSPersistentContainer
    @Published var reflections: [ReflectionEntity] = []
    
    init() {
        
        container = NSPersistentContainer.init(name: "ReflectionsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("There was an error loading the data: \(error)")
            } else {
                print("Successfully loaded CoreData")
            }
        }
        
        fetchReflections()
    }
    
    func fetchReflections() {
        
        let request = NSFetchRequest<ReflectionEntity>(entityName: "ReflectionEntity")
        
        do {
            
            reflections = try container.viewContext.fetch(request)
            
        } catch(let error) {
            
            print("Error fetching containers: \(error)")
            
        }
        
    }
    
    func addReflection() {
        
        let newReflection = ReflectionEntity(context: container.viewContext)
        newReflection.dateCompleted = Date()
        
        saveData()
    }
    
    func saveData() {
        do {
            
        try container.viewContext.save()
        fetchReflections()
        } catch(let error) {
            
            print("Error saving data. \(error)")
            
        }
        
    }
    
    
    
    
}
