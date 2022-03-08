//
//  TimerView.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 3/1/22.
//

import SwiftUI

struct TimerView: View {
    
    let counter: Int
    
    var body: some View {
        HStack{
            Text(String(counter % 3600 / 60))
                .foregroundColor(.white)
            Text(":")
            Text(String(counter % 3600 % 60))
                .foregroundColor(.white)
        }
        .font(.system(size: 24))
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(counter: 24)
    }
}
