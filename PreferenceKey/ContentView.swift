//
//  ContentView.swift
//  PreferenceKey
//
//  Created by Jonni Akesson on 2022-10-12.
//

import SwiftUI

struct ParentView: View {
    @State var text = "Hello, world!"
    
    var body: some View {
        NavigationView {
            VStack {
                ChildView(text: text)
            }
            .navigationTitle("Nav Title")
            .customTitle("CHILD VALUE")
            // .preference(key: CustomPreferenceKey.self, value: "CHILD VALUE")
        }
        .onPreferenceChange(CustomPreferenceKey.self) { value in
            self.text = value
        }
    }
}

struct ChildView: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}

struct CustomPreferenceKey: PreferenceKey {
    static var defaultValue = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomPreferenceKey.self, value: text)
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
