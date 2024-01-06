//
//  CardView.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import SwiftUI

extension Int {
    var toHoursMinuteString: String {
        return "\(self / 60 / 60)h \(self / 60 % 60)m"
        
    }
    
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

struct CardView: View {
    var topText: String
    var value: Int
    var image: String
    var bottomText: String?
    var body: some View {
        ZStack {
            Color.init(hex: "#0b1d2e")
                .cornerRadius(20)
                .scaledToFill()
            VStack {
                VStack {
                    Image(systemName: image)
                        .font(.title)
                    Text(topText)
                        .font(.title3)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .multilineTextAlignment(.leading)
                Text(value.toHoursMinuteString)
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                if (bottomText != nil) {
                    Text(bottomText ?? "You're not supposed to see this")
                        .font(.title3)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                }
            }
        }
    }
}

#Preview {
    VStack {
        CardView(topText: "Your sleep debt for the last 7 days is", value: 876750 - 8 * 30 * 60 * 60, image: "moon.zzz") // sleep debt of ~15.5h
        CardView(topText: "You should sleep at least", value: 8 * 60 * 60 - 876750 / 30 , image: "moon.zzz.fill", bottomText: "per day to catch up on your sleep in 7 days")
    }
}
