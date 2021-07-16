class SlotObject {
  SlotObject(
      {this.title = "Võng 2 lớp Nature Hike có tăng bao phủ",
      this.childSlot = 0,
      this.desc =
          "Võng 2 lớp đem lại cảm giác an toàn ấm cúng không sợ mưa gió. Có trang bị sẵn dây treo balo, túi ngủ cùng một số vật dụng cần thiết khác",
      this.price = 120000,
      this.slot = 1,
      this.type = "Võng",
      this.maxCount = 1});
  String title;
  String type;
  int slot;
  int childSlot;
  int price;
  String desc;
  int maxCount;

  setTitle(String titleInput) => title = titleInput;
  setType(String typeInput) => type = typeInput;
  setSLot(int slotInput) => slot = slotInput;
  setChildSlot(int childSlotInput) => childSlot = childSlotInput;
  setPrice(int priceInput) => price = priceInput;
  setDesc(String descInput) => desc = descInput;
  setMaxCount(int maxCountInput) {
    maxCount = maxCountInput;
    print(maxCount.toString());
  }
}
