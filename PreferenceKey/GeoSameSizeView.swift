//
//  GeoSameSizeView.swift
//  PreferenceKey
//
//  Created by Jonni Akesson on 2022-10-12.
//

import SwiftUI

struct GeoSameSizeView: View {
    @State var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: rectSize.width, height: rectSize.height)
                .background(.blue)
                .padding()
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleForGeoSize(geo.size)
                        .overlay {
                            Text("\(geo.size.width)")
                                .foregroundColor(.white)
                        }
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectSizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

struct GeoSameSizeView_Previews: PreviewProvider {
    static var previews: some View {
        GeoSameSizeView()
    }
}

struct RectSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func updateRectangleForGeoSize(_ size: CGSize) -> some View {
        preference(key: RectSizePreferenceKey.self, value: size)
    }
}
