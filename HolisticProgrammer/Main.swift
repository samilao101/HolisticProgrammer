//
//  ContentView.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 2/18/22.
//

import SwiftUI

struct Main: View {
   
    @StateObject var storage = StorageViewModel()
    
    var body: some View {
       
        WalkTimerView(walk: storage)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
