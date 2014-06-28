/*
 * Interface with themoviedatabase.org
 */
component name = "TMDBService" accessors = "false"{
	property name = "Logger" inject = "logbox:logger:{this}";
	property name = "api_key" inject = "coldbox:setting:apiKey";

	public TMDBService function init(){
		
		return this;
	}

	public struct function getConfiguration(){
		var result = {};
		var r = '';
		http url = 'http://api.themoviedb.org/3/configuration?api_key=' & api_key result = 'r';
		structAppend(result, deserializeJSON(r.fileContent));
		return result;
	}

	// Scrape a movie
	public struct function scrape(required string name, string year default = ''){
		var result = {};
		var m = findMovie(name = arguments.name, year = arguments.year);
		if(m.total_results){
			structAppend(result, getMovieData(id = m.results[1].id));
		}
		return result;
	}

	/* 
	 *	Private functions
	 */

	private struct function findMovie(required string name, string year default = ''){
		var result = {
			'results' = [],
			'total_pages' = 0,
			'total_results' = 0
		};
		var r = '';
		http url = 'http://api.themoviedb.org/3/search/movie?api_key=' & api_key & '&query=' & arguments.name & '&year=' & arguments.year result = 'r';
		try{
			structAppend(result, deserializeJSON(r.fileContent));
		}
		catch(any e){}
		return result;
	}

	private struct function getMovieData(required string id){
		var result = {};
		var r = '';
		http url = 'http://api.themoviedb.org/3/movie/' & arguments.id & '?api_key=' & api_key result = 'r';
		structAppend(result, deserializeJSON(r.fileContent));
		return result;
	}

}