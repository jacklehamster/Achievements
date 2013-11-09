package com.dobuki.achievements.portals
{
	import com.dobuki.achievements.IAchievements;
	import com.dobuki.achievements.ScoreTable;
	import com.dobuki.achievements.Trophy;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;

	public class Kongregate implements IAchievements
	{
		private var kongregate:Object;
		
		public function Kongregate()
		{
		}
		
		public function set root(value:DisplayObjectContainer):void {
			var apiPath:String = value.loaderInfo.parameters.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
			Security.allowDomain(apiPath);
			
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			value.addChild(loader);
		}
		
		private function loadComplete(event:Event):void {
			kongregate = event.target.content;
			
			// Connect to the back-end
			kongregate.services.connect();
		}
		
		public function get username():String
		{
			return null;
		}
		
		public function postScore(score:Number, table:ScoreTable, tag:String=null):void
		{
			if(kongregate)
				kongregate.stats.submit(table.kongregateStat,score);
		}
		
		public function unlock(achievement:Trophy):void
		{
			if(kongregate)
				kongregate.stats.submit(achievement.kongregateStat,1);
		}
	}
}