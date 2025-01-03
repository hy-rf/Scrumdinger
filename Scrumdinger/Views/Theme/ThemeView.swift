//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by hyrf on 1/1/25.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .foregroundColor(theme.accentColor)
            .background(theme.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
