//
//  ContentView.swift
//  HelloWorld
//
//  Created by Marshall on 2025/05/16.
//

import SwiftUI

struct ContentView: View {
    // User input and selection
    @State private var name = ""
    @State private var selectedLanguage = "English"
    @State private var showGreeting = false
    
    // Supported languages and greetings
    let languages = ["English", "German", "Spanish", "isiXhosa", "Zulu"]
    let greetings = [
        "English": "Hello",
        "German": "Hallo",
        "Spanish": "Hola",
        "isiXhosa": "Molo",
        "Zulu": "Sawubona"
    ]
    
    var body: some View {
        if showGreeting {
            // Greeting screen
            VStack(spacing: 40) {
                Text("\(greetings[selectedLanguage] ?? "Hello") \(name)")
                    .font(.largeTitle)
                    .padding()
                
                Button("Try Again") {
                    // Reset and go back
                    name = ""
                    selectedLanguage = "English"
                    showGreeting = false
                }
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        } else {
            // Input screen
            VStack(spacing: 20) {
                Text("Enter your name:")
                    .font(.headline)
                
                TextField("Your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text("Choose language:")
                    .font(.headline)
                
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { lang in
                        Text(lang)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Button("Say Hello") {
                    // Show greeting screen
                    if !name.isEmpty {
                        showGreeting = true
                    }
                }
                .disabled(name.isEmpty)
                .padding()
                .background(name.isEmpty ? Color.gray : Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
