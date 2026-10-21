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

	<script nonce="#event?.getRequestNonce()#">
		var #id#
		  , #id#_config = #config#
		<cfif chart.getType() eq "choropleth">
		  , #id#_geoIsoMap   = #chart.getIsoMapJson()#
		  , #id#_geoDataVals = #chart.getGeoDataJson()#
		  , #id#_init = function() {
				var countries = ChartGeo.topojson.feature( window.choroplethWorldAtlas, window.choroplethWorldAtlas.objects.countries ).features;
				#id#_config.data.labels = countries.map( function( country ) {
					return country.properties.name;
				} );
				#id#_config.data.datasets[ 0 ].data = countries.map( function( country ) {
					var alpha2 = #id#_geoIsoMap[ String( country.id ).padStart( 3, "0" ) ];
					return { feature: country, value: #id#_geoDataVals[ alpha2 ] || 0 };
				} );
				#id# = new Chart( document.getElementById( '#id#' ), #id#_config );
			};
		<cfelse>
		  , #id#_init   = function() {
				#id# = new Chart( document.getElementById( '#id#' ), #id#_config );
		    };
		</cfif>
	</script>
</cfoutput>