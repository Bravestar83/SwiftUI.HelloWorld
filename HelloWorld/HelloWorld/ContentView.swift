import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var selectedLanguage: String = "English"
    @State private var showGreeting = false
    
    let languages = ["English", "German", "Spanish", "isiXhosa", "Zulu"]
    
    var body: some View {
        VStack(spacing: 20) {
            if showGreeting {
                Text(greeting(for: selectedLanguage, name: name))
                    .font(.largeTitle)
                    .padding()
                
                Button("Try Again") {
                    showGreeting = false
                    name = ""
                    selectedLanguage = "English"
                }
                .padding()
            } else {
                // App icon
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top)
                
                // App title
                Text("Marshall's Hello World")
                    .font(.title)
                    .bold()
                
                // Name input
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Language picker
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text(language)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                // Submit button
                Button("Submit") {
                    showGreeting = true
                }
                .padding()
                .disabled(name.isEmpty)
            }
        }
        .animation(.easeInOut, value: showGreeting)
        .padding()
    }
    
    func greeting(for language: String, name: String) -> String {
        switch language {
        case "German": return "Hallo, \(name)!"
        case "Spanish": return "¡Hola, \(name)!"
        case "isiXhosa": return "Molo, \(name)!"
        case "Zulu": return "Sawubona, \(name)!"
        default: return "Hello, \(name)!"
        }
    }
}

#Preview {
    ContentView()
}
