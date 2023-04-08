//
//  StepOneView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI

struct StepOneView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedColor: Color = Color(.gray)
    @State private var magnification: CGFloat = 1.0
    var body: some View {
        NavigationView(){
            GeometryReader{
                geometry in
                HStack( spacing: 32){
                    let heightBound: CGFloat = geometry.size.height - 32
                    let widthBound: CGFloat = geometry.size.width/2 - 32
                    // left
                    VStack(){
                        HStack(){
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("layer1"))
                                    .frame(width: 60,height: 60)
                                    .cornerRadius(16)
                                Image(systemName: "chevron.left")
                            }.onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                            Spacer()
                            Text("Step 1 : Create Pattern")
                            Spacer()
                            NavigationLink(destination : StepTwoView()){
                                Text("Next")
                                    .padding(.horizontal, 32)
                                    .frame(height: 60)                            .background(Color("layer1"))
                                    .foregroundColor(.black)
                                    .cornerRadius(16)
                                
                                
                            }
                            
                        }
                        ZStack{
                            Image("vector")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: selectedColor)
                                .scaleEffect(magnification)
                        }
                        .frame(width: widthBound, height: heightBound - 160)
                        
                        
                        HStack(alignment: .bottom){
                            VStack(spacing: 0){
                                Button(action: {
                                    magnification = magnification + 0.1
                                }) {
                                    Text("+")
                                        .frame(width: 60,height: 60)
                                }
                                .background(Color("layer1"))
                                .foregroundColor(.black)
                                .customCornerRadius(16, corners: [.topLeft, .topRight])
                                
                                Button(action: {
                                    magnification = magnification - 0.1
                                }) {
                                    Text("-")
                                        .frame(width: 60,height: 60)
                                }.background(Color("layer2"))
                                    .foregroundColor(.black)
                                    .customCornerRadius(16, corners: [.bottomLeft, .bottomRight])
                            }
                            Spacer()
                            HStack(alignment: .bottom, spacing: 0){
                                Rectangle()
                                    .foregroundColor(Color("layer1"))
                                    .frame(width: 60,height: 60)
                                    .cornerRadius(16)
                                Rectangle()
                                    .foregroundColor(Color("layer2"))
                                    .frame(width: 60,height: 60)
                                    .cornerRadius(16)
                            }
                        }
                    }.frame(width: geometry.size.width/2 - 32 , height: geometry.size.height - 32)
                    Spacer()
                    //right
                    VStack(spacing: 32){
                        //TYPE
                        VStack(){
                            //background
                            // title bar
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .foregroundColor(Color("layer2"))
                                    .frame(height: 60)
                                    .customCornerRadius(16, corners: [.topLeft, .topRight])
                                Text("Pants Types")
                                    .padding(.leading, 32)
                            }.frame(height: 60)
                            // scroll item
                            ScrollView(showsIndicators: true){
                                LazyVGrid(columns: [
                                    GridItem(.adaptive(minimum: (widthBound - 32)/3 - 8))
                                ], spacing: 16) {
                                    ForEach(0..<10) {
                                        index in
                                        Rectangle()
                                            .cornerRadius(16)
                                            .foregroundColor(Color("layer2"))
                                            .frame(width: (widthBound - 32)/3 - 8, height: (widthBound - 32)/3 - 8)
                                            .padding(.horizontal, 16)
                                    }
                                }
                                .padding( 16)
                            }
                            
                        }
                        .background(Color("layer1"))
                        .frame(height: heightBound - 65 - 280  - 64)
                        .cornerRadius(24)
                        // COLOR PICKER
                        ZStack(alignment: .top){
                            Rectangle()
                                .foregroundColor(Color("layer1"))
                                .frame(height: 280)
                                .cornerRadius(24)
                            VStack(alignment : .leading){
                                // title bar
                                ZStack(alignment: .leading){
                                    Rectangle()
                                        .foregroundColor(Color("layer2"))
                                        .frame(height: 60)
                                    
                                        .customCornerRadius(16, corners: [.topLeft, .topRight])
                                    Text("Pants Types")
                                        .padding(.leading, 32)
                                }.frame(height: 60)
                                // scroll item
                                HStack(spacing: 16){
                                    // color picker
                                    Rectangle()
                                        .foregroundColor(Color("layer2"))
                                        .frame(width: 180,height: 180)
                                        .cornerRadius(100)
                                        .overlay(
                                            ColorPicker("", selection: $selectedColor)
                                                .labelsHidden()
                                                .opacity(1)
                                                .scaleEffect(5)
                                        )
                                    VStack(spacing: 8){
                                        Rectangle()
                                            .frame(height: 123)
                                            .foregroundColor(Color("layer2"))
                                            .cornerRadius(16)
                                        HStack{
                                            Button(action: {
                                            }) {
                                                Text("add to swatch")
                                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                            }
                                            .background(Color("layer2"))
                                            .foregroundColor(.black)
                                            .cornerRadius(16)
                                            Button(action: {
                                            }) {
                                                Text("color harmony")
                                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                            }
                                            .background(Color("layer2"))
                                            .foregroundColor(.black)
                                            .cornerRadius(16)
                                        }
                                        
                                    }
                                }.padding( 16)
                                
                            }
                            
                        }
                        
                        Rectangle()
                            .foregroundColor(Color("layer1"))
                            .frame(height: 130)
                            .cornerRadius(24)
                    }
                    .frame(width: widthBound, height: heightBound)
                }
            }.padding(32)
        }.navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct StepOneView_Previews: PreviewProvider {
    static var previews: some View {
        StepOneView()
    }
}
