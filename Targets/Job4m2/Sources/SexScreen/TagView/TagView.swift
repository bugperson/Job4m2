//
//  TagView.swift
//  Job4m2
//
//  Created by Danil Dubov on 02.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct TagView: View {
    public var model: TagModel

    var body: some View {
        Text(model.text)
            .padding(8)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(model.color.rawValue)
             )
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(
            model: TagModel(id: 1, text: "Tag", color: TagColor.green)
        )
    }
}
