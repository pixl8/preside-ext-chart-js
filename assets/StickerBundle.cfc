component output=false {

	public void function configure( bundle ) {

		bundle.addAssets(
			  directory   = "/js"
			, match       = function( path ){ return ReFindNoCase( "_[0-9a-f]{8}\..*?\.min.js$", arguments.path ); }
			, idGenerator = function( path ) {
				return ListDeleteAt( path, ListLen( path, "/" ), "/" ) & "/";
			}
		);

		bundle.addAssets(
			  directory   = "/css"
			, match       = function( path ){ return ReFindNoCase( "_[0-9a-f]{8}\..*?\.min.css$", arguments.path ); }
			, idGenerator = function( path ) {
				return ListDeleteAt( path, ListLen( path, "/" ), "/" ) & "/";
			}
		);

		bundle.addAsset( id="chartjs", path="/lib/chartjs/3.4.1/chart.min.js" );

		bundle.addAsset( id="chartjs-chart-sankey", path="/lib/chartjs-chart-sankey/0.14.0/chartjs-chart-sankey.min.js" );
		bundle.asset( "chartjs-chart-sankey" ).after( "chartjs" );

		bundle.addAsset( id="chartjs-chart-geo", path="/lib/chartjs-chart-geo/3.1.0/chartjs-chart-geo.min.js" );
		bundle.asset( "chartjs-chart-geo" ).after( "chartjs" );

		bundle.addAsset( id="world-atlas-110m", path="/lib/world-atlas/world-atlas-110m.js" );
		bundle.asset( "world-atlas-110m" ).after( "chartjs-chart-geo" );
	}

}
