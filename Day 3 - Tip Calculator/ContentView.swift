import SwiftUI

struct ContentView: View {
    @State private var priceTextField = 0.0
    @State private var tipSlider = 50.0
    var tipPercent: Double {
        return priceTextField/100*tipSlider
    }
    var total: Double {
        return priceTextField + priceTextField/100*tipSlider
    }

    var body: some View {
        VStack(spacing: 10) {
            TextField("Price", value: $priceTextField, format: dollarFormat)
                .keyboardType(.decimalPad)
                .padding(10)
                .border(Color.gray, width: 0.7)
                .padding(EdgeInsets(top: 0, leading: 80, bottom: 40, trailing: 80))
            Text("Tip(\(tipSlider.formatted())%): \(tipPercent.formatted(.currency(code: "USD")))")
            Text("Total: \(total.formatted(.currency(code: "USD")))")
            Slider(value: $tipSlider, in: 0...100, step: 1)

            Button("hide") {
                hideKeyboard()
            }
        }
        .padding()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
    return FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
