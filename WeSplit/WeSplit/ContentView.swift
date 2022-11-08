import SwiftUI

struct ContentView: View{
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool  // @FocusState is like a regular @State property except it's designed to handle input focus for our UI
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // Calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)  // Adding 2 because it's starting with 4 because of the range in ForEach counting by 2, that is the 3th position of the array tipPercentages.
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalNotDivided: Double{
        let tipValue = checkAmount/100 * Double(tipPercentage)
        let totalNotDivided = checkAmount + tipValue
        
        return totalNotDivided
    }
    
    
    let formater: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "R$")
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Check amount", value: $checkAmount, format: formater)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Número de pessoas", selection: $numberOfPeople){
                        ForEach(2..<21){
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Valor:")
                }
                
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Percentual de gorjeta:")
                }
                
                Section(){
                    Text(totalPerPerson, format: formater)
                } header: {
                    Text("Valor por pessoa:")
                }
                
                Section{
                    Text(totalNotDivided, format: formater)
                } header: {
                    Text("Valor total (com gorjeta):")
                }
                .foregroundColor(tipPercentage == 0 ? .red : .primary)
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
