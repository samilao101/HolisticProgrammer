//
//  ReflectionView.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 3/2/22.
//

import SwiftUI

struct ReflectionView: View {
    
    
    let text: String
  
    
    
    var body: some View {
        ZStack{
        Circle()
            .frame(width: 60)
            .foregroundColor(Color(red: 252/255, green: 194/255, blue: 0))
            .shadow(color: .black, radius: 10, x: 5, y: 5  )
        
            VStack(alignment: .center, spacing: 10){
                
                Circle()
                    .frame(width: 10)
                    .foregroundColor(Color(red: 252/255, green: 194/255, blue: 0))
                    .shadow(color: .black, radius: 5, x: 5, y: 5  )
                    .padding()
                Spacer()
            }.frame(width: 60, height: 60)
            
            Text(text)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.black)
        }
    }
}

struct ReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionView(text: "3/2/22")
    }
}
