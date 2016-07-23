﻿package kabam.rotmg.pets.controller
{
    import com.company.assembleegameclient.editor.Command;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.messaging.impl.EvolvePetInfo;
	import robotlegs.bender.framework.api.IInjector;
    import kabam.rotmg.pets.view.dialogs.evolving.EvolveDialog;

    public class EvolvePetCommand extends Command 
    {

        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var evolvePetInfo:EvolvePetInfo;
        [Inject]
        public var injector:IInjector;


        override public function execute():void
        {
            var _local1:EvolveDialog = this.injector.getInstance(EvolveDialog);
            this.openDialog.dispatch(_local1);
            _local1.evolveAnimation.setEvolvedPets(this.evolvePetInfo);
        }


    }
}

