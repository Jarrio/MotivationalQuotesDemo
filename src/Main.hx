package;

import react.native.api.AppRegistry;
import react.native.native_base.icons.ArrowForwardIcon;
import react.native.component.ImageBackground;
import react.native.native_base.Fab;
import react.native.native_base.Spinner;
import externs.Fetch;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.native_base.NativeBaseProvider;
import react.native.native_base.Box;
import react.native.native_base.types.Color;

typedef RandomQuoteResponse = {
	var _id:String;
	var content:String;
	var author:String;
	var authorSlug:String;
	var length:Int;
	var tags:Array<String>;
}

class Main {
	public static function main() {
		AppRegistry.registerComponent('motivation', function() return App);
	}
}

private typedef State = {
	var ?value:String;
	var ?image_url:String;
	var ?quote:RandomQuoteResponse;
	var ?loaded:Bool;
	var ?modal:Bool;
}

@:expose('App')
class App extends ReactComponentOfState<State> {
	
	function new(props) {
		super(props);
		state = {
			image_url: null,
			quote: null,
			loaded: false,
			modal: false,
			value: 'one'
		}
	}
	
	override function componentDidMount() {
		this.fetchQuote();
	}

	private function fetchQuote() {
		Fetch.fetch('https://api.quotable.io/random').then(
			(response) -> {
				response.json().then((json:RandomQuoteResponse) -> {
					this.setState({quote: json, loaded: true}, this.getImageUrl);
				});
			},
			(error) -> { 
				trace('error');
				trace(error);
			}
		);
	}

	private function getImageUrl() {
		var keywords = 'nature';
		if (this.state.quote.tags != null && this.state.quote.tags.length > 0) {
			keywords = '';
			for (tag in this.state.quote.tags) {
				keywords += tag + ',';
			}

			keywords = keywords.substring(0, keywords.length - 1);
		}

		Fetch.fetch('https://source.unsplash.com/featured/?$keywords').then(
			(response) -> {
				this.setState({image_url: response.url});
			},
			(error) -> { 
				trace('error');
				trace(error);
			}
		);
	}

	override function render() {
		var loading = jsx('<Spinner />');
		var icon = jsx('<ArrowForwardIcon />');
		
		
		if (state.loaded && this.state.image_url != null) {
			loading = jsx('
			<ImageBackground source=${{uri: this.state.image_url}} style={{flex: 1}}>
				<Box bg="rgba(0,0,0,0.7)" marginTop={10} border="1px solid rgba(0,0,0,.125)" width="100%" padding={8}>
					${this.state.quote.content}
				</Box>
				<Box bg="rgba(0,0,0,0.7)" _text=${{textAlign: right, italic: true}} padding={1} width="100%">
					${this.state.quote.author}
				</Box>
			</ImageBackground>
			');
		}

		return 	jsx('
			<NativeBaseProvider>
				$loading
				<Fab disabled=${!this.state.loaded} placement=${bottom_right} icon=${icon} onPress=${this.fetchQuote} />
			</NativeBaseProvider>
		');
	}
}

