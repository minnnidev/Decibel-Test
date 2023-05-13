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
    @State private var limit: Float = 40.0 // 예시 70
    @State private var isCompleted = false
    @State private var progressViewTintColor: Color = .blue

    var body: some View {
        VStack {
            Text("콧바람 장풍 불기 💨")
                .padding(.bottom, 20)
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .foregroundColor(Color(.systemGray5))
                Circle()
                    .trim(from: 0.0, to: CGFloat(soundMeter.decibels/limit))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(
                        (soundMeter.decibels/limit) <= 0.5 ? .green : (soundMeter.decibels/limit) >= 0.7 ? .red : .yellow
                    )
                    .rotationEffect(.degrees(270))
                    .animation(.linear, value: soundMeter.decibels/limit)
                    .onReceive(soundMeter.$decibels) { decibels in
                        if decibels >= limit {
                            withAnimation {
                                isCompleted = true
                                soundMeter.stop()
                            }
                        }
                    }
            }
            .frame(width: 200, height: 200)
            
            Text(
                (soundMeter.decibels/limit) <= 0.3 ? "부족해요" : (soundMeter.decibels/limit) >= 0.7 ? "완료" : "조금 더 세게 불어봐여"
            )
            .padding(.top, 20)
            .font(.system(size: 30))
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

extension DecibelView {
    
    private func changeToPercentage(_ decibel: Float) -> Float {
        let a = (decibel/limit) / 10
        print(soundMeter.decibels, a)
        return a
    }
}

struct DecibelView_Previews: PreviewProvider {
    static var previews: some View {
        DecibelView()
    }
}
