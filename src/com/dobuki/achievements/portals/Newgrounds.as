package com.dobuki.achievements.portals
{
	import com.dobuki.achievements.IAchievements;
	import com.dobuki.achievements.ScoreTable;
	import com.dobuki.achievements.Trophy;
	import com.newgrounds.API;

	public class Newgrounds implements IAchievements
	{
		public function Newgrounds()
		{
		}
		
		public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
			API.postScore(table.newgroundsName?table.newgroundsName:API.scoreBoards[0],score,tag);
		}
		
		public function unlock(achievement:Trophy):void {
			API.unlockMedal(achievement.newgrounds_id);
		}
		
		public function get username():String {
			return API.username;
		}
	}
}