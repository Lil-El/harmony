// @formatter:on
import Timer, { TimerData } from "entry/ets/utils/Timer";
import { window } from "@kit.ArkUI";
import { common } from "@kit.AbilityKit";

@Entry
@ComponentV2
struct Index {
  // 路由页面栈
  @Provider() pageStack: NavPathStack = new NavPathStack();

  /**
   * navDestination 的构建函数
   *
   * @param name 路由名称
   * @param param 路由参数
   *
   * @description
   * 使用 Navigation().navDestination() 会和 routerMap 冲突
   * builder 里可以根据不同的 name 设置不同的组件
   * 组件必须由 NavDestination 组件包裹
   */
  @Builder
  builder(name: string, param: Object) {
  }

  aboutToAppear() {
    const ctx = this.getUIContext().getHostContext() as common.UIAbilityContext;
    const windowStage: window.WindowStage = ctx.windowStage as window.WindowStage; // createSubWindow...
    const windowClass = windowStage.getMainWindowSync();

    if (canIUse("SystemCapability.Window.SessionManager")) {
      windowClass.setSpecificSystemBarEnabled("status", false)
      windowClass.setSpecificSystemBarEnabled("navigation", false)
    }

    // this.pageStack.pushPath({ name: 'Home' });
  }

  onBackPress(): boolean | void {
    return true;
  }

  build() {
    /**
     * Navigation 的结构：类似于系统设置页面，包含标题、菜单、工具，每一个列表项都是一个路由
     *
     * Navigation() inspector 结构：
     * NavBar：
     *    -> Title：
     *       -> Menus
     *    -> 子组件
     *    -> ToolBar
     * NavigationContent -> NavDestination
     *
     * 只有在路由跳转之后的页面才属于 NavigationContent，默认的子组件都是NavBar区域下
     *
     * 路由1：
     *  使用.navDestination(Builder) 会替代 routerMap
     *
     * 路由2：
     *  .hideNavBar(true) 将整个页面变为空白，在 appear 中直接跳转其他页面，摆脱 Navigation 页面的结构局限
     *
     * 路由3：（本示例采用这个方式）
     *  .hideToolBar, .hideTitleBar 后，子组件内容将占满整个 NavBar 区域
     */
    Navigation(this.pageStack) {
      StartPage({ duration: 1 })
    }
    .hideToolBar(true)
    .hideTitleBar(true)
    .height('100%')
    .width('100%')
  }
}

@ComponentV2
struct StartPage {
  // 启动页时长
  @Param @Once duration: number = 0;

  // 定时器
  private timerData: TimerData | undefined;

  // pageStack: NavPathStack = new NavPathStack(); 可以通过组件属性传递 pageStack
  @Consumer('pageStack') pageStack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    // Tips: Harmony 的 setInterval 居然是从 0 开始，和 JavaScript 不同
    this.timerData = Timer.createInterval(() => {
      if (this.duration === 0) {
        this.replacePage();
        return;
      }

      this.duration--;
    }, 1000)
  }

  // 页面跳转
  replacePage(): void {
    if (this.timerData) {
      Timer.clear(this.timerData);
    }

    this.pageStack.replacePathByName("Login", {}, true);
  }

  aboutToDisappear(): void {
    if (this.timerData) {
      Timer.clear(this.timerData);
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r("app.media.start"))

      Button(`跳过 ${this.duration}`)
        .buttonStyle(ButtonStyleMode.TEXTUAL)
        .margin({ top: 40, right: 10 })
        .onClick(() => this.replacePage())
    }
    .size({ width: "100%", height: "100%" })
  }
}