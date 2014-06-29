component name = "MovieDAO" accessors = "false"{

	// Check to see whether or not a movie exists in the database
	public boolean function isKnown(required string path){
		var sSQL = 'select filepath from movie where filepath like :path';
		var mQuery = new Query(sql = sSQL);
		mQuery.addParam(name = 'path', value = '%' & arguments.path & '%', type = 'cf_sql_varchar');
		return mQuery.execute().getResult().recordCount > 0 ? true : false;
	}

}