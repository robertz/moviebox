<cfoutput>
<cfif prc.searchResults.total_pages gt 1>
	<div class="alert alert-danger">Search returned more data than is displayed! Please narrow your search term!</div>
</cfif>
<input type="text" class="form-control" id="search_term" placeholder="Search for a movie" />
<br />
<input type="button" class="btn btn-default" id="search" value="Go!" />
<br /><br />
<table class="table table-striped">
	<thead>
		<td>Select</td>
		<td>Title</td>
		<td>Year</td>
	</thead>
	<cfloop from="1" to="#arrayLen(prc.searchResults.results)#" index="i">
		<tr>
			<td><a class="btn btn-success" style="text-decoration: none;">Select</a></td>
			<td>#prc.searchResults.results[i].title#</td>
			<td>#listFirst(prc.searchResults.results[i].release_date, "-")#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>