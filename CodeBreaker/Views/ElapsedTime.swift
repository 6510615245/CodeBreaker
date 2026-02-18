//
//  ElapsedTime.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 18/2/2569 BE.
//

import SwiftUI

struct ElapsedTime: View {
    // MARK: Data In
    let startTime: Date
    let endTime:Date?
    
    var body: some View {
        if let endTime {
            Text(endTime, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        } else {
            Text(TimeDataSource<Date>.currentDate, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        }
    }
}

//#Preview {
//    ElapsedTime()
//}
