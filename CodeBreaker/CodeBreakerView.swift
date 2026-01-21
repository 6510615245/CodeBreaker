//
//  ContentView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 14/1/2569 BE.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game: CodeBreaker = CodeBreaker()
    
    var body: some View {
        VStack{
//            pegs(colors: [.red, .black, .green, .orange])
//            pegs(colors: [.red, .blue, .green, .blue])
//            pegs(colors: [.red, .green, .blue, .orange])
//            pegs(colors: [.orange, .black, .green, .orange])
            
            view(for: game.masterCode)
                .opacity(0)
            view(for: game.guess)
            
            ScrollView {
                
                ForEach(game.attempts.indices.reversed(), id: \.self) {
                    index in view(for: game.attempts[index])
                }
            }
            Button("Guess") {
                game.attemptGuess()
            }
        }
        .padding()
    }
    
    var guessBotton: some View {
        Button("Guess"){
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
//        let colors: Array<Color> = [.red, .black, .green, .orange]
//        let colors = [Color.red, .black, .green, .orange]
//        let colors: [Color] = [.red, .black, .green, .orange]
        return HStack{
            ForEach(code.pegs.indices, id: \.self) {
                index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }
        
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessBotton
                    }
                }
            
            
        }
    }
    
}

#Preview {
    CodeBreakerView()
}
