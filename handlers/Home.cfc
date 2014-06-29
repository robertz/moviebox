component output="false" {

	// Default Action
	function index(event,rc,prc){
		prc.videoData = EntityLoad('Movie', {}, 'title ASC');

		event.setView("home/index");
	}

	// Default Action
	function video(event,rc,prc){
		if(!structKeyExists(rc, 'slug')) setNextEvent('home');
		prc.video = prc.videoData = EntityLoad('Movie', {id = rc.slug}, true);
		prc.mediaType = listLast(prc.video.getFilename(), '.') == "mkv" ? "mp4" : listLast(prc.video.getFilename(), '.');

		event.setView("home/video");
	}

}