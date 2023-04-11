//
//  StepThreeView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI

struct StepThreeView: View {
    @ObservedObject var outfitModel: OutfitModel
//    @ObservedObject var characterViewModel: CharacterViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var magnification: CGFloat = 1.0
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero
    @State private var offsetAccumulated = CGSize.zero
    
    var outfitViewModel : OutfitViewModel = OutfitViewModel()

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
                            NavigationLink(destination : ContentView().onAppear{
                                
                                    print("trig save")
                                    outfitViewModel.addOutfit(outfitModel)
                            }){
                                Text("Finish")
                                    .padding(.horizontal, 32)
                                    .frame(height: 60)
                                    .background(Color("layer1"))
                                    .foregroundColor(.black)
                                    .cornerRadius(16)
                            }
                            
                        }
                        Spacer()
                        AvatarView(outfitModel: outfitModel)
                        .frame(width: leftWidthBound)
                        .scaleEffect(magnification)
                        .offset(offset)
                        .scaleEffect(magnification)
                        .gesture(
                            DragGesture()
                                .onChanged{
                                    gesture in
                                    offset = gesture.translation
                                    print(offset)
                                }
                                .onEnded{
                                    value in
                                    offset = offset

                                }
                            
                        ).gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    magnification = value
                                }
                        )
                        
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
        StepThreeView(outfitModel: OutfitModel(id: nil))
    }
}
