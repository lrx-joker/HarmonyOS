import router from '@ohos.router';
import PreferencesUtil from '../utils/PreferencesUtil';

@Entry
@Component
struct Index {
  //保存用户输入的密码
  @State password: string = ''

  async aboutToAppear(){
    this.password = await PreferencesUtil.getData('password','password','') as string
    if (this.password == ''){
      AlertDialog.show(
        {
          title: $r('app.string.dialogTitle'),
          message: $r('app.string.dialogMessage'),
          autoCancel: false,
          alignment: DialogAlignment.Bottom,
          offset: { dx: 0, dy: -20 },
          confirm: {
            value: $r('app.string.button'),
            action: () => {
              console.info('Callback when confirm button is clicked');
            }
          },
          cancel: () => {
            console.info('Closed callbacks')
          }
        }
      )
    }
  }

  build() {
    Column({space:5}) {
      Text($r('app.string.EntryAbility_label'))
        .margin({top:70})
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      Image($r("app.media.icon2"))
        .width(200)
        .height(200)
        .borderRadius(35)
        .margin({top:30,bottom:30})
        .backgroundColor(Color.Transparent)
      Row(){
        Text($r('app.string.mima'))
          .fontSize(25)
          .fontWeight(FontWeight.Normal)
        TextInput({placeholder:$r('app.string.mimaText'),text: this.password})
          .placeholderColor(Color.Gray)
          .placeholderFont({size:20, weight:FontWeight.Medium})
          .type(InputType.Password)
          .width('80%')
          .onChange(value =>{
            console.log(value)
            this.password = value
            PreferencesUtil.setData('password','password',value)
          })
      }
      .width('100%')
      .borderRadius(12)
      .padding(25)
      .margin({top:10})
      Button($r('app.string.button'), { type: ButtonType.Capsule, stateEffect: true })
        .borderRadius(10)
        .margin({top:10})
        .width('50%')
        .height(55)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#007DFF')
        .onClick(()=>{
          if(this.password.length < 4 || this.password.length > 9){
            AlertDialog.show(
              {
                message: $r('app.string.dialogMessage2'),
                autoCancel: false,
                alignment: DialogAlignment.Center,
                offset: { dx: 0, dy: -20 },
                confirm: {
                  value: $r('app.string.button'),
                  action: () => {
                    console.info('Callback when confirm button is clicked');
                  }
                },
                cancel: () => {
                  console.info('Closed callbacks')
                }
              }
            )
          }else {
            router.pushUrl({url:'pages/Index'})
          }

        })
    }
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize({width:'100%', height:'100%'})
    .width('100%')
    .height('100%')
    .padding({
      left:10,
      right:10
    })
  }
}

