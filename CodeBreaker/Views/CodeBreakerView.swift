//
//  ContentView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 14/1/2569 BE.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var game: CodeBreaker = CodeBreaker()
    @State private var selection: Int = 0
    
    //MARK: - body
    var body: some View {
        VStack{
//            pegs(colors: [.red, .black, .green, .orange])
//            pegs(colors: [.red, .blue, .green, .blue])
//            pegs(colors: [.red, .green, .blue, .orange])
//            pegs(colors: [.orange, .black, .green, .orange])
            if game.isOver {
                view(for: game.masterCode)
            }
            if !game.isOver {
                view(for: game.guess)
            }
//            view(for: game.masterCode)
//                .opacity(game.isOver ? 1 : 0)
//            view(for: game.guess)
            
            ScrollView {
                ForEach(game.attempts.indices.reversed(), id: \.self) {
                    index in view(for: game.attempts[index])
                }
            }
//            Button("Guess") {
//                game.attemptGuess()
//            }
            PegChooserView(choices: game.pegChoices) {
                peg in game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.guess.pegs.count
            }
        }
        .padding()
    }
    
    var guessBotton: some View {
        Button("Guess"){
            withAnimation {
                selection = 0
                game.attemptGuess()
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    struct GuessButton {
        static let maximumFontSize: CGFloat = 80
        static let minimumFontSize: CGFloat = 8
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
    func view(for code: Code) -> some View {
//        let colors: Array<Color> = [.red, .black, .green, .orange]
//        let colors = [Color.red, .black, .green, .orange]
//        let colors: [Color] = [.red, .black, .green, .orange]
        return HStack{
            CodeView(code: code,selection: $selection)
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
