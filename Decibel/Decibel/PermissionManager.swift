//
//  PermissionManager.swift
//  Decibel
//
//  Created by 김민 on 2023/05/13.
//

import AVFoundation

class PermissionManager: ObservableObject {
    
    // MARK: - Custom Methods
    
    @Published var permissionGranted = false
    
    // 오디오 권한 요청
    
    func requestAudioPermission() {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            if granted {
                print("오디오 권한 허용")
            } else {
                print("오디오 권한 거부")
            }
        }
    }
}
