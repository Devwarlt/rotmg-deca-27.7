﻿package com.company.assembleegameclient.ui
{
    import com.company.assembleegameclient.game.AGameSprite;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import kabam.rotmg.messaging.impl.incoming.TradeStart;
    import kabam.rotmg.text.model.TextKey;

    public class TradePanel extends Sprite
    {
        public static const WIDTH:int = 200;
        public static const HEIGHT:int = 400;
        public var gs_:AGameSprite;
        private var myInv_:TradeInventory;
        private var yourInv_:TradeInventory;
        private var cancelButton_:DeprecatedTextButton;
        private var tradeButton_:TradeButton;

        public function TradePanel(_arg1:AGameSprite, _arg2:TradeStart)
        {
            this.gs_ = _arg1;
            var _local3:String = this.gs_.map.player_.name_;
            this.myInv_ = new TradeInventory(_arg1, _local3, _arg2.myItems_, true);
            this.myInv_.x = 14;
            this.myInv_.y = 0;
            this.myInv_.addEventListener(Event.CHANGE, this.onMyInvChange);
            addChild(this.myInv_);
            this.yourInv_ = new TradeInventory(_arg1, _arg2.yourName_, _arg2.yourItems_, false);
            this.yourInv_.x = 14;
            this.yourInv_.y = 174;
            addChild(this.yourInv_);
            this.cancelButton_ = new DeprecatedTextButton(16, TextKey.PLAYERMENU_CANCEL, 80);
            this.cancelButton_.addEventListener(MouseEvent.CLICK, this.onCancelClick);
            this.cancelButton_.textChanged.addOnce(this.onCancelTextChanged);
            addChild(this.cancelButton_);
            this.tradeButton_ = new TradeButton(16, 80);
            this.tradeButton_.x = (((3 * WIDTH) / 4) - (this.tradeButton_.bWidth / 2));
            this.tradeButton_.addEventListener(MouseEvent.CLICK, this.onTradeClick);
            addChild(this.tradeButton_);
            this.checkTrade();
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onCancelTextChanged():void
        {
            this.cancelButton_.x = ((WIDTH / 4) - (this.cancelButton_.bWidth / 2));
            this.cancelButton_.y = ((HEIGHT - this.cancelButton_.height) - 10);
            this.tradeButton_.y = this.cancelButton_.y;
        }

        public function setYourOffer(_arg1:Vector.<Boolean>):void
        {
            this.yourInv_.setOffer(_arg1);
            this.checkTrade();
        }

        public function youAccepted(_arg1:Vector.<Boolean>, _arg2:Vector.<Boolean>):void
        {
            if (((this.myInv_.isOffer(_arg1)) && (this.yourInv_.isOffer(_arg2))))
            {
                this.yourInv_.setMessage(TradeInventory.TRADEACCEPTED_MESSAGE);
            }
        }

        private function onAddedToStage(_arg1:Event):void
        {
            stage.addEventListener(Event.ACTIVATE, this.onActivate);
        }

        private function onRemovedFromStage(_arg1:Event):void
        {
            stage.removeEventListener(Event.ACTIVATE, this.onActivate);
        }

        private function onActivate(_arg1:Event):void
        {
            this.tradeButton_.reset();
        }

        private function onMyInvChange(_arg1:Event):void
        {
            this.gs_.gsc_.changeTrade(this.myInv_.getOffer());
            this.checkTrade();
        }

        private function onCancelClick(_arg1:MouseEvent):void
        {
            this.gs_.gsc_.cancelTrade();
            dispatchEvent(new Event(Event.CANCEL));
        }

        private function onTradeClick(_arg1:MouseEvent):void
        {
            this.gs_.gsc_.acceptTrade(this.myInv_.getOffer(), this.yourInv_.getOffer());
            this.myInv_.setMessage(TradeInventory.TRADEACCEPTED_MESSAGE);
        }

        public function checkTrade():void
        {
            var _local1:int = this.myInv_.numIncluded();
            var _local2:int = this.myInv_.numEmpty();
            var _local3:int = this.yourInv_.numIncluded();
            var _local4:int = this.yourInv_.numEmpty();
            var _local5:Boolean = true;
            if (((_local3 - _local1) - _local2) > 0)
            {
                this.myInv_.setMessage(TradeInventory.NOTENOUGHSPACE_MESSAGE);
                _local5 = false;
            }
            else
            {
                this.myInv_.setMessage(TradeInventory.CLICKITEMS_MESSAGE);
            }
            if (((_local1 - _local3) - _local4) > 0)
            {
                this.yourInv_.setMessage(TradeInventory.NOTENOUGHSPACE_MESSAGE);
                _local5 = false;
            }
            else
            {
                this.yourInv_.setMessage(TradeInventory.TRADEWAITING_MESSAGE);
            }
            if (_local5)
            {
                this.tradeButton_.reset();
            }
            else
            {
                this.tradeButton_.disable();
            }
        }
    }
}

