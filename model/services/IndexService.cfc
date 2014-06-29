/*
 * Scans movie directory
 */
component name="IndexService" accessors="false" {
	property name = "Logger" inject = "logbox:logger:{this}";
	property name = "videoDirectory" inject = "coldbox:setting:videoDirectory";
	property name = "MovieDAO" inject = "model";
	property name = "TMDBService" inject = "model";
	property name = "UtilityService" inject = "model";
	
	public IndexService function init(){
		return this;
	}

	public void function indexMovies(){
		var dlist = directoryList(path = videoDirectory, listInfo = 'query');
		var config = TMDBService.getConfiguration();
		var movieData = [];
		var secondaryImagePath = getDirectoryFromPath("/data/");
		for(item in dlist){
			if(!MovieDAO.isKnown(path = item.name)){
				var data = TMDBService.scrape(name = listFirst(item.name, "("));
				var theFile = directoryList(path = videoDirectory & '/' & item.name, listInfo = "query", sort = "size DESC");

				// Write to database
				var sql = 'insert into movie(id, filepath, filename, title, release_year, genres, overview, runtime, vote_average) values (:id, :filepath, :filename, :title, :release_year, :genres, :overview, :runtime, :vote_average)';
				var insertMovie = new Query(sql = sql);
				var genres = '';

				for(var g in data.genres){
					genres = listAppend(genres, ' ' & g.name);
				}
				// Slugify the movie name
				var id = UtilityService.slugify(data.title);
				insertMovie.addParam(name = 'id', value = id, type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'filepath', value = '/media/' & item.name, type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'filename', value = theFile.name[1], type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'title', value = data.title, type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'release_year', value = listFirst(data.release_date, '-'), type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'genres', value = trim(genres), type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'overview', value = data.overview, type = 'cf_sql_text');
				insertMovie.addParam(name = 'runtime', value = data.runtime, type = 'cf_sql_varchar');
				insertMovie.addParam(name = 'vote_average', value = data.vote_average, type = 'cf_sql_varchar');
				insertMovie.execute();

				// Process backdrop and poster images
				// Does our data directory exist?
				var basePath = expandPath('/');
				if(!directoryExists(basePath & 'data/')){
					directoryCreate(basePath & 'data');
					directoryCreate(basePath & 'data/backdrop');
					directoryCreate(basePath & 'data/poster');
				}
				// Download images from tmdb.org
				http url = config.images.base_url & 'w1280/' & data.backdrop_path path = secondaryImagePath & "backdrop" file = id & '.jpg';
				http url = config.images.base_url & 'w185/' & data.poster_path path = secondaryImagePath & "poster" file = id & '.jpg';

				// Write images to movie folder
				var outputImagePath = 'D:/Movies/' & item.name;
				fileCopy(secondaryImagePath & 'backdrop/' & id & '.jpg', outputImagePath & '/backdrop.jpg');
				fileCopy(secondaryImagePath & 'poster/' & id & '.jpg', outputImagePath & '/poster.jpg');
			}
		}
		return;
	}

}