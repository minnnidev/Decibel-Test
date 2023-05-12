
import SwiftUI
import AVFoundation

class SoundMeter: ObservableObject {
    let engine = AVAudioEngine()
    let playerNode = AVAudioPlayerNode()
    let bufferSize: AVAudioFrameCount = 4096

    @Published var decibels: Float = 0.0

    init() {
        let input = engine.inputNode
        let bus = 0

        // 입력 오디오의 하드웨어 샘플 속도로 AVAudioFormat을 만듭니다.
        let hardwareSampleRate = input.inputFormat(forBus: bus).sampleRate
        let recordingFormat = AVAudioFormat(standardFormatWithSampleRate: hardwareSampleRate, channels: 1)!

        engine.attach(playerNode)

        engine.connect(playerNode, to: engine.mainMixerNode, format: input.inputFormat(forBus: bus))

        input.installTap(onBus: bus, bufferSize: bufferSize, format: recordingFormat) { [weak self] (buffer, _) in
            guard let self = self else { return }

            buffer.frameLength = self.bufferSize

            let channelDataValue = buffer.floatChannelData?.pointee
            let channelData = UnsafeBufferPointer(start: channelDataValue, count: Int(buffer.frameLength))
            var decibels: Float = 0.0
            if channelData.count > 0 {
                let rms = sqrt(channelData.reduce(0) {$0 + pow($1, 2)} / Float(channelData.count))
                decibels = 20.0 * log10(rms)
            }
            
            DispatchQueue.main.async {
                self.decibels = decibels
            }
        }
    }

    func start() throws {
        try engine.start()
        playerNode.play()
    }

    func stop() {
        engine.stop()
        playerNode.stop()
        engine.inputNode.removeTap(onBus: 0)
    }
}

