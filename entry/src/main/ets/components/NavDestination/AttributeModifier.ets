import { NavDestinationModifier } from '@kit.ArkUI';

// NavDestinationModifier 内置属性修改器
export default class commonAttributeModifier extends NavDestinationModifier {
  applyNormalAttribute?(instance: NavDestinationAttribute): void {
    // super.applyNormalAttribute(instance);
    instance
      .hideToolBar(true)
      .hideTitleBar(false)
      .height('100%')
      .width('100%')
      .backgroundColor(0xffffff)
  }
}

// 自己实现属性修改器
@ObservedV2
export class titleAttributeModifier implements AttributeModifier<NavDestinationAttribute> {
  @Trace private _title: string;

  constructor(title: string) {
    this._title = title;
  }

  public set title(title: string) {
    this._title = title;
  }

  applyNormalAttribute(instance: NavDestinationAttribute): void {
    instance.title(this._title)
  }
}