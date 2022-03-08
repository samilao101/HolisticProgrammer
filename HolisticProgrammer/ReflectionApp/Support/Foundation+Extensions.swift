//
//  Foundation+Extensions.swift
//  HolisticProgrammer
//
//  Created by Michael Forrest on 08/03/2022.
//

import Foundation

extension DateFormatter{
    convenience init(timeStyle: DateFormatter.Style){
        self.init()
        self.timeStyle = timeStyle
    }
}
