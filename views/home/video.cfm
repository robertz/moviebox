<cfoutput>
<div id="video-wrap" style="background:rgba(0,0,0,0.5); margin: 48px 0;">
	<div class="row">
		<div class="col-md-6">
			<div style="padding: 24px;">
				<a href="/"><h3>Home</h3></a>
				<h2>#prc.video.title#</h2>
				<p>#prc.video.overview#</p>
				<p>Runtime: #prc.video.runtime# minutes</p>
			</div>
		</div>
		<div class="col-md-6">
			<div style="padding: 24px;">
				<video width="100%" height="100%" 
				src="#prc.video.filePath#/#prc.video.fileName#" 
				type="video/#prc.mediaType#" 
				id="player1" 
				controls="controls" 
				poster="/data/backdrop/#prc.video.id#.jpg"
				preload="auto"></video>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	$('body')
		.css('background-image', 'url(/data/backdrop/#prc.video.id#.jpg)')
		.css('background-size', '100%');
	$('video,audio').mediaelementplayer(/* Options */);

})
</script>

</cfoutput>