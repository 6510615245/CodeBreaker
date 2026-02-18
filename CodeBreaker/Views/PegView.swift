//
//  PegView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 28/1/2569 BE.
//

import SwiftUI

struct PegView: View {
    // MARK: Data in
    let peg: Peg
    
    // MARK: - body
    var body: some View {
        let pegShape = Circle()
//        RoundedRectangle(cornerRadius: 10)
        pegShape
//                .overlay {
//                    if peg == Code.missing {
//                        pegShape
//                            .strokeBorder(Color.gray)
//                    }
//                }
                .contentShape(pegShape) // click area
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(peg)
            
        
    }
}

#Preview {
    PegView(peg: .red)
        .padding()
}
