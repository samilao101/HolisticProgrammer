//
//  Reflection.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 2/18/22.
//

import SwiftUI
import SpriteKit

struct Reflection: View {
    
    var dateFormateter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    @StateObject private var vm: ReflectionViewModel
    
    init(storage: StorageViewModel) {
        
        _vm =  StateObject(wrappedValue: ReflectionViewModel(storage: storage))
       
    }
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        scene.createObservers()
        return scene
    }
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        GeometryReader { geo in
         
            ZStack {
                
                SpriteView(scene: scene)
                    .frame(width: geo.size.width, height: geo.size.height)
                    

                startButton
                
                
                VStack {
                    
                Spacer()
                    if vm.state == .walking {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 140, height: 60)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.gray)
                            TimerView(counter: vm.counter)
                        }
                    }
                
                }
                
              
            }
        }
          
            
            
        .onReceive(timer) { _ in
            
            
            if vm.state == .walking {
                vm.reduceCounter()
            }
            
        
        }
    }
}


extension Reflection {
   
    
    private var startButton: some View {
       
        
        Button {
            
            if vm.state == .readyToStart {
            vm.getCurrentLocation()
            }
            
        } label: {
            ZStack {
                
                switch vm.state {
                    
                case .readyToStart:
                  
                    ButtonView(text: "Ready?", color: .blue)
                    
                case .walkingAway:
                    
                    ZStack{
                        ProgressCircle(color: .orange, completion: vm.percentFromStart)
                        ButtonView(text: "Step Away", color: .yellow)
                    }
                    
                    
                case .walking:
                    
                    VStack{
                        ZStack {
                        ProgressCircle(color: .blue, completion: vm.percentOfTimeWalking)
                        ButtonView(text: "Walking", color: .green)
                        }
                        
                      
                        
                        
                    }
                    
                    
                    
                case .doneWalking:
                   
                    ButtonView(text: "Done", color: .blue)
                    
                }
                
            
                
            }
        }
    }
    
    
}


//struct Reflection_Previews: PreviewProvider {
//
//    @StateObject var storage = StorageViewModel()
//
//    static var previews: some View {
//        Reflection(storage: storage)
//    }
//}
