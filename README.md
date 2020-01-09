# FoolUtilities  

    Utilitues collected by foolbear  

### FoolUtilitues  
* func foolPrint<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line)    
* func uInt64ToHumanReadable(input: UInt64, bBinary: Bool) -> String  

### FoolDevice  
* var modelName: String    

### FoolColor  
* convenience init(rgbHex: UInt)  

### FoolString    
* func subString(start: Int, length: Int = -1) -> String  

### FoolDate  
* func easyDate() -> String  

### FoolAnyView (SwiftUI)  
* func toAnyView() -> AnyView  

### FoolHeaderView (SwiftUI)    
* struct FoolHeaderView<Leading, Title, Trailing>: View where Leading: View, Title: View, Trailing: View  

### FoolNoDataView (SwiftUI)  
* func foolNoData<NoDataView>(bNoData: Bool, noDataView: @escaping () -> NoDataView) -> some View where NoDataView: View  

### FoolKeyboard (SwiftUI)  
* class FoolKeyboard: ObservableObject  

### FoolImagePicker (SwiftUI)  
* struct FoolImagePicker: UIViewControllerRepresentable  

### FoolProgressBar (SwiftUI)  
* struct FoolProgressBar: View  

### FoolTextField (SwiftUI)  
* FoolTextField: UIViewRepresentable  
