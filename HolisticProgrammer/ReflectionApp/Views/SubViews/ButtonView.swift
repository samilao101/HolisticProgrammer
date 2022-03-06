//
//  ButtonView.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 3/1/22.
//

import SwiftUI

struct ButtonView: View {
    
    let text: String
    let color: Color
    
    var body: some View {
        Circle()
            .frame(width: 150)
            .foregroundColor(color)
            .shadow(color: .black, radius: 10, x: 5, y: 5  )
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Ready?", color: .black)
    }
}
