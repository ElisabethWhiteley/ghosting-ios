//
//  SegmentedProgress.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 07/10/2020.
//

import SwiftUI

struct SegmentedProgressView: View {
  var value: Int = 4
  var maximum: Int = 10
  var height: CGFloat = 12
  var spacing: CGFloat = 3
  var selectedColor: Color = .yellow
  var unselectedColor: Color = Color.secondary.opacity(0.3)
var body: some View {
    HStack(spacing: spacing) {
      ForEach(0 ..< maximum) { index in
        Rectangle()
          .foregroundColor(index < self.value ? self.selectedColor : self.unselectedColor)
      }
    }
    .frame(maxHeight: height)
    .frame(height: height)
    .clipShape(Capsule())
  }
}

struct SegmentedProgress_Previews: PreviewProvider {
    static var previews: some View {
     SegmentedProgressView()
    }
}
