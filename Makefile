auto: haml coffee

haml:
	haml src/background.haml > lib/background.html

coffee:
	coffee -o lib/ -c src/

watch:
	coffee -o lib/ -cw src/
