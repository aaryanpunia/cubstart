//
//  ContentView.swift
//  waitlisthelper
//
//  Created by aaryan punia on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var waitlistPlace: Double = 0
    @State private var classSize: Double = 0
    @State private var calculate = false
    @State var probability = 0
    @State var text = ""
    @State var result = "Calculate your probability first!"
    
    func calcResult() -> Void {
        if probability > 50 {
            result = "Great! You should stay in this class"
        } else {
            result = "Oh no! Go to Berkeley Time to find other classes"
        }
    }
    
    var body: some View {
            NavigationView {
                TabView {
                    ZStack {
                        Image("calculate_background")
                            .resizable()
                            .aspectRatio(UIImage(named: "calculate_background")!.size, contentMode: .fill)
                            .edgesIgnoringSafeArea(.top)
                            .edgesIgnoringSafeArea(.bottom)
                        VStack {
                            Spacer()
                            Text("WILL YOU GET OFF A WAITLIST")
                                .font(.largeTitle)
                                .foregroundColor(Color.black)
                            Spacer()
                            HStack {
                                Text("Place on Waitlist: \(waitlistPlace, specifier: "%.0f")")
                                    .foregroundColor(Color.black)
                                    .padding()
                                
                                Spacer()
                            }
                            Slider(value: $waitlistPlace, in: 0...200, step: 1)
                                .padding()
                            
                            HStack {
                                Text("Class Size: \(classSize, specifier: "%.0f")")
                                    .foregroundColor(Color.black)
                                    .padding()
                                
                                Spacer()
                            }
                            Slider(value: $classSize, in: 0...1000, step: 1)
                                .padding()
                            
                            NavigationLink(destination: ResultView(prob: $probability, feedback: $text), isActive: $calculate) { EmptyView() } .padding()
                            
                            Button("CALCULATE") {
                                let tenth = classSize / 10
                                if (waitlistPlace <= tenth) {
                                    probability = 100
                                    calcResult()
                                    print(result)
                                } else if (waitlistPlace > tenth * 2) {
                                    probability = 0
                                    calcResult()
                                    print(result)
                                } else {
                                    probability = 100 - Int(((Float(waitlistPlace - tenth) / Float(tenth))*100))
                                    calcResult()
                                    print(result)
                                }
                                
            //                                text = getFeedbackText()
                                calculate = true
                            } .buttonStyle(CustomButton())
                            
                            Spacer()

                        }
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    ZStack {
                        Image("calculate_background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                        Spacer()
                        Text(result)
                            .font(.largeTitle)
                            .foregroundColor(Color.black)
                            .padding()
                        Spacer()
                        
                        
                    }
                    .tabItem {
                        Image(systemName: "arrow.right.square.fill")
                        Text("Recommendation")
                    }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ResultView: View {
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    @Binding var prob: Int
    @Binding var feedback: String
    
    
    var body: some View {

        ZStack {
            Color(red: 50/255, green: 141/255, blue: 168/255)
                .ignoresSafeArea()
            
            Image("result_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    .navigationBarHidden(true)
                    Spacer()
                } .padding()
                Spacer()
                Text("PROBABILITY")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("\(prob)%")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(Color.white)
                Text("\(feedback)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
                Spacer()
                Spacer()
            } .padding()
        }
        
    }
}


struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(Color.black)
            .background(Color.blue)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
