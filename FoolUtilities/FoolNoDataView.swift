//
//  FoolNoDataView.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/3.
//

import SwiftUI

@available(iOS 13.0, OSX 11.0, *)
struct FoolNoDataView<NoDataView>: ViewModifier where NoDataView: View {
    let noDataView: () -> NoDataView
    var bNoData: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if bNoData {
                noDataView()
            }
        }
    }
}

@available(iOS 13.0, OSX 11.0, *)
public extension View {
    func foolNoData<NoDataView>(bNoData: Bool, @ViewBuilder noDataView: @escaping () -> NoDataView) -> some View where NoDataView: View {
        self.modifier(FoolNoDataView(noDataView: noDataView, bNoData: bNoData))
    }
}

@available(iOS 13.0, OSX 11.0, *)
struct FoolNoDataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Rectangle().foolNoData(bNoData: false, noDataView: { Text("no data") })
            Rectangle().foolNoData(bNoData: true, noDataView: { Text("no data") })
        }
    }
}
