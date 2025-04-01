import { NavDestinationModifier } from '@kit.ArkUI';

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

export class titleAttributeModifier implements AttributeModifier<NavDestinationAttribute> {
  private _title: string;

  constructor(value: string) {
    this._title = value;
  }

  public set title(value: string) {
    this._title = value;
  }

  applyNormalAttribute(instance: NavDestinationAttribute): void {
    instance.title(this._title)
  }
}