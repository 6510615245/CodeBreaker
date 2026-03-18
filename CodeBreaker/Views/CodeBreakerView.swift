//
//  ContentView.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 14/1/2569 BE.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Shared with Me
    let game: CodeBreaker
    
    // MARK: Data Owned by Me
    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRecentMarkers = false
  
    //MARK: - body
    var body: some View {
        VStack {
//                        pegs(colors: [.red, .black, .green, .orange])
//                        pegs(colors: [.red, .blue, .green, .blue])
//                        pegs(colors: [.red, .green, .blue, .orange])
//                        pegs(colors: [.orange, .black, .green, .orange])
//            if game.isOver {
//                view(for: game.masterCode)
//            }
//            if !game.isOver {
//                view(for: game.guess)
//            }
//                        view(for: game.masterCode)
//                            .opacity(game.isOver ? 1 : 0)
//                        view(for: game.guess)
      
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                CodeView(code: game.guess, selection: $selection) { guessBotton }
//                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)
                }
                                
            
                ForEach(game.attempts, id: \.pegs) {
                    attempt in CodeView(code: attempt) {
                        let showMarkers = !hideMostRecentMarkers || attempt.pegs != game.attempts.first?.pegs
                        if showMarkers {
                            MatchMarkers(matches: attempt.matches)
                        }
                    }
                    .transition(.attempt(game.isOver))
                            
                }
            }
            if !game.isOver {
                PegChooserView(choices: game.pegChoices) {
                    peg in game.setGuessPeg(peg, at: selection)
                    selection = (selection + 1) % game.guess.pegs.count
                }
                .transition(AnyTransition.pegChooser)
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Restart", systemImage: "arrow.circlepath") {
                    withAnimation(.restart) {
                        restarting = true
                        game.restart()
                    }
                    completion: {
                        withAnimation(.restart) {
                            restarting = false
                        }
                    }
                }
            }
            ToolbarItem(placement: .automatic) {
                ElapsedTime(
                    startTime:game.startTime,
                    endTime: game.endTime)
                .flexibleSystemFont()
                .monospaced()
                .lineLimit(1)
            }
        }
        .padding()
    }
    
    
    var guessBotton: some View {
        Button("Guess"){
            withAnimation(.guess) {
                selection = 0
                game.attemptGuess()
                hideMostRecentMarkers = true
            } completion: {
                withAnimation(.guess) {
                    hideMostRecentMarkers = false
                }
            }
        }
//        .font(.system(size: GuessButton.maximumFontSize))
//        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
//    struct GuessButton {
//        static let maximumFontSize: CGFloat = 80
//        static let minimumFontSize: CGFloat = 8
//        static let scaleFactor = minimumFontSize / maximumFontSize
//    }
    
//    func view(for code: Code) -> some View {
////        let colors: Array<Color> = [.red, .black, .green, .orange]
////        let colors = [Color.red, .black, .green, .orange]
////        let colors: [Color] = [.red, .black, .green, .orange]
//        return HStack{
//            CodeView(code: code,selection: $selection)
//            MatchMarkers(matches: code.matches)
//                .overlay {
//                    if code.kind == .guess {
//                        guessBotton
//                    }
//                }
//            
//            
//        }
//    }
    
}



#Preview {
    @Previewable @State var game = CodeBreaker(name: "Preview", pegChoices: [.blue, .red, .orange])
    NavigationStack {
        CodeBreakerView(game: game)
    }
}
