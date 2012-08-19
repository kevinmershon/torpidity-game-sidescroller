package object.enemy {

	import object.CharacterObject;
	import object.TangibleObject;

	public class EnemyObject extends CharacterObject {
		
		/**
		 * EnemyObjects are collision-transparent with each other
		 */
		public override function collisionTest(other:TangibleObject):Boolean {
			if (other is EnemyObject)
				return false;
				
			return super.collisionTest(other);
		}
	}
	
}