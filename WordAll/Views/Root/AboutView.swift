//
//  AboutView.swift
//  WordAll
//
//  Created by Ian Lockett on 08/06/2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.waBackground.ignoresSafeArea()
            VStack(spacing: 30) {
                LogoView(animated: true)
                PanelView {
                    VStack(spacing: 10) {
                        Text("\"Like a dictionary, but not as useful.\"")
                            .font(.bodyMediumRegular)
                        Text("- Mina Lockett")
                            .font(.bodySmallLight)
                            .padding(.bottom, 10)
                        Text(verbatim: "© 2024, Ian Lockett")
                            .font(.bodySmallRegular)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: 500)
            .padding(.horizontal, 30)
            .padding(.top, 80)
        }
    }
}

#Preview {
    AboutView()
}
