//
//  CodeView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 28/1/2569 BE.
//

import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View{
    //    MARK: Data in
    let code: Code
    
    //    MARK: Data Shared by Me
    @Binding var selection: Int
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    //    MARK: Data Owned by Me
    @Namespace private var selectionNameSpace
    
    init(code: Code,
         selection: Binding<Int> = .constant(-1),
         @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    //    MARK: - body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) {
            index in PegView(peg: code.pegs[index])
                .padding(Selection.border)
                .background {
                    Group {
                        if selection == index, code.kind == .guess {
//                            Circle()
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Selection.color)
                                .matchedGeometryEffect(id: "selection", in: selectionNameSpace)
                        }
                    }
                    .animation(.easeInOut(duration: 3), value: selection)
                    
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(code.isHidden ? Color.gray : .clear)
                        .transaction { transaction in
                            if code.isHidden {
                                transaction.animation = nil
                            }
                        }
                }
                .onTapGesture {
                    if code.kind == .guess {
                        selection = index
                    }
                }
            }
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay{
                    ancillaryView()
                }
        }
    }
}

    
fileprivate struct Selection {
        static let border: CGFloat = 5
        static let color: Color = Color.gray(0.85)
}


extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

//#Preview {
//    CodeView()
//}
