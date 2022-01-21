

import SwiftUI

struct ContentView: View {
    
    let diceTypes = [4, 6, 8, 10, 12, 20]
    
    @AppStorage("selectedDiceType") var selectedDiceType = 6
    @AppStorage("numberToRoll") var numberToRoll = 4
    
    @State private var currentResult = DiceResult(type: 0, number: 0)
    
    let columns: [GridItem] = [
        .init(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type of dice", selection: $selectedDiceType) {
                        ForEach(diceTypes, id: \.self) { type in
                            Text("D\(type)")
                        }
                    }
                    .pickerStyle(.segmented)
                    Stepper("Number of dice: \(numberToRoll)", value: $numberToRoll, in: 1...20)
                    Button("Roll Dice!", action: rollDice)
                } footer: {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<currentResult.rolls.count, id: \.self) { rollNumber in
                            Text(String(currentResult.rolls[rollNumber]))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .font(.title)
                                .padding(5)
                        }
                    }
                }
            }
            .navigationTitle("Roller")
        }
    }
    func rollDice() {
        currentResult = DiceResult(type: selectedDiceType, number: numberToRoll)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
