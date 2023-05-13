//
//  CircularProgressView.swift
//  Decibel
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct CircularProgressView: View {
    @State var progress: Float = 30.0
    @State var limit: Float = 70.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundColor(Color(.systemGray5))
            Circle()
                .trim(from: 0.0, to: CGFloat(progress / limit))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.orange)
            Text("\(progress)")
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
    }
}
