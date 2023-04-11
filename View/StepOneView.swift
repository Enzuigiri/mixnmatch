//
//  StepOneView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI

struct StepOneView: View {
    @Binding var currentOutfitIndex : Int
    func getSelectedColor() -> Binding<[CGFloat]>{
        if(selectedItem == "Pants"){
            return $outfitModel.pantsColor
        } else if (selectedItem == "Shirt"){
            return $outfitModel.shirtColor
        } else if (selectedItem == "Outer"){
            return $outfitModel.outerColor
        } else if (selectedItem == "Hat"){
            return $outfitModel.hatColor
        } else if (selectedItem == "Shoes"){
            return $outfitModel.shoesColor
        }
        else {
            return $selectedColor
        }
        
    }
    
    func setSelectedItem(item: String) -> Void{
        if(selectedItem == "Pants"){
            outfitModel.pants = item
        } else if (selectedItem == "Shirt"){
            outfitModel.shirt = item
        } else if (selectedItem == "Outer"){
            outfitModel.outer = item
        } else if (selectedItem == "Hat"){
            outfitModel.hat = item
        } else if (selectedItem == "Shoes"){
            outfitModel.shoes = item
        }
        else {
            selectedItem = ""
        }
    }
    
    func getSelectedItem() -> Binding<String>{
        if(selectedItem == "Pants"){
            return $outfitModel.pants
        } else if (selectedItem == "Shirt"){
            return $outfitModel.shirt
        } else if (selectedItem == "Outer"){
            return $outfitModel.outer
        } else if (selectedItem == "Hat"){
            return $outfitModel.hat
        } else if (selectedItem == "Shoes"){
            return $outfitModel.shoes
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
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedColor: [CGFloat] = Color(.gray).toHSBArray()
    @State private var magnification: CGFloat = 1.0
    @State private var scale: CGFloat = 1.0
    //    @State private var offset: CGSize = CGSize.zero
    @State private var offsetX : CGFloat = CGFloat.zero
    @State private var offsetY : CGFloat = CGFloat.zero
    @GestureState private var offset: CGSize = .zero
    //    @State private var offsetAccumulated = CGSize.zero
    @State private var selectedItem : String = ""
    
    private let shirtItems: [String] = ["outfit-none", "shirt-base"]
    private let pantsItems: [String] = ["outfit-none", "pants-short"]
    private let outerItems: [String] = ["outfit-none", "outer-gardigan"]
    private let hatItems: [String] = ["outfit-none"]
    private let shoesItems: [String] = ["outfit-none"]
    @State private var inventory: [String] = []
    
    //    @ObservedObject var outfitModel = outfitModel()
    @ObservedObject var outfitModel = OutfitModel(id: nil)
    
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
                            NavigationLink(destination : StepTwoView(outfitModel: outfitModel)){
                                Text("Next")
                                    .padding(.horizontal, 32)
                                    .frame(height: 60)                            .background(Color("layer1"))
                                    .foregroundColor(.black)
                                    .cornerRadius(16)
                                
                                
                            }
                            
                        }
                        AvatarView(outfitModel: outfitModel)
                            .frame(width: widthBound, height: heightBound)
                            .scaleEffect(magnification)
                            .offset(CGSize(width: offsetX + offset.width, height:offsetY + offset.height))
                            .scaleEffect(magnification)
                            .gesture(
                                DragGesture()
                                    .updating($offset, body: { value, state, _ in
                                        state = value.translation
                                    })
                                    .onEnded({ tes in
                                        
                                        offsetX += tes.location.x - tes.startLocation.x
                                        offsetY += tes.location.y - tes.startLocation.y
                                        print(offsetX, offsetY)
                                        
                                        
                                    })
                                
                            ).gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        magnification = value
                                    }
                            )
                        
                        
                    }
                    //right
                    VStack(spacing: 32){
                        // ITEM NAVIGATION
                        
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
                                                print(selectedItem)
                                                print(inventory[index])
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
                        // ITEM NAVIGATION
                        ItemNavigationView(widthBound: widthBound, selectedItem: $selectedItem, inventory: $inventory, getSelectedItemInventory: getSelectedItemInventory)
                        
                        // ITEM COLOR PICKER
                        ColorPickerView(widthBound: widthBound, selectedColor: getSelectedColor(), selectedItem: selectedItem)
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
        StepOneView(currentOutfitIndex: .constant(0))
    }
}

struct ColorPickerView: View {
    var widthBound: CGFloat
    @Binding var selectedColor: [CGFloat]
    @State var pickedColor: Color = Color.gray
    @State private var showColorGenerator: Bool = false
    var selectedItem: String
    
    @State var swatchesColors : [Color] = ColorViewModel().allColors()
    
    let colorViewModel = ColorViewModel()
    
    @State var showConfirmation : Bool = false
    
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
                        ColorPicker("", selection: $pickedColor)
                            .onChange(of: pickedColor, perform: { newValue in
                                selectedColor = pickedColor.toHSBArray()
                            })
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
                            //                            alignment: .center
                        ){
                            ForEach(0..<swatchesColors.count, id: \.self){
                                i in
                                Rectangle()
                                    .confirmationDialog("test", isPresented: $showConfirmation){
                                        Button("Remove"){
                                            colorViewModel.deleteColor(index: i)
                                            swatchesColors = colorViewModel.allColors()
                                        }
                                    }
                                //                                    .gesture(
                                //                                        LongPressGesture(minimumDuration: 0.3)
                                //                                            .onEnded{
                                //                                                _ in
                                //                                                showConfirmation = true
                                //                                                print("lng", i)
                                //                                            }
                                //                                    )
                                    .onTapGesture {
                                        selectedColor = swatchesColors[i].toHSBArray()
                                    }
                                    .foregroundColor(swatchesColors[i])
                                    .
                                frame(width: 36, height: 36)
                                    .cornerRadius(8)
                                
                                
                                
                                
                                
                                
                            }
                        }
                    }
                    .frame(width: widthBound - 180 - 32)
                    HStack{
                        Button(action: {
                            colorViewModel.saveColor(color: Color(hueSaturationBrightness: selectedColor))
                            swatchesColors = colorViewModel.allColors()
                        }) {
                            Text("add to swatch")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        }
                        .background(Color("layer2"))
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        Button(action: {
                            print("toggled")
                            showColorGenerator.toggle()
                        }) {
                            Text("color harmony")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        }
                        .background(Color("layer2"))
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .sheet(isPresented: $showColorGenerator){
                            GenerateColorView(baseColor: Color(hueSaturationBrightness: selectedColor), swatchesColor: $swatchesColors)
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
