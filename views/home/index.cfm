<cfoutput>
<br />
<div class="well">
	#getSetting("applicationTitle")#
</div>

<div class="row">
	<cfloop query="prc.videoData">
		<div class="col-md-2">
			<div style="padding: 8px 0; height: 350px; text-align: center;">	
				<a href="/watch/#id#">
					<img style="border: 2px solid black;" class="img-responsive" src="/data/poster/#id#.jpg"  />
				</a>
				<span style="display: block; text-align: center;">#title#</span>
			</div>
		</div>
	</cfloop>
</div>
</cfoutput>