//
//  ProgressCircle.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 3/1/22.
//

import SwiftUI

struct ProgressCircle: View {
    
    let color: Color
    let completion: CGFloat
    
    var body: some View {
        Circle()
            .stroke(Color.white.opacity(0.3), style: StrokeStyle(lineWidth: 30))
                .frame(width: 180)
        Circle()
            .trim(from: 0, to: completion)
            .stroke(color, style: StrokeStyle(lineWidth: 30))
            .rotationEffect(.init(degrees: -90))
            .frame(width: 180)
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(color: .green, completion: 0.5)
    }
}
