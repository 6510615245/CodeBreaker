//
//  UIExtension.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 18/2/2569 BE.
//

import SwiftUI

extension Animation {
    static let codeBreaker = Animation.bouncy.speed(0.75)
    static let restart = Animation.codeBreaker
    static let guess =  Animation.codeBreaker
    static let selection =  Animation.codeBreaker
}

extension AnyTransition {
    static func attempt(_ isOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: isOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing)
        )
    }
    static let pegChooser = AnyTransition.offset(x: 0, y: 250)
}

extension View {
    func flexibleSystemFont(minimum: CGFloat = 8, maximum: CGFloat = 80) -> some
    View {
        self
            .font(.system(size: maximum))
            .minimumScaleFactor(minimum / maximum)
    
    }
}
