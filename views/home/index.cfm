<cfoutput>
<br />
<div class="well">
	#getSetting("applicationTitle")#
</div>

<div class="row">
	<cfloop from = "1" to = "#arrayLen(prc.videoData)#" index = "i">
		<div class="col-md-2">
			<div style="padding: 8px 0; height: 350px; text-align: center;">	
				<a href="/watch/#prc.videoData[i].getID()#">
					<img style="border: 2px solid black;" class="img-responsive" src="/data/poster/#prc.videoData[i].getID()#.jpg"  />
				</a>
				<span style="display: block; text-align: center;">#prc.videoData[i].getTitle()#</span>
			</div>
		</div>
	</cfloop>
</div>
</cfoutput>