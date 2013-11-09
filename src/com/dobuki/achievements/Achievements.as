package com.dobuki.achievements
{
	import com.dobuki.achievements.portals.GameJolt;
	import com.dobuki.achievements.portals.Kongregate;
	import com.dobuki.achievements.portals.Mochi;
	import com.dobuki.achievements.portals.Newgrounds;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Achievements implements IAchievements
	{
		private var root:DisplayObject;
		private var gameJolt:GameJolt = new GameJolt();
		private var newgrounds:Newgrounds = new Newgrounds();
		private var kongregate:Kongregate = new Kongregate();
		private var mochiMedia:Mochi = new Mochi();
		
		public function Achievements(root:DisplayObjectContainer)
		{
			this.root = root;
			kongregate.root = root;
			gameJolt.root = root;
			mochiMedia.root = root;
		}

		public function get username():String {
			return gameJolt.username ? gameJolt.username : newgrounds.username;
		}

		public function setGameJolt(game_id:String,private_key:String):void {
			gameJolt.setup(game_id,private_key);
		}
		
		public function setMochi(game_id:String,ads:Boolean):void {
			mochiMedia.setup(game_id,ads);
		}
		
		public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
			if(gameJolt) {
				gameJolt.postScore(score,table,tag);
			}
			if(newgrounds) {
				newgrounds.postScore(score,table,tag);
			}
		}
		
		public function unlock(achievement:Trophy):void {
			gameJolt.unlock(achievement);
			newgrounds.unlock(achievement);
		}
	}
}