﻿package kabam.rotmg.build
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IInjector;
    import kabam.rotmg.build.impl.BuildEnvironments;
    import kabam.rotmg.build.api.BuildData;
    import kabam.rotmg.build.impl.CompileTimeBuildData;

    public class BuildConfig implements IConfig 
    {

        [Inject]
        public var injector:IInjector;


        public function configure():void
        {
            this.injector.map(BuildEnvironments).asSingleton();
            this.injector.map(BuildData).toSingleton(CompileTimeBuildData);
        }


    }
}

