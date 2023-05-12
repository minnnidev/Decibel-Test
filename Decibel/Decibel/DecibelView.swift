//
//  ContentView.swift
//  Decibel
//
//  Created by 김민 on 2023/05/13.
//

import SwiftUI
import AVFoundation

struct DecibelView: View {
    @StateObject private var soundMeter = SoundMeter()
    @State private var limit: Float = 90.0 // 예시 80
    @State private var isCompleted = false
    @State private var progressViewTintColor: Color = .blue

    var body: some View {
        VStack {
            Text(soundMeter.decibels + 100 >= limit ? "성공" : String(format: "%.2f dB", soundMeter.decibels + 100) )
                .font(.title)
                .foregroundColor(isCompleted ? .red : .blue)
                .padding()
            
            ProgressView(value: min(soundMeter.decibels + 100, limit), total: limit)
                .tint(progressViewTintColor)
                .padding([.leading, .trailing], 30)
                .onChange(of: soundMeter.decibels + 100) { newValue in
                    if newValue >= limit {
                        progressViewTintColor = .red
                        isCompleted = true
                        soundMeter.stop()
                    }
                }
        }
        .onAppear {
            try? soundMeter.start()
        }
        .onDisappear {
            soundMeter.stop()
            soundMeter.decibels = 0.0
        }
    }
}

struct DecibelView_Previews: PreviewProvider {
    static var previews: some View {
        DecibelView()
    }
}
