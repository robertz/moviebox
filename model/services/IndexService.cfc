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
				var theFile = directoryList(path = videoDirectory & item.name, listInfo = "query", sort = "size DESC");
				var genres = '';
				for(var g in data.genres){
					genres = listAppend(genres, ' ' & g.name);
				}
				var movieData = {
					'id' = UtilityService.slugify(data.title),
					'filepath' = item.name,
					'filename' = theFile.name[1],
					'title' = data.title,
					'release_year' = listFirst(data.release_date, '-'),
					'genres' = trim(genres),
					'overview' = data.overview,
					'runtime' = data.runtime,
					'vote_average' = data.vote_average
				};	

				var movie = EntityNew('Movie', movieData);
				EntitySave(movie);

				// Process backdrop and poster images
				// Does our data directory exist?
				var basePath = expandPath('/');
				if(!directoryExists(basePath & 'data/')){
					directoryCreate(basePath & 'data');
					directoryCreate(basePath & 'data/backdrop');
					directoryCreate(basePath & 'data/poster');
				}
				// Download images from tmdb.org
				http url = config.images.base_url & 'w1280/' & data.backdrop_path path = secondaryImagePath & "backdrop" file = movieData.id & '.jpg';
				http url = config.images.base_url & 'w185/' & data.poster_path path = secondaryImagePath & "poster" file = movieData.id & '.jpg';

				// Write images to movie folder
				var outputImagePath = videoDirectory & item.name;
				fileCopy(secondaryImagePath & 'backdrop/' & movieData.id & '.jpg', outputImagePath & '/backdrop.jpg');
				fileCopy(secondaryImagePath & 'poster/' & movieData.id & '.jpg', outputImagePath & '/poster.jpg');
			}
		}
		return;
	}

}