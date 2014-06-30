<cfoutput>
<script src="/includes/js/pages/movie-manager.js"></script>
<br />
<table id = "movie-list" class="table table-striped table-hover">
	<thead>
		<td>Poster</td>
		<td>Title</td>
		<td>Year</td>
		<td>Genres</td>
	</thead>
	<cfloop from="1" to="#arrayLen(prc.videoData)#" index="i">
		<tr class = "item" data-id = "#prc.videoData[i].getID()#">
			<td><img src="/data/poster/#prc.videoData[i].getID()#.jpg" align="left" style="width: 75px;"></td>
			<td>#prc.videoData[i].getTitle()#</td>
			<td>#prc.videoData[i].getRelease_year()#</td>
			<td>#prc.videoData[i].getGenres()#</td>
		</tr>
	</cfloop>
</table>

</cfoutput>