build:
	mkdir -p lib
	rm -rf lib/*
	node_modules/.bin/coffee --compile -m --output lib/ src/

watch:
	node_modules/.bin/coffee --watch --compile --output lib/ src/
	
test:
	node_modules/.bin/mocha

jumpstart:
	curl -u 'meryn' https://api.github.com/user/repos -d '{"name":"send-http-request", "description":"Function that sends a HTTP request, returning promise.","private":false}'
	mkdir -p src
	touch src/send-http-request.coffee
	mkdir -p test
	touch test/send-http-request.coffee
	npm install
	git init
	git remote add origin git@github.com:meryn/send-http-request
	git add .
	git commit -m "jumpstart commit."
	git push -u origin master

.PHONY: test