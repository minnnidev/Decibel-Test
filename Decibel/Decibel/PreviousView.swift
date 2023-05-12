//
//  PreviousView.swift
//  Decibel
//
//  Created by 김민 on 2023/05/13.
//

import SwiftUI

struct PreviousView: View {
    var body: some View {
        
        NavigationView {
            NavigationLink {
                DecibelView()
            } label: {
                Text("데시벨 측정하기")
            }
        }
    }
}

struct PreviousView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousView()
    }
}
