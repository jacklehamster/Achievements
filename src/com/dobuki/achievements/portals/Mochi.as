package com.dobuki.achievements.portals
{
	import com.dobuki.achievements.IAchievements;
	import com.dobuki.achievements.ScoreTable;
	import com.dobuki.achievements.Trophy;
	
	import flash.display.DisplayObject;
	
	import mochi.as3.MochiAd;
	import mochi.as3.MochiEvents;
	import mochi.as3.MochiScores;
	import mochi.as3.MochiServices;
	
	public class Mochi implements IAchievements
	{
		private var id:String;
		public var root:DisplayObject;
		public function Mochi()
		{
		}
		
		public function setup(mochiID:String,ads:Boolean):void {
			id = mochiID;
			MochiServices.connect(id, root);
			if(ads)
				MochiAd.showPreGameAd({clip:root, id:id, res:"400x400"});			
		}
		
		public function get username():String
		{
			return null;
		}
		
		public function postScore(score:Number, table:ScoreTable, tag:String=null):void
		{
			var o:Object = { n: [14, 13, 11, 8, 14, 0, 8, 13, 9, 3, 15, 1, 3, 7, 11, 15], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: score});
		}
		
		public function unlock(achievement:Trophy):void
		{
			MochiEvents.unlockAchievement({id:achievement.mochiID});
		}
	}
}