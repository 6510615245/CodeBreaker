//
//  PegChooserView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 28/1/2569 BE.
//

import SwiftUI

struct PegChooserView: View {
//    MARK: Data in
    let choices: [Peg]
    
//    let selection: Int
//    let pegCount: Int
//    let game: CodeBreaker
    
//     MARK: Data Out Function
    let onChoose: (Peg) -> Void
    
//    MARK: - body
    var body: some View {
        HStack {
            ForEach(choices, id: \.self) {
                peg in PegView(peg: peg)
                    .onTapGesture {
//                        game.setGuessPeg(peg, at: selection)
//                        selection = (selection + 1) % pegCount
                        onChoose(peg)
                    }
            }
        }
    }
}

//#Preview {
//    PegChooserView()
//}
