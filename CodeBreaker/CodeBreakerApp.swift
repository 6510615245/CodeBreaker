//
//  CodeBreakerApp.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 14/1/2569 BE.
//

import SwiftUI
import SwiftData

@main
struct CodeBreakerApp: App {
    var body: some Scene {
        WindowGroup {
            GameChooserView()
                .modelContainer(for: CodeBreaker.self)
        }
    }
}
