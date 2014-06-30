component output="false" {
	property name="TMDBService" inject="model";
	property name="IndexService" inject="model";

	// Default Action
	function index(Event, RC, PRC){
		event.setView("admin/index");
	}

	function movies(Event, RC, PRC){
		prc.videoData = EntityLoad('Movie', {}, 'title ASC');
		event.setView('admin/movies');
	}

	function movieDetail(Event, RC, PRC){
		if(!structKeyExists(rc, 'slug')) setNextEvent('admin.movies');
		prc.videoData = EntityLoad('Movie', {id = rc.slug}, true);
		event.setView('admin/movieDetail');
	}

	function movieSearch(Event, RC, PRC){
		prc.searchResults = TMDBService.findMovie(name = rc.search_term);
		event.renderData(type = 'html', data=renderView('_fragments/tmdb_search_results'));
	}

	function renamePath(Event, RC, PRC){
		var result.success = true;
		try{
			directoryRename(rc.oldPath,rc.newPath);
			IndexService.indexMovies();
		}
		catch(any e){
			result.success = false;
		}
		event.renderData(type = 'json', data = result);
	}

}