//
//  ContentView.swift
//  SwipeUp
//
//  Created by Philip Davis on 11/3/21.
//

import SwiftUI

struct ContentView: View {
    let images: [String] = [
        "https://images.unsplash.com/photo-1515266591878-f93e32bc5937?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1287&q=80",
        "https://images.unsplash.com/photo-1520663302610-fb61c8b64766?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80",
        "https://images.unsplash.com/photo-1610847033737-0c62d8d14534?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1472&q=80",
        "https://images.unsplash.com/photo-1550439694-0cc5e82d1179?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80",
        "https://images.unsplash.com/photo-1485550409059-9afb054cada4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1365&q=80",
        "https://images.unsplash.com/photo-1635297383087-8842f98f908a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1286&q=80",
        "https://images.unsplash.com/photo-1501975558162-0be7b8ca95ea?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1287&q=80",
    ]
    
    var body: some View {
        ZStack {
            // Credit to Gary Tokmen for this bit of Geometry Reader code: https://blog.prototypr.io/how-to-vertical-paging-in-swiftui-f0e4afa739ba
        
            GeometryReader { proxy in
                TabView {
                    ForEach(images, id: \.self) { image in
                        AsyncImage(url: URL(string: image)) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .rotationEffect(.degrees(-90)) // Rotate content
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                }
                .frame(
                    width: proxy.size.height, // Height & width swap
                    height: proxy.size.width
                )
                .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
                .offset(x: proxy.size.width) // Offset back into screens bounds
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
            }
            VStack {
                Spacer()
                TabBar()
            }.padding(40)
        }.statusBar(hidden: true)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TabBar: View {
    var body: some View {
        HStack(spacing: 32) {
            TabBarIcon(icon: "photo.on.rectangle.angled", isActive: true)
            TabBarIcon(icon: "person.crop.circle")
        }
        .padding(EdgeInsets(top: 14, leading: 30, bottom: 16, trailing: 30))
        .background(.thinMaterial)
        .cornerRadius(100)
        .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 16)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 1)
    }
}

struct TabBarIcon: View {
    let icon: String
    var isActive: Bool? = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isActive! ? .primary : .secondary)
                .font(.system(size: 24))
            
        }
    }
}
