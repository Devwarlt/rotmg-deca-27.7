﻿package kabam.rotmg.errors
{
    import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.errors.view.ErrorMediator;
    import kabam.rotmg.errors.control.ErrorSignal;
    import kabam.rotmg.errors.control.ReportErrorToAppEngineCommand;
    import kabam.rotmg.errors.control.LogErrorCommand;

    public class ErrorConfig implements IConfig 
    {

        [Inject]
        public var injector:IInjector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;
        [Inject]
        public var setup:ApplicationSetup;


        public function configure():void
        {
            this.mediatorMap.map(WebMain).toMediator(ErrorMediator);
            this.mapErrorCommand();
        }

        private function mapErrorCommand():void
        {
            if (this.setup.areErrorsReported())
            {
                this.commandMap.map(ErrorSignal).toCommand(ReportErrorToAppEngineCommand);
            }
            else
            {
                this.commandMap.map(ErrorSignal).toCommand(LogErrorCommand);
            };
        }


    }
}

