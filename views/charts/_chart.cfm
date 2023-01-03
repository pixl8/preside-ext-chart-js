<cfscript>
	chart     = args.chart  ?: "";
	id        = args.id     ?: "";
	styles    = args.styles ?: "";
	config    = chart.getConfig();
	callbacks = reMatchNoCase( '"callback":"(.*)}"', config );

	for ( var callback in callbacks ) {
		var cb = replace( callback, '"callback":', '' );

		if ( len( cb ) ) {
			config = replace( config, cb, replace( cb, '"', '', 'all') );
		}
	}
</cfscript>

<cfoutput>
	<div class="chart-canvas-container" style="#styles#">
		<canvas id="#id#" class="chart-canvas"></canvas>
	</div>

	<script>
		var #id#
		  , #id#_config = #config#
		  , #id#_init   = function() {
				#id# = new Chart( document.getElementById( '#id#' ), #id#_config );
		    };
	</script>
</cfoutput>