//
//  WalkButton.swift
//  HolisticProgrammer
//
//  Created by Michael Forrest on 08/03/2022.
//

import SwiftUI

struct WalkButton: View {
    var walk: ReflectionViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WalkButton_Previews: PreviewProvider {
    static var previews: some View {
        WalkButton(walk: Walk(state: .inProgress, secondsRemaining: 4))
    }
}
