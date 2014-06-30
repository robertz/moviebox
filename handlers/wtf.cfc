component output="false" {
	property name="TMDBService" inject="model";
	property name="IndexService" inject="model";
	property name="ORMService" inject="coldbox:plugin:ORMService";
	// Default Action
	function index(event,rc,prc){
		abort;
	}

	function robsHood(event,rc,prc){
		// writeDump(var = EntityLoad('Movie', {}, 'title ASC'));
		writeDump(ormService);
		// var d = fileRead('/data.json');
		// writeDump(var = deserializeJSON(d), abort = 1);
		abort;
	}

	function indexMovies(event,rc,prc){
		writeDump(IndexService.indexMovies());
		abort;
	}

}