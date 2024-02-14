

import SwiftUI

struct BorderViewModifier: ViewModifier {
    let width: CGFloat
    let color: Color
    let padding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: width)
            )
    }
}
