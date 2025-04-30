// @formatter:on

@Builder
export function LoginBuilder() {
  Login();
}

@Styles
function commonItemStyle() {
  .width("100%")
  .margin(20)
  .onClick(() => {
    console.log("click common Item.")
  })
}

@ComponentV2
struct Login {
  @Consumer("pageStack") pageStack: NavPathStack = new NavPathStack();

  @Local loading: boolean = false;

  @Local angle: number = 0;

  build() {
    NavDestination() {
      Column() {
        Text("登录").fontSize(28).margin(20)
        TextInput({ placeholder: "请输入账号" }).type(InputType.USER_NAME).commonItemStyle()
        TextInput({ placeholder: "请输入密码" }).type(InputType.Password).commonItemStyle()

        Button({ stateEffect: !this.loading }) {
          Row() {
            if (this.loading) {
              // animation：属性动画；this.getUIContext().animateTo 显示动画；this.getUIContext().keyframeAnimateTo 多端属性动画；
              // 动画属性 rotate 必须在 animation 之前，否则无效；
              // angle 设置必须在显示之后才生效
              SymbolGlyph($r('sys.symbol.arrow_clockwise'))
                .fontColor([Color.White, Color.Black, Color.Green])
                .fontWeight(FontWeight.Bold)
                .rotate({ angle: this.angle })
                .animation({
                  duration: 1000,
                  iterations: -1,
                  curve: Curve.Linear,
                })
                .onAppear(() => {
                  this.angle = 360
                })
                .onDisAppear(() => {
                  this.angle = 0
                })
            }
            Text('登录').fontColor(0xffffff).margin({ left: 12 })
          }
        }
        .commonItemStyle()
        .height(40)
        .backgroundColor(this.loading ? 0xa0cfff : 0x0a59f7)
        .onClick(() => {
          if (this.loading) {
            return;
          }

          this.loading = true;
          // mock http request
          setTimeout(() => {
            this.pageStack.replacePathByName("Home", { name: "Mino" }, true);

            this.loading = false;
          }, 1000)
        })
      }
      .padding({
        top: "20%",
        left: 20,
        right: 20,
        bottom: 20
      })
      .width("100%")
      .height("100%")
    }
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}