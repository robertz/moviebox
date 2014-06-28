/*
 * Scans movie directory
 */
component name="IndexService" accessors="false" {
	property name = "Logger" inject = "logbox:logger:{this}";
	property name = "videoDirectory" inject = "coldbox:setting:videoDirectory";
	property name = "TMDBService" inject="model";

	public IndexService function init(){
		return this;
	}

	public void function indexMovies(){
		var dlist = directoryList(path = videoDirectory, listInfo = 'query');
		var config = TMDBService.getConfiguration();
		var movieData = [];
		var secondaryImagePath = getDirectoryFromPath("/data/");
		for(item in dlist){
			var data = TMDBService.scrape(name = listFirst(item.name, "("));
			var theFile = directoryList(path = videoDirectory & '\' & item.name, listInfo = "query", sort = "size DESC");

			// Write to database
			var sql = 'insert into movie(id, filepath, filename, title, genres, overview, runtime, vote_average) values (:id, :filepath, :filename, :title, :genres, :overview, :runtime, :vote_average)';
			var insertMovie = new query(sql = sql);
			var id = rereplacenocase(data.title, '[^a-z0-9]', '-', 'all');
			insertMovie.addParam(name = 'id', value = id, type = 'cf_sql_varchar');
			insertMovie.addParam(name = 'filepath', value = '/media/' & item.name, type = 'cf_sql_varchar');
			insertMovie.addParam(name = 'filename', value = theFile.name[1], type = 'cf_sql_varchar');
			insertMovie.addParam(name = 'title', value = data.title, type = 'cf_sql_varchar');
			insertMovie.addParam(name = 'genres', value = '', type = 'cf_sql_varchar');
			insertMovie.addParam(name = 'overview', value = data.overview, type = 'cf_sql_text');
			insertMovie.addParam(name = 'runtime', value = data.runtime, type = 'cf_sql_varchar');
			insertMovie.addParam(name = 'vote_average', value = data.vote_average, type = 'cf_sql_varchar');
			insertMovie.execute();

			// Process backdrop and poster images
			var outputImagePath = 'D:\Movies\' & item.name;
			// Save to movie folder
			http url = config.images.base_url & 'w1280/' & data.backdrop_path path = outputImagePath file='backdrop.jpg';
			http url = config.images.base_url & 'w185/' & data.poster_path path = outputImagePath file='poster.jpg';
			// Save to data directory
			http url = config.images.base_url & 'w1280/' & data.backdrop_path path = secondaryImagePath & "backdrop" file = id & '.jpg';
			http url = config.images.base_url & 'w185/' & data.poster_path path = secondaryImagePath & "poster" file = id & '.jpg';
		}
		return;
	}

}