//
//  FoolNoDataView.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/3.
//

import SwiftUI

@available(iOS 13.0, *)
struct FoolNoDataView<Presenting, NoDataView>: View where Presenting: View, NoDataView: View {
    let presenting: () -> Presenting
    let noDataView: () -> NoDataView
    var bNoData: Bool
    
    var body: some View {
        ZStack {
            presenting()
            if bNoData {
                noDataView()
            }
        }
    }
}

@available(iOS 13.0, *)
public extension View {
    
    func foolNoData<NoDataView>(bNoData: Bool, noDataView: @escaping () -> NoDataView) -> some View where NoDataView: View {
        FoolNoDataView(presenting: { self }, noDataView: noDataView, bNoData: bNoData)
    }
    
}

@available(iOS 13.0, *)
struct FoolNoDataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Rectangle().foolNoData(bNoData: false, noDataView: { Text("no data") })
            Rectangle().foolNoData(bNoData: true, noDataView: { Text("no data") })
        }
    }
}
