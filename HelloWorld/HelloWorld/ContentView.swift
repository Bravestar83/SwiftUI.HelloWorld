import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var selectedLanguage: String = "English"
    @State private var showGreeting = false
    @State private var ipAddress: String = "Loading..."
    
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
                        
                        Text(fromText(for: selectedLanguage))
                            .font(.title3)
                            .padding(.top, 1)
                        
                        Text(ipAddress)
                            .font(.title2)
                            .bold()
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
                        fetchIPAddress()
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
        .onAppear {
            fetchIPAddress()
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
    
    func fromText(for language: String) -> String {
        switch language {
        case "German": return "Von"
        case "Spanish": return "Desde"
        case "isiXhosa": return "Ukusuka"
        case "French": return "De"
        default: return "From"
        }
    }
    
    func fetchIPAddress() {
        guard let url = URL(string: "https://api.ipify.org") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let ip = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.ipAddress = ip
                }
            } else {
                DispatchQueue.main.async {
                    self.ipAddress = "Could not fetch IP"
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
