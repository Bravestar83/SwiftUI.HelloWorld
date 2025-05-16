import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var selectedLanguage: String = "English"
    @State private var showGreeting = false
    
    let languages = ["English", "German", "Spanish", "isiXhosa", "French"]
    let languageFlags = [
        "English": "🇬🇧",
        "German": "🇩🇪",
        "Spanish": "🇪🇸",
        "isiXhosa": "🇿🇦",
        "French": "🇫🇷"
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                if showGreeting {
                    VStack {
                        Text(languageFlags[selectedLanguage] ?? "🇺🇳")
                            .font(.system(size: 100))
                        
                        Text(greeting(for: selectedLanguage, name: name))
                            .font(.largeTitle)
                            .padding()
                    }
                    .transition(.scale.combined(with: .opacity))
                    
                    Button("Try Again") {
                        withAnimation {
                            showGreeting = false
                            name = ""
                            selectedLanguage = "English"
                        }
                    }
                    .padding()
                } else {
                    // App icon
                    Image(systemName: "quote.bubble")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.top)
                        .foregroundColor(.blue)
                    
                    // App title
                    Text("Marshall Says Hello World")
                        .font(.title)
                        .bold()
                    
                    // Name input
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    // Language picker
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            HStack {
                                Text(languageFlags[language] ?? "")
                                Text(language)
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                    
                    // Submit button
                    Button("Submit") {
                        withAnimation {
                            showGreeting = true
                        }
                    }
                    .padding()
                    .disabled(name.isEmpty)
                }
            }
            .animation(.easeInOut, value: showGreeting)
            .padding()
            
            // Credit text at the bottom
            VStack {
                Spacer()
                Text("Created by Bravestar83")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("https://github.com/Bravestar83")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(.bottom, 8)
            }
        }
    }
    
    func greeting(for language: String, name: String) -> String {
        switch language {
        case "German": return "Hallo, \(name)!"
        case "Spanish": return "¡Hola, \(name)!"
        case "isiXhosa": return "Molo, \(name)!"
        case "French": return "Bonjour, \(name)!"
        default: return "Hello, \(name)!"
        }
    }
}

#Preview {
    ContentView()
}
