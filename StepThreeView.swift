//
//  StepThreeView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI

struct StepThreeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var magnification: CGFloat = 1.0

    var body: some View {
        NavigationView(){
            GeometryReader{
                geometry in
                HStack( spacing: 32){
                    let heightBound: CGFloat = geometry.size.height - 32
                    let leftWidthBound: CGFloat = geometry.size.width*0.6 - 32
                    let rightWidthBound: CGFloat = geometry.size.width*0.4 - 32
                    // left
                    VStack(alignment: .leading){
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
                            Text("Step 3 : Wrap Up")
                            Spacer()
                            Button(
                                action: {}
                            ){
                                Text("add to group")
                                    .padding(.horizontal, 32)
                                    .frame(height: 60)
                                    .background(Color("layer1"))
                                    .foregroundColor(.black)
                                    .cornerRadius(16)
                            }
                            NavigationLink(destination : StepTwoView()){
                                Text("Finish")
                                    .padding(.horizontal, 32)
                                    .frame(height: 60)
                                    .background(Color("layer1"))
                                    .foregroundColor(.black)
                                    .cornerRadius(16)
                            }
                            
                        }
                        Spacer()
                        ZStack{
                            Image("vector")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: .gray)
                                .scaleEffect(magnification)
                        }
                        .frame(width: leftWidthBound)
                        Spacer()
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
                    }.frame(width: leftWidthBound , height: geometry.size.height - 32)
                    Spacer()
                    //right
                    VStack(spacing: 32){
                        // share box
                        VStack(spacing: 0){
                            Rectangle()
                                .frame(height: (heightBound * 0.7) * 0.5)
                                .foregroundColor(Color("layer2")).customCornerRadius(24, corners: [.topLeft, .topRight])
                            VStack(alignment: .leading){
                                Text("I think, you will looks georgeus with this! ")
                                    .font(.system(size: 32))
                                    .fontWeight(.semibold)
                                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                
                                Spacer()
                                Button(action: {
                                }) {
                                    Text("share to your friends")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, maxHeight: 84)
                                }
                                .background(Color("layer2"))
                                .foregroundColor(.black)
                                .cornerRadius(16)
                            }
                            .padding(42)
                            .background(Color("layer1"))
                            .customCornerRadius(24, corners: [.bottomLeft, .bottomRight])
                        }
                        .frame(height: heightBound * 0.7 - 32)
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color("layer1"))
                                .cornerRadius(24)
                            Circle()
                                .foregroundColor(Color("layer2"))
                                .padding(32)
                            
                            Image(systemName: "plus")
                                .scaleEffect(4)
                            Text("upload your try on")
                                .multilineTextAlignment(.center)
                                .frame(width: 130)
                                .offset(y: 64)
                            
                            
                            
                        }.frame(height: heightBound * 0.3)
                    }
                    .frame(width: rightWidthBound, height: heightBound)
                }
            }.padding(32)
        }.navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StepThreeView_Previews: PreviewProvider {
    static var previews: some View {
        StepThreeView()
    }
}
