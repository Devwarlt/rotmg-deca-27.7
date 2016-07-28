﻿package kabam.lib.resizing
{
    import kabam.lib.resizing.signals.Resize;
    import kabam.lib.resizing.view.Resizable;
    import kabam.lib.resizing.view.ResizableMediator;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.framework.api.IInjector;

    public class ResizeConfig
    {
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var mediatorMap:IMediatorMap;

        [PostConstruct]
        public function setup():void
        {
            this.injector.map(Resize).asSingleton();
            this.mediatorMap.map(Resizable).toMediator(ResizableMediator);
        }
    }
}

