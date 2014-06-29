component output="false" {
 property name="TMDBService" inject="model";
 property name="IndexService" inject="model";

 // Default Action
 function index(event,rc,prc){
  abort;
 }

 // Default Action
 function robsHood(event,rc,prc){
 	// writeDump(var = EntityLoad('Movie', {}, 'title ASC'));
  writeDump(IndexService.indexMovies());
  // var d = fileRead('/data.json');
  // writeDump(var = deserializeJSON(d), abort = 1);
  abort;
 }

}