<cfoutput>
<script type="text/javascript" src="/includes/js/pages/movie-detail.js"></script>
<br />
<div class="well">
	<div class="row">
		<div class = "col-md-2">
			<img src="/data/poster/#prc.videoData.getID()#.jpg" />
		</div>
		<div class="col-md-5">
			<table class="table">
				<tr><td align="right">Title</td><td>#prc.videoData.getTitle()#</td></tr>
				<tr>
					<td align="right">Filepath</td>
					<td>
						<span class="path-text">#replaceNoCase(prc.videoData.getFilepath(), "/media/", getSetting("videoDirectory"))#</span>
						<span class="path-input"><input type="text" class="form-control" id="new-path" value="#replaceNoCase(prc.videoData.getFilepath(), "/media/", getSetting("videoDirectory"))#" /></span>
						<button class="btn btn-default pull-right rename">Rename</button>
						<button class="btn btn-success pull-right update update-confirm">Update</button>
						<button class="btn btn-danger pull-right update update-cancel">Cancel</button>
					</td>
				</tr>
				<tr><td align="right">Filename</td><td>#prc.videoData.getFilename()#</td></tr>
				<tr><td align="right">Year</td><td>#prc.videoData.getRelease_year()#</td></tr>
				<tr><td align="right">Genres</td><td>#prc.videoData.getGenres()#</td></tr>
				<tr><td align="right">Overview</td><td>#prc.videoData.getOverview()#</td></tr>
				<tr><td align="right">Runtime</td><td>#prc.videoData.getRuntime()# minutes</td></tr>
				<tr><td align="right">Rating</td><td>#prc.videoData.getVote_average()#/10</td></tr>
			</table>
		</div>
		<div class="col-md-5" id="ajax">
			#renderView('_fragments/tmdb_search')#
		</div>
	</div>
</div>
</cfoutput>