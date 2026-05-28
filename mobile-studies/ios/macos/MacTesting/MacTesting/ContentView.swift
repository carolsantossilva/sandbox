//
//  ContentView.swift
//  MacTesting
//
//  Created by Ana Carolina Silva on 14/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding(.vertical, 50)
        .padding(.horizontal, 100)
    }
}

#Preview {
    ContentView()
}
