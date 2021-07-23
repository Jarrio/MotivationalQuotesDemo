package scene;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.api.*;
import react.native.component.*;

class Scene1 extends ReactComponent {
	static var styles = Main.styles;
	
	override function render() {
		trace('hey');
		trace('hey 2');
		var foo = 4 + 3;

		trace(foo);
		trace(foo += 32);
		foo *= 43;
		trace(foo);
		return jsx('
			<View style={styles.container}>

			</View>
		');
	}
}