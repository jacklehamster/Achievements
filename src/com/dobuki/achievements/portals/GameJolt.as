package com.dobuki.achievements.portals
{
	import com.dobuki.achievements.IAchievements;
	import com.dobuki.achievements.ScoreTable;
	import com.dobuki.achievements.Trophy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import by.blooddy.crypto.MD5;
	import by.blooddy.crypto.serialization.JSON;

	public class GameJolt implements IAchievements
	{
		public var root:DisplayObject;
		private var game_id:String, private_key:String;
			
		public function setup(game_id:String,private_key:String):void
		{
			this.game_id = game_id;
			this.private_key = private_key;
		}
		
		public function get username():String {
			return root.loaderInfo.parameters.gjapi_username;
		}
		
		public function get token():String {
			return root.loaderInfo.parameters.gjapi_token;
		}
		
		public function isGuest():Boolean {
			return username=="" && token=="";
		}
		
		public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
			var url:String = "http://gamejolt.com/api/game/v1/scores/add?game_id="+game_id;
			url += "&score="+score;
			url += "&sort="+score;
			url += "&username="+username;
			url += "&user_token="+token;
			if(table.gameJoltId) {
				url += "&table_id="+table.gameJoltId;
			}
			if(tag) {
				url += "&extra_data"+tag;
			}
			performRequest(url,null);
		}
		
		public function unlock(achievement:Trophy):void {
			var url:String = "http://gamejolt.com/api/game/v1/trophies/add-achieved?game_id="+game_id;			
			url += "&username="+username;
			url += "&user_token="+token;
			url += "&trophy_id="+achievement.gamejolt_id;
			performRequest(url,null);
		}
		
		private function performRequest(url:String,callback:Function):void {
			if(username && token) {
				var md5:String = MD5.hash(url+private_key);
				url += "&signature="+md5;
				var loader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest(url);
				var onComplete:Function = function(e:Event):void {
						loader.removeEventListener(Event.COMPLETE,onComplete);
						loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
						var result:Object = {};
						var itemSplit:Array = loader.data.split("\n");
						for each(var line:String in itemSplit) {
							var pair:Array = line.split(":");
							result[pair[0]] = by.blooddy.crypto.serialization.JSON.decode(pair[1]);
						}
						if(callback)
							callback(result);
					};
				var onError:Function = function(e:Event):void {
						loader.removeEventListener(Event.COMPLETE,onComplete);
						loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
						if(callback)
							callback(null);
					};
				loader.addEventListener(Event.COMPLETE,onComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
				loader.load(request);
			}
			else {
				if(callback)
					callback(null);
			}
		}
	}
}