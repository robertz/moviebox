component output="false" {

	// Default Action
	function index(event,rc,prc){
		var sSQL = 'select * from movie';
		var mQuery = new Query(datasource = "moviebox", sql = sSQL);
		prc.videoData = mQuery.execute().getResult();

		event.setView("home/index");
	}

	// Default Action
	function video(event,rc,prc){
		if(!structKeyExists(rc, 'slug')) setNextEvent('home');
		var sSQL = "select * from movie where id = :id";
		var mQuery = new Query(datasource = 'moviebox', sql = sSQL);
		mQuery.addParam(name = 'id', value = rc.slug, type = 'cf_sql_varchar');
		prc['video'] = mQuery.execute().getResult();
		prc.mediaType = listLast(prc.video.fileName, '.') == "mkv" ? "mp4" : listLast(prc.video.fileName, '.');

		event.setView("home/video");
	}

}