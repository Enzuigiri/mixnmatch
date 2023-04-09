//
//  StepOneView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI

struct StepOneView: View {
    func getSelectedColor() -> Binding<Color>{
        if(selectedItem == "Pants"){
            return $pantsColor
        } else if (selectedItem == "Shirt"){
            return $shirtColor
        } else if (selectedItem == "Outer"){
            return $outerColor
        } else if (selectedItem == "Hat"){
            return $hatColor
        } else if (selectedItem == "Shoes"){
            return $shoesColor
        }
        else {
            return $selectedColor
        }
        
    }
    
    func setSelectedItem(item: String) -> Void{
        if(selectedItem == "Pants"){
             selectedPantsItem = item
        } else if (selectedItem == "Shirt"){
             selectedShirtItem = item
        } else if (selectedItem == "Outer"){
             selectedOuterItem = item
        } else if (selectedItem == "Hat"){
             selectedHatItem = item
        } else if (selectedItem == "Shoes"){
             selectedShoesItem = item
        }
        else {
            selectedItem = ""
        }
    }
    
    func getSelectedItem() -> Binding<String>{
        if(selectedItem == "Pants"){
            return $selectedPantsItem
        } else if (selectedItem == "Shirt"){
            return $selectedShirtItem
        } else if (selectedItem == "Outer"){
            return $selectedOuterItem
        } else if (selectedItem == "Hat"){
            return $selectedHatItem
        } else if (selectedItem == "Shoes"){
            return $selectedShoesItem
        }
        else {
            return $selectedItem
        }
    }
    
    func getSelectedItemInventory(){
        
        if(selectedItem == "Pants"){
            inventory =  pantsItems
        } else if (selectedItem == "Shirt"){
            inventory =  shirtItems
        } else if (selectedItem == "Outer"){
            inventory =  outerItems
        } else if (selectedItem == "Hat"){
            inventory =  hatItems
        } else if (selectedItem == "Shoes"){
            inventory =  shoesItems
        }
        else {
            inventory =  ["outfit-none"]
        }
        print("triggered", inventory)
    }
    
    let baseColor = Color.red
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedColor: Color = Color(.gray)
    @State private var magnification: CGFloat = 1.0
    @State private var scale: CGFloat = 1.0
    
    @State private var offset = CGSize.zero
    @State private var offsetAccumulated = CGSize.zero
    
    
    @State private var selectedItem : String = ""
    
    @State private var shirtColor: Color = Color(.black)
    @State private var pantsColor: Color = Color(.gray)
    @State private var outerColor: Color = Color(.darkGray)
    @State private var hatColor: Color = Color(.darkGray)
    @State private var shoesColor: Color = Color(.darkGray)
    
    
    private let shirtItems: [String] = ["outfit-none", "shirt-base"]
    private let pantsItems: [String] = ["outfit-none", "pants-short"]
    private let outerItems: [String] = ["outfit-none", "outer-gardigan"]
    private let hatItems: [String] = ["outfit-none"]
    private let shoesItems: [String] = ["outfit-none"]
    @State private var inventory: [String] = []
    
    @State private var selectedShirtItem = "shirt-base"
    @State private var selectedPantsItem = "pants-short"
    @State private var selectedOuterItem = "outfit-none"
    @State private var selectedHatItem = "outfit-none"
    @State private var selectedShoesItem = "outfit-none"
    
    
    
    
    
    
    
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
                        var charHeightBound = heightBound - 160
                        ZStack(alignment: .center){
                            Image("base-body")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                            //pants
                            Image(selectedPantsItem)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: pantsColor)
                            //shirt
                            Image(selectedShirtItem)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: shirtColor)
                            //outer
                            Image(selectedOuterItem)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: outerColor)
                            //hat
                            Image(selectedHatItem)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: outerColor)
                            Image(selectedShoesItem)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .blending(color: outerColor)
                            
                            
                            
                            
                        }
                        .frame(width: widthBound, height: heightBound - 160)
                        
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
                                Text("\(selectedItem) Types")
                                    .padding(.leading, 32)
                            }.frame(height: 60)
                            // scroll item
                            ScrollView(showsIndicators: true){
                                LazyVGrid(columns: [
                                    GridItem(.adaptive(minimum: (widthBound - 32)/3 - 8))
                                ], spacing: 16) {
                                    ForEach(0..<inventory.count, id: \.self) {
                                        index in
                                        ZStack{
                                            Rectangle()
                                                .cornerRadius(16)
                                                .foregroundColor(Color("layer2")).frame(width: (widthBound - 32)/3 - 8, height: (widthBound - 32)/3 - 8)
                                                .padding(.horizontal, 16)
                                                
                                            Image("\(inventory[index])-icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding()
                                            
                                        }.frame(width: (widthBound - 32)/3 - 8, height: (widthBound - 32)/3 - 8)
                                            .onTapGesture {
                                                setSelectedItem(item: inventory[index])
                                            }
                                            .padding(.horizontal, 16)
                                    }
                                }
                                .padding( 16)
                            }
                            
                        }
                        .background(Color("layer1"))
                        .frame(height: heightBound - 65 - 280  - 64)
                        .cornerRadius(24)
                        // ITEM COLOR PICKER
                        ColorPickerView(widthBound: widthBound, selectedColor: getSelectedColor(), selectedItem: selectedItem)
                        // ITEM NAVIGATION
                        ItemNavigationView(widthBound: widthBound, selectedItem: $selectedItem, inventory: $inventory, getSelectedItemInventory: getSelectedItemInventory)
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

struct ColorPickerView: View {
    var widthBound: CGFloat
    @Binding var selectedColor: Color
    @State private var showColorGenerator: Bool = false
    var selectedItem: String
    
    @State var swatchesColors : [Color] = ColorManager().allColors()
    
    let colorManager = ColorManager()
    
    var body : some View {
        VStack(alignment : .leading){
            // title bar
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(Color("layer2"))
                    .frame(height: 60)
                
                    .customCornerRadius(16, corners: [.topLeft, .topRight])
                Text("\(selectedItem) Color")
                    .padding(.leading, 32)
            }.frame(height: 60)
            // content
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
                // swatches
                VStack(spacing: 8){
                    ScrollView(.horizontal){
                        LazyHGrid(
                            rows: [GridItem(.adaptive(minimum: 24))],
                            spacing: 8
                            //                                alignment: .center
                        ){
                            ForEach(0..<swatchesColors.count, id: \.self){
                                i in
                                Rectangle()
                                    .foregroundColor(swatchesColors[i])
                                    .
                                frame(width: 32, height: 32)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        selectedColor = swatchesColors[i]
                                    }
                            }
                        }
                    }
                    .frame(width: widthBound - 180 - 32)
                    HStack{
                        Button(action: {
                            colorManager.saveColor(color: selectedColor)
                            swatchesColors = colorManager.allColors()
                        }) {
                            Text("add to swatch")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        }
                        .background(Color("layer2"))
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        Button(action: {
                            
                            showColorGenerator.toggle()
                        }) {
                            Text("color harmony")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        }
                        .background(Color("layer2"))
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .sheet(isPresented: $showColorGenerator){
                            GenerateColorView(baseColor: selectedColor, swatchesColor: $swatchesColors)
                        }
                    }
                    
                }.frame(width: widthBound - 180 - 32)
            }.padding( 16)
            
        }.background(Color("layer1"))
            .frame(height: 280)
            .cornerRadius(24)
    }
}

struct ItemNavigationView : View {
    var widthBound: CGFloat
    @Binding var selectedItem: String
    @Binding var inventory: [String]
     var getSelectedItemInventory: () -> Void
    
    var body: some View {
        HStack(spacing: 0){
            ZStack{
                Rectangle()
                    .foregroundColor(Color("layer2"))
                    .frame(width: widthBound/5,height: 130)
                    .customCornerRadius(24, corners: [.bottomLeft, .topLeft])
                Text("Hat")
                    .opacity(selectedItem == "Hat" ? 1 : 0.3)
            }.onTapGesture {
                selectedItem = "Hat"
                getSelectedItemInventory()
            }
            ZStack{
                Rectangle()
                    .foregroundColor(Color("layer1"))
                    .frame(width: widthBound/5,height: 130)
                Text("Shirt")
                    .opacity(selectedItem == "Shirt" ? 1 : 0.3)
            }.onTapGesture(){
                selectedItem = "Shirt"
                getSelectedItemInventory()
                print(getSelectedItemInventory)
            }
            ZStack{
                Rectangle()
                    .foregroundColor(Color("layer2"))
                    .frame(width: widthBound/5,height: 130)
                Text("Outer")
                    .opacity(selectedItem == "Outer" ? 1 : 0.3)
            }.onTapGesture(){
                selectedItem = "Outer"
                getSelectedItemInventory()
                
            }
            ZStack{
                Rectangle()
                    .foregroundColor(Color("layer1"))
                    .frame(width: widthBound/5,height: 130)
                Text("Pants")
                    .opacity(selectedItem == "Pants" ? 1 : 0.3)
            }.onTapGesture(){
                selectedItem = "Pants"
                getSelectedItemInventory()
            }
            ZStack{
                Rectangle()
                    .foregroundColor(Color("layer2"))
                    .frame(width: widthBound/5,height: 130).customCornerRadius(24, corners: [.bottomRight, .topRight])
                Text("Shoes")
                    .opacity(selectedItem == "Shoes" ? 1 : 0.3)
            }.onTapGesture(){
                selectedItem = "Shoes"
                getSelectedItemInventory()
            }
        }
        .background(Color("layer1"))
        .frame(width: widthBound,height: 130)
        .cornerRadius(24)
    }
}
