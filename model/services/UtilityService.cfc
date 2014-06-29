/*
 *  Repository for utility methods
 */
component name = "UtilityService" accessors = "false"{

	public UtilityService function init(){
		return this;
	}

	public string function slugify(required string inputString){
		return rereplacenocase(arguments.inputString, '[^a-z0-9]', '-', 'all');
	}

}