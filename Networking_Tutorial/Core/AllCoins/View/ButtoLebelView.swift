//
//  ButtoLebelView.swift
//  Networking_Tutorial
//
//  Created by Mukund Madhav on 04/08/25.
//

import SwiftUI

struct ButtonView: View {
    
    @Binding var animateBorder: Bool
    var body: some View {
        Text("Ask AI")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 140, height: 48)
            .background(
                LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .overlay(
                // Main border
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.blue, .pink, .blue]),
                            center: .center,
                            angle: .degrees(animateBorder ? 360 : 0)
                        ),
                        lineWidth: 4
                    )
            )
            .overlay(
                // Glow layer
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.blue, .pink, .blue]),
                            center: .center,
                            angle: .degrees(animateBorder ? 360 : 0)
                        ),
                        lineWidth: 4
                    )
                    .blur(radius: 8) // ← this creates glow
                    .opacity(0.6)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                    animateBorder = true
                }
            }
    }
}


#Preview {
    ButtonView(animateBorder: .constant(false))
}
