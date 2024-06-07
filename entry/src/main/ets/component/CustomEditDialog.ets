@Component
export default struct CustomEditDialog {
  @Link editTitle: string
  @Link editContent: string
  onClose: () => void
  onDelete:()=> void
  onSave: () => void

  build() {
    Stack() {
      // 蒙层
      Rect()
        .height('100%')
        .width('100%')
        .fill('rgba(0,0,0,0.4)')
        .onClick(() => {
          this.onClose()
        })

      // 编辑卡片
      Column() {
        //标题输入
        TextInput({
          placeholder: $r('app.string.titleText'),
          text: this.editTitle
        })
          .onChange((value: string) =>{
            this.editTitle = value
          })
          .height('10%')
          .margin({top:10, left:20, right:20})

        // 文本输入
        TextArea({
          placeholder: $r('app.string.contentText'),
          text: this.editContent
        })
          .onChange((value: string) => {
            this.editContent = value
          })
          .height('60%')
          .margin(20)


        // 按钮
        Row() {
          // 返回
          Column() {
            Image($r('app.media.back'))
              .width(24)
          }
          .backgroundColor('#BFA290')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onClose()
          })

          // 删除
          Column() {
            Image($r('app.media.delete'))
              .width(24)
          }
          .backgroundColor('#BFA290')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onDelete()
          })

          // 保存
          Column() {
            Image($r('app.media.save'))
              .width(24)
          }
          .backgroundColor('#9E7F6B')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onSave()
          })

        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')
      .height('60%')
      .borderRadius({ topLeft: 16, topRight: 16 })
      .backgroundColor('#F0D9B8')

    }
    .height('100%')
    .width('100%')
    .alignContent(Alignment.Bottom)

  }
}
