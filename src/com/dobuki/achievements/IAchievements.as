package com.dobuki.achievements
{
	public interface IAchievements
	{
		function get username():String;
		function postScore(score:Number,table:ScoreTable,tag:String=null):void;
		function unlock(achievement:Trophy):void
	}
}