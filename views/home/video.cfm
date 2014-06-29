<cfoutput>
<div id="video-wrap" style="background:rgba(0,0,0,0.7); margin: 48px 0;">
	<div class="row">
		<div class="col-md-6">
			<div style="padding: 24px;">
				<a href="/"><h3>Home</h3></a>
				<img src="/data/poster/#prc.video.getID()#.jpg" align="left" style="margin: 16px;">
				<h2>#prc.video.getTitle()# (#prc.video.getRelease_year()#)</h2>
				<h4>#prc.video.getGenres()#</h4>
				<p>#prc.video.getOverview()#</p>
				<p>Runtime: #prc.video.getRuntime()# minutes</p>
			</div>
		</div>
		<div class="col-md-6">
			<div style="padding: 24px;">
				<video width="100%" height="100%" src="#prc.video.getFilepath()#/#prc.video.getFilename()#" type="video/#prc.mediaType#" id="player1" controls="controls" poster="/data/backdrop/#prc.video.getID()#.jpg" preload="auto"></video>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	$('body')
		.css('background', 'url(/data/backdrop/#prc.video.getID()#.jpg) no-repeat center center fixed')
		.css('background-size', 'cover');
	$('video,audio').mediaelementplayer(/* Options */);

})
</script>

</cfoutput>