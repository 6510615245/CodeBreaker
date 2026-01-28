//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 14/1/2569 BE.
//

import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

struct MatchMarkers: View {
//    MARK: Data in
    let matches: [Match]
    
//    MARK: - body
    var body: some View {
        HStack{
            VStack{
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            
            }
            VStack{
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    @ViewBuilder
    func matchMarker(peg: Int) -> some View {
//        let exactCount: Int = matches.count { match in return match == .exact }
        let exactCount = matches.count { $0 == .exact }
//        let foundCount: Int = matches.count { match in return match != .nomatch }
        let foundCount = matches.count { $0 != .nomatch }
        
//        print(exactCount)
//        print(foundCount)
        
        Circle()
            .fill(peg < exactCount ? Color.primary : .clear)
            .strokeBorder(peg < foundCount ? Color.primary : .clear, lineWidth: 2)
            .aspectRatio(contentMode: .fit)
    }
    
}

#Preview {
    MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        .padding()
}
