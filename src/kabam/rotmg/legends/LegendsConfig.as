﻿package kabam.rotmg.legends
{
    import kabam.rotmg.legends.control.ExitLegendsCommand;
    import kabam.rotmg.legends.control.ExitLegendsSignal;
    import kabam.rotmg.legends.control.FameListUpdateSignal;
    import kabam.rotmg.legends.control.RequestFameListCommand;
    import kabam.rotmg.legends.control.RequestFameListSignal;
    import kabam.rotmg.legends.model.LegendFactory;
    import kabam.rotmg.legends.model.LegendsModel;
    import kabam.rotmg.legends.service.GetLegendsListTask;
    import kabam.rotmg.legends.view.LegendsMediator;
    import kabam.rotmg.legends.view.LegendsView;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IInjector;

    public class LegendsConfig implements IConfig
    {
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;

        public function configure():void
        {
            this.injector.map(LegendFactory).asSingleton();
            this.injector.map(LegendsModel).asSingleton();
            this.injector.map(FameListUpdateSignal).asSingleton();
            this.injector.map(GetLegendsListTask);
            this.mediatorMap.map(LegendsView).toMediator(LegendsMediator);
            this.commandMap.map(RequestFameListSignal).toCommand(RequestFameListCommand);
            this.commandMap.map(ExitLegendsSignal).toCommand(ExitLegendsCommand);
        }
    }
}

