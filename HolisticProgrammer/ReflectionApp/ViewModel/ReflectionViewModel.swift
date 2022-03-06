//
//  ReflectionViewModel.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 2/18/22.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI



enum AppState {
    
    case readyToStart
    case walkingAway
    case walking
    case doneWalking
}

enum BallTypes {
    
    case blue  //Accomplished a reflection
    case red   // Missed a day
    
}


class ReflectionViewModel : ObservableObject {
    
    
    let locationManager = ReflectionLocationManager()
    @Published var distanceFromStart = CLLocationDistance()
    @Published var state: AppState = .readyToStart
    
    //distance limit that activates the counter
    var limit: Double = 100.00
    //how long in seconds the timer goes
    var seconds: Double = 1500
    //Counter that is reduce by one second after the person is walking away.
    var counter: Int = 1500
    
    @Published var percentFromStart: CGFloat = 0.0
    @Published var percentOfTimeWalking: CGFloat = 0.0
    
    var dateRange : [Date] = []
    
    var balls: [BallTypes] = []
    
    var dateFormateter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
    
    let blueName = Notification.Name(blueBallNotification)
    let redName = Notification.Name(redBallNotification)
    
    @Published var reflections: [ReflectionEntity] = []
    
    var cancellables = Set<AnyCancellable>()
    
    let storage : StorageViewModel
    
    init(storage: StorageViewModel) {
        self.storage = storage
        self.getEntities()
        self.convertReflectionsToBalls()
        
    }
    
    //Converts the stored dates reflections were done, converts them to an array of dates as string, then creates a range of the first and last day reflections were done,to see which days were missed, to give the user either blue balls the days they reflected and red balls the days they missed.
    
    func convertReflectionsToBalls() {
        
        
        guard var first = reflections.first?.dateCompleted else { return }
        let last = Date()
        
        while first <= last {
            dateRange.append(first)
            first = Calendar.current.date(byAdding: .day, value: 1, to: first)!
        }
        
        let datesAsString = dateRange.map {  dateFormateter.string(from: $0 )}
        let reflectionsAsString = reflections.map { dateFormateter.string(from: $0.dateCompleted! )  }
     
        
        datesAsString.forEach { date in
            
            if reflectionsAsString.contains( date) {
                
                let datesReflected = reflectionsAsString.filter {$0 == date }
                
                datesReflected.forEach { _ in
                    balls.append(.blue)
                }

            } else {
                //days missed
                balls.append(.red)
            }
            
            
        }
        
        loadBalls()
    }
    
    //Sends the appropiate balls to the game scene to create and post to screen
    func loadBalls() {
        
        
        for i in balls.indices {
         
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    
                   
                    if self.balls[i] == .blue {
                        NotificationCenter.default.post(name: self.blueName, object: nil)
                    }
                    
                    if self.balls[i] == .red {
                        
                        NotificationCenter.default.post(name: self.redName, object: nil)

                    }
                }
        
        }
    }
    
    func getCurrentLocation() {
        locationManager.checkIfLocationServicesIsEnabled()
        getUpdatedDistance()
        
    }
    
    func getUpdatedDistance() {
        
        self.state = .walkingAway
        
        locationManager.$distance
            .sink { completion in
                
                switch completion {
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                case .finished:
                    break
                    
                }
            } receiveValue: { [weak self] distance in
                
                self?.distanceFromStart = distance
                
                if self?.state != .walking || self?.state != .doneWalking {
                    
                    self?.checkIfWalking()

                }
                

            }.store(in: &cancellables)

    }
    
    func checkIfWalking() {
        if Double(distanceFromStart) > limit {
            state = .walking
            locationManager.stopLoadingLocations()
        } else {
            percentFromStart = distanceFromStart/limit
        }
    }
    
    func reduceCounter() {
     
        
     
        if counter < 1 {
           
            state = .doneWalking
            storage.addReflection()
            self.getEntities()
            NotificationCenter.default.post(name: self.blueName, object: nil)

            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.state = .readyToStart
                self.counter = 10
            }
            
        } else {
            counter -= 1
            percentOfTimeWalking = CGFloat(Double(counter)/seconds)
        }
    }
    
    func getEntities() {
        
        self.reflections = storage.reflections
        
    }
  
    
    
    
}
