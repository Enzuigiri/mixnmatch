//
//  StepTwoView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI

struct ItemContainer: View {
    var heightBound : CGFloat
    var widthBound : CGFloat
    var title: String
    
    var body: some View{
        VStack(spacing: 0){
            // title bar
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(Color("layer2"))
                    .frame(height: 60)
                    .customCornerRadius(16, corners: [.topLeft, .topRight])
                Text(title)
                    .padding(.leading, 32)
            }.frame(height: 60)
            // scroll item
            ScrollView(.horizontal, showsIndicators: true){
                HStack(spacing: 16){
                    ForEach(1..<10){
                        _ in
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(Color("layer2"))
                            .frame(width: (heightBound/4 - 24) - 32 - 60, height: (heightBound/4 - 24) - 32 - 60)
                        
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }.padding(0)
            
        }
        .background(Color("layer1"))
        .frame(width: widthBound, height: heightBound/4 - 24)
        .cornerRadius(24)
    }
}

struct StepTwoView: View {
    @ObservedObject var outfitModel: OutfitModel
//    @ObservedObject var characterViewModel: CharacterViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var selectedColor: Color = Color(.gray)
    @State private var magnification: CGFloat = 1.0
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero
    @State private var offsetAccumulated = CGSize.zero
    
    
    var body: some View {
        
        NavigationView(){
            GeometryReader{
                geometry in
                HStack( spacing: 32){
                    let heightBound: CGFloat = geometry.size.height - 32
                    let widthBound: CGFloat = geometry.size.width/2 - 32
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
                            Text("Step 2 : Insert the Item You Have")
                            Spacer()
                            NavigationLink(destination : StepThreeView(outfitModel: outfitModel)){
                                Text("Next")
                                    .padding(.horizontal, 32)
                                    .frame(height: 60)
                                    .background(Color("layer1"))
                                    .foregroundColor(.black)
                                    .cornerRadius(16)
                                
                                
                            }
                            
                        }
                        Spacer()
                        AvatarView(outfitModel: outfitModel)
                        .frame(width: widthBound)
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
                       
                        ItemContainer(
                            heightBound: heightBound, widthBound: widthBound, title: "Shoes Item")
                    }.frame(width: geometry.size.width/2 - 32 , height: geometry.size.height - 32)
                    Spacer()
                    //right
                    VStack(spacing: 32){
                        ItemContainer(
                            heightBound: heightBound, widthBound: widthBound, title: "Hat Item")
                        ItemContainer(
                            heightBound: heightBound, widthBound: widthBound, title: "Clothes Item")
                        ItemContainer(
                            heightBound: heightBound, widthBound: widthBound, title: "Outer Item")
                        ItemContainer(
                            heightBound: heightBound, widthBound: widthBound, title: "Pants Item")
                    }
                    .frame(width: widthBound, height: heightBound)
                }
            }.padding(32)
        }.navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StepTwoView_Previews: PreviewProvider {
    static var previews: some View {
        StepTwoView(outfitModel: OutfitModel(id: nil))
    }
}
