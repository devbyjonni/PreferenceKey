//
//  ScrollViewOffset.swift
//  PreferenceKey
//
//  Created by Jonni Akesson on 2022-10-12.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> ()) -> some View {
        self.background(
            GeometryReader { geo in
                Text("") // blank view...
                    .preference(key:ScrollViewOffsetPreferenceKey.self ,value: geo.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self , perform: { value in
            action(value)
        })
    }
}

struct ScrollViewOffset: View {
    
    private var title = "New title!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 100.0)
                    .onScrollViewOffsetChange { offset in
                        self.scrollViewOffset = offset
                    }
                contentLayer
            }
            .padding(.horizontal)
            .padding(.top, 53) // fix in prod
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay (navBarLayer
            .opacity(scrollViewOffset < 40 ? 1.0 : 0)
                  , alignment: .top)
        
    }
}

extension ScrollViewOffset {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<100) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(.red)
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 55)
            .opacity(scrollViewOffset < 40 ? 1.0 : 0)
            .animation(.default, value: scrollViewOffset < 40 )
            .background(.thinMaterial)
    }
}

struct ScrollViewOffset_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffset()
    }
}
