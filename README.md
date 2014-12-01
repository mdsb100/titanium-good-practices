titanium-good-practices
=======================

Make titanium easily and powerfully

## On the whole

### Using CLI insteads of titanium studio to create, build, deploy, release or write
Imroving productivity, giving a automated solution
[Titanium Command-Line Interface Reference](http://docs.appcelerator.com/titanium/3.0/#!/guide/Titanium_Command-Line_Interface_Reference)

### You must use [Alloy](http://docs.appcelerator.com/titanium/3.0/#!/guide/Alloy_Quick_Start) to create MVC

#### Make sure the backbone document`s version is 0.9.2 when you read it
>Currently, Alloy is using Backbone version 0.9.2, which is not the most current version of Backbone. The documentation links in the Model guides link to version 0.9.2 of the Backbone documentation. If you go to the official Backbone site, the documentation might be out-of-sync with these guides.


## Improve development efficiency and reduce the error

### Using [jslint](https://github.com/reid/node-jslint) to check code by CLI if you wirte javascript 

### Easily write code by using [CoffeeScript](http://coffeescript.org/), and check code by [coffeelint](http://www.coffeelint.org/)

### Easily write xml by using [jade](https://github.com/jadejs/jade)
Modify alloy.jmk to redirect xml to jade
```
task('pre:compile', function(event, logger) {
    var wrench = require('wrench'),
		fs = require('fs'),
		jade = require('jade'),
		path = require('path'),
		appDir = path.join(event.dir.project, 'app');

	wrench.readdirSyncRecursive(appDir).forEach(function(view) {
		if (view.match(/\.jade$/) && view.indexOf('templates') === -1 && view.indexOf('includes') === -1) {
			try {
				fs.writeFileSync(
					path.join(appDir, view.replace(/\.jade$/, '.xml')),
					jade.compile(fs.readFileSync(path.join(appDir, view)).toString(), {
						filename: path.join(appDir, view),
						pretty: true
					})(event));
			} catch (e) {
				logger.error('ERROR: ' + view + '\n' + JSON.stringify(e));
				process.exit(1);
			}
		}
	});
});
```

