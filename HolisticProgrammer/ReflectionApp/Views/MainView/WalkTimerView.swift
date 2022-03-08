//
//  Reflection.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 2/18/22.
//

import SwiftUI
import SpriteKit

struct WalkTimerView: View {
    
    let dateFormatter = DateFormatter(timeStyle: .short)
    
    //@StateObject private var vm: ReflectionViewModel
    @ObservedObject var walk: ReflectionViewModel
    
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
                
                
//                WalkButton(state: walk.state){
//                    if walk.state == .readyToStart {
//                        walk.start()
//                    }
//                }
                startButton
                
                VStack {
                    
                    Spacer()
                    if walk.state == .inProgress {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 140, height: 60)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.gray)
                            TimerView(counter: walk.secondsRemaining)
                        }
                    }
                    
                }
                
                
            }
        }
        
        
        
        .onReceive(timer) { _ in
            if walk.state == .inProgress {
                walk.reduceCounter()
            }
        }
    }
}


extension WalkTimerView {
    
    
    private var startButton: some View {
        
        
        Button {
            
            if walk.state == .readyToStart {
                walk.getCurrentLocation()
            }
            
        } label: {
            ZStack {
                
                switch walk.state {
                    
                case .readyToStart:
                    
                    ButtonView(text: "Ready?", color: .blue)
                    
                case .walkingAway:
                    
                    ZStack{
                        ProgressCircle(color: .orange, completion: walk.percentFromStart)
                        ButtonView(text: "Step Away", color: .yellow)
                    }
                    
                    
                case .inProgress:
                    
                    VStack{
                        ZStack {
                            ProgressCircle(color: .blue, completion: walk.percentOfTimeWalking)
                            ButtonView(text: "Walking", color: .green)
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                case .complete:
                    
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
