// @formatter:on

@Builder
export function LoginBuilder() {
  Login();
}

@Component
struct Login {
  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Text("登录")
        TextInput({ placeholder: "请输入账号" }).type(InputType.USER_NAME)
        TextInput({ placeholder: "请输入密码" }).type(InputType.Password)
      }
      .width("100%")
      .height("100%")
    }
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}