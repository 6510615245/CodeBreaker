//
//  ContentView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 14/1/2569 BE.
//

import SwiftUI

struct CodeBreakerView: View {
    var body: some View {
        VStack{
            pegs(colors: [.red, .black, .green, .orange])
            pegs(colors: [.red, .blue, .green, .blue])
            pegs(colors: [.red, .green, .blue, .orange])
            pegs(colors: [.orange, .black, .green, .orange])

        }
        .padding()
    }
    
    func pegs(colors: [Color]) -> some View {
//        let colors: Array<Color> = [.red, .black, .green, .orange]
//        let colors = [Color.red, .black, .green, .orange]
//        let colors: [Color] = [.red, .black, .green, .orange]
        return HStack{
            ForEach(colors.indices, id: \.self) {index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
            
        }
    }
    
}

#Preview {
    CodeBreakerView()
}
